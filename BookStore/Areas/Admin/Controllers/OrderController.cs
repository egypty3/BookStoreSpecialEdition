
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using BookStore.Data;
using BookStore.Models;
using BookStore.Models.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Stripe;
using Stripe.BillingPortal;
using Stripe.Checkout;
using Utility;
//using Admin.Models;

namespace Admin.Controllers
{
    [Area("Admin")]
    [Authorize]
    public class OrderController : Controller
    {
        private ApplicationDbContext _db;
        [BindProperty]
        public OrderVM OrderVM { get; set; }

        public OrderController(ApplicationDbContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult Details(int orderId)
        {
            OrderVM = new OrderVM()
            {
                OrderHeader = _db.OrderHeaders.Include(u => u.ApplicationUser).FirstOrDefault(u => u.Id == orderId),
                OrderDetail = _db.OrderDetail.Include(u => u.Product).Where(u => u.OrderId == orderId).ToList()
            };
            return View(OrderVM);

        }
        [ActionName("Details")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DetailsـPAY_NOW()
        {
            OrderVM = new OrderVM()
            {
                OrderHeader = _db.OrderHeaders.Include(u => u.ApplicationUser).FirstOrDefault(u => u.Id == OrderVM.OrderHeader.Id),
                OrderDetail = _db.OrderDetail.Include(u => u.Product).Where(u => u.OrderId == OrderVM.OrderHeader.Id).ToList()
            };

            // stripe settings
            var domain = "https://localhost:5013/";
            var options = new Stripe.Checkout.SessionCreateOptions
            {
                PaymentMethodTypes = new List<string>
                {
                    "card",
                },
                LineItems = new List<SessionLineItemOptions>(),
                Mode = "payment",
                SuccessUrl = domain + $"admin/order/PaymentConfirmation?orderHeaderId={OrderVM.OrderHeader.Id}",
                CancelUrl = domain + $"admin/order/details?",
            };

            foreach (var item in OrderVM.OrderDetail)
            {

                var sessionLineItem = new SessionLineItemOptions
                {
                    PriceData = new SessionLineItemPriceDataOptions
                    {
                        UnitAmount = (long)(item.Price * 100),//20.00 -> 2000
                        Currency = "usd",
                        ProductData = new SessionLineItemPriceDataProductDataOptions
                        {
                            Name = item.Product.Title
                        },

                    },
                    Quantity = item.Count,
                };
                options.LineItems.Add(sessionLineItem);

            }
            var service = new Stripe.Checkout.SessionService();
            Stripe.Checkout.Session session = service.Create(options);

            OrderVM.OrderHeader.SessionId = session.Id;
            OrderVM.OrderHeader.PaymentDate = DateTime.Now;
            OrderVM.OrderHeader.PaymentIntentId = session.PaymentIntentId;

            _db.OrderHeaders.Update(OrderVM.OrderHeader);
            _db.SaveChanges();

            Response.Headers.Add("Location", session.Url);
            return new StatusCodeResult(303);
        }

        public IActionResult PaymentConfirmation(int orderHeaderId)
        {
            OrderHeader orderHeader = _db.OrderHeaders
                .Include(u => u.ApplicationUser)
                .FirstOrDefault(u => u.Id == orderHeaderId);

            if (orderHeader.PaymentStatus == SD.PaymentStatusDelayedPayment)
            {
                var service = new Stripe.Checkout.SessionService();
                Stripe.Checkout.Session session = service.Get(orderHeader.SessionId);
                // check the stripe status
                if (session.PaymentStatus == "paid")
                {
                    orderHeader.PaymentIntentId = session.PaymentIntentId;
                    orderHeader.PaymentStatus = SD.PaymentStatusApproved;

                    _db.OrderHeaders.Update(orderHeader);
                    _db.SaveChanges();
                }
            }

            return View(orderHeaderId);
        }


        [HttpPost]
        [Authorize(Roles = SD.Role_Admin + "," + SD.Role_Employee)]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateOrderDetail()
        {
            var orderHeaderFromDb = _db.OrderHeaders.FirstOrDefault(u => u.Id == OrderVM.OrderHeader.Id);
            orderHeaderFromDb.Name = OrderVM.OrderHeader.Name;
            orderHeaderFromDb.PhoneNumber = OrderVM.OrderHeader.PhoneNumber;
            orderHeaderFromDb.StreetAddress = OrderVM.OrderHeader.StreetAddress;
            orderHeaderFromDb.City = OrderVM.OrderHeader.City;
            orderHeaderFromDb.State = OrderVM.OrderHeader.State;
            orderHeaderFromDb.PostalCode = OrderVM.OrderHeader.PostalCode;
            if (OrderVM.OrderHeader.Carrier != null)
            {
                orderHeaderFromDb.Carrier = OrderVM.OrderHeader.Carrier;
            }
            if (OrderVM.OrderHeader.TrackingNumber != null)
            {
                orderHeaderFromDb.TrackingNumber = OrderVM.OrderHeader.TrackingNumber;
            }
            _db.OrderHeaders.Update(orderHeaderFromDb);
            _db.SaveChanges();
            TempData["Success"] = "Order Details Updated Successfully";
            return RedirectToAction("Details", "Order", new { orderId = orderHeaderFromDb.Id });
        }

        [HttpPost]
        [Authorize(Roles = SD.Role_Admin + "," + SD.Role_Employee)]
        [ValidateAntiForgeryToken]
        public IActionResult StartProcessing()
        {
            var orderHeaderFromDb = _db.OrderHeaders.FirstOrDefault(u => u.Id == OrderVM.OrderHeader.Id);
            if (orderHeaderFromDb != null)
            {
                orderHeaderFromDb.OrderStatus = SD.StatusInProcess;
            }
            _db.OrderHeaders.Update(orderHeaderFromDb);
            _db.SaveChanges();
            TempData["Success"] = "Order Status Updated Successfully";
            return RedirectToAction("Details", "Order", new { orderId = orderHeaderFromDb.Id });
        }
        [HttpPost]
        [Authorize(Roles = SD.Role_Admin + "," + SD.Role_Employee)]
        [ValidateAntiForgeryToken]
        public IActionResult ShipOrder()
        {
            var orderHeader = _db.OrderHeaders.FirstOrDefault(u => u.Id == OrderVM.OrderHeader.Id);
            orderHeader.TrackingNumber = OrderVM.OrderHeader.TrackingNumber;
            orderHeader.Carrier = OrderVM.OrderHeader.Carrier;
            orderHeader.OrderStatus = SD.StatusShipped;
            orderHeader.ShippingDate = DateTime.Now;
            if (orderHeader.PaymentStatus == SD.PaymentStatusDelayedPayment)
            {
                orderHeader.PaymentDueDate = DateTime.Now.AddDays(30);
            }
            _db.OrderHeaders.Update(orderHeader);
            _db.SaveChanges();
            TempData["Success"] = "Order Shipped Successfully.";
            return RedirectToAction("Details", "Order", new { orderId = OrderVM.OrderHeader.Id });
        }
        public IActionResult CancelOrder()
        {
            var orderHeader = _db.OrderHeaders.FirstOrDefault(u => u.Id == OrderVM.OrderHeader.Id);
            if (orderHeader.PaymentStatus == SD.PaymentStatusApproved)
            {
                var options = new RefundCreateOptions
                {
                    Reason = RefundReasons.RequestedByCustomer,
                    PaymentIntent = orderHeader.PaymentIntentId
                };
                var service = new RefundService();
                Refund refund = service.Create(options);
                orderHeader.OrderStatus = SD.StatusCancelled;
                orderHeader.PaymentStatus = SD.StatusRefunded;
            }
            else
            {
                orderHeader.OrderStatus = SD.StatusCancelled;
                orderHeader.PaymentStatus = SD.StatusCancelled;
            }

            _db.OrderHeaders.Update(orderHeader);
            _db.SaveChanges();
            TempData["Success"] = "Order Cancelled Successfully.";
            return RedirectToAction("Details", "Order", new
            {
                orderId = OrderVM.OrderHeader.Id
            });
        }
        #region API CALLs
        [HttpGet]
        public IActionResult GetALL(string status)
        {
            IEnumerable<OrderHeader> orderHeaders;

            if (User.IsInRole(SD.Role_Admin) || User.IsInRole(SD.Role_Employee))
            {
                orderHeaders = _db.OrderHeaders
                  .Include(p => p.ApplicationUser)
                  .ToList();
            }
            else
            {
                var claimsIdentity = (ClaimsIdentity)User.Identity;
                var claim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

                orderHeaders = _db.OrderHeaders
                    .Where(u => u.ApplicationUserId == claim.Value)
                    .Include(p => p.ApplicationUser)
                    .ToList();
            }

            switch (status)
            {

                case "pending":
                    orderHeaders = orderHeaders.Where(u => u.PaymentStatus == SD.PaymentStatusDelayedPayment);
                    break;
                case "inprocess":
                    orderHeaders = orderHeaders.Where(u => u.OrderStatus == SD.StatusInProcess);
                    break;
                case "completed":
                    orderHeaders = orderHeaders.Where(u => u.OrderStatus == SD.StatusShipped);
                    break;
                case "approved":
                    orderHeaders = orderHeaders.Where(u => u.OrderStatus == SD.StatusApproved);
                    break;
                default:
                    break;
            }
            return Json(new { data = orderHeaders });
        }
        #endregion
    }
}