using BookStore.Data;
using BookStore.Models;
using BookStore.Models.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Stripe.Checkout;
using System.Security.Claims;
using Utility;

namespace BookStore.Areas.Customer.Controllers
{
	[Area("Customer")]
	[Authorize]
	public class CartController : Controller
	{
		private ApplicationDbContext _db;
		[BindProperty]
		public ShoppingCartVM ShoppingCartVM { get; set; }
		public CartController(ApplicationDbContext db)
		{
			_db = db;
		}
		public IActionResult Index()
		{
			var claimsIdentity = (ClaimsIdentity)User.Identity;
			var claim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

			ShoppingCartVM = new ShoppingCartVM()
			{
				ListCart = _db.ShoppingCarts
				.Include(s => s.Product)
				.Where(u => u.ApplicationUserId == claim.Value),
				OrderHeader = new()
			};
			foreach (var cart in ShoppingCartVM.ListCart)
			{
				cart.Price = GetPriceBasedOnQuantity(cart.Count, cart.Product.Price,
					cart.Product.Price50, cart.Product.Price100);
				ShoppingCartVM.OrderHeader.OrderTotal += (cart.Price * cart.Count);
			}
			return View(ShoppingCartVM);
		}

		public IActionResult Summary()
		{
			var claimsIdentity = (ClaimsIdentity)User.Identity;
			var claim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

			ShoppingCartVM = new ShoppingCartVM()
			{
				ListCart = _db.ShoppingCarts
				.Include(s => s.Product)
				.Where(u => u.ApplicationUserId == claim.Value),
				OrderHeader = new()
			};
			ShoppingCartVM.OrderHeader.ApplicationUser = _db.ApplicationUsers.FirstOrDefault(
				u => u.Id == claim.Value);

			ShoppingCartVM.OrderHeader.Name = ShoppingCartVM.OrderHeader.ApplicationUser.Name;
			ShoppingCartVM.OrderHeader.PhoneNumber = ShoppingCartVM.OrderHeader.ApplicationUser.PhoneNumber;
			ShoppingCartVM.OrderHeader.StreetAddress = ShoppingCartVM.OrderHeader.ApplicationUser.StreetAddress;
			ShoppingCartVM.OrderHeader.City = ShoppingCartVM.OrderHeader.ApplicationUser.City;
			ShoppingCartVM.OrderHeader.State = ShoppingCartVM.OrderHeader.ApplicationUser.State;
			ShoppingCartVM.OrderHeader.PostalCode = ShoppingCartVM.OrderHeader.ApplicationUser.PostalCode;

			foreach (var cart in ShoppingCartVM.ListCart)
			{
				cart.Price = GetPriceBasedOnQuantity(cart.Count, cart.Product.Price,
					cart.Product.Price50, cart.Product.Price100);
				ShoppingCartVM.OrderHeader.OrderTotal += (cart.Price * cart.Count);
			}
			return View(ShoppingCartVM);
		}

		[HttpPost]
		[ActionName("Summary")]
		[ValidateAntiForgeryToken]
		public IActionResult SummaryPOST()
		{
			var claimsIdentity = (ClaimsIdentity)User.Identity;
			var claim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

			ShoppingCartVM.ListCart = _db.ShoppingCarts
				.Include(s => s.Product)
				.Where(u => u.ApplicationUserId == claim.Value);

			ShoppingCartVM.OrderHeader.OrderDate = System.DateTime.Now;
			ShoppingCartVM.OrderHeader.ApplicationUserId = claim.Value;


			foreach (var cart in ShoppingCartVM.ListCart)
			{
				cart.Price = GetPriceBasedOnQuantity(cart.Count, cart.Product.Price,
					cart.Product.Price50, cart.Product.Price100);
				ShoppingCartVM.OrderHeader.OrderTotal += (cart.Price * cart.Count);
			}
			ApplicationUser applicationUser = _db.ApplicationUsers
				.FirstOrDefault(u => u.Id == claim.Value);

			if (applicationUser.CompanyId.GetValueOrDefault() == 0)
			{
				ShoppingCartVM.OrderHeader.PaymentStatus = SD.PaymentStatusPending;
				ShoppingCartVM.OrderHeader.OrderStatus = SD.StatusPending;
			}
			else
			{
				ShoppingCartVM.OrderHeader.PaymentStatus = SD.PaymentStatusDelayedPayment;
				ShoppingCartVM.OrderHeader.OrderStatus = SD.StatusApproved;
			}

			_db.OrderHeaders.Add(ShoppingCartVM.OrderHeader);
			_db.SaveChanges();

			foreach (var cart in ShoppingCartVM.ListCart)
			{
				OrderDetail orderDetail = new()
				{
					ProductId = cart.ProductId,
					OrderId = ShoppingCartVM.OrderHeader.Id,
					Price = cart.Price,
					Count = cart.Count
				};
				_db.OrderDetail.Add(orderDetail);
			}
			_db.SaveChanges();

			if (applicationUser.CompanyId.GetValueOrDefault() == 0)
			{
				// stripe settings
				var domain = "https://localhost:5013/";
				var options = new SessionCreateOptions
				{
					PaymentMethodTypes = new List<string>
				{
					"card",
				},
					LineItems = new List<SessionLineItemOptions>(),
					Mode = "payment",
					SuccessUrl = domain + $"customer/cart/OrderConfirmation?id={ShoppingCartVM.OrderHeader.Id}",
					CancelUrl = domain + $"customer/cart/index",
				};

				foreach (var item in ShoppingCartVM.ListCart)
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
				var service = new SessionService();
				Session session = service.Create(options);

				ShoppingCartVM.OrderHeader.SessionId = session.Id;
				ShoppingCartVM.OrderHeader.PaymentDate = DateTime.Now;
				ShoppingCartVM.OrderHeader.PaymentIntentId = session.PaymentIntentId;

				_db.OrderHeaders.Update(ShoppingCartVM.OrderHeader);
				_db.SaveChanges();

				Response.Headers.Add("Location", session.Url);
				return new StatusCodeResult(303);
			}
			else
			{
				return RedirectToAction("OrderConfirmation", "Cart", new { id = ShoppingCartVM.OrderHeader.Id });
				//
			}

			//_db.ShoppingCarts.RemoveRange(ShoppingCartVM.ListCart);
			//_db.SaveChanges();
			//return RedirectToAction("Index", "Home");
		}
		public IActionResult OrderConfirmation(int id)
		{
			OrderHeader orderHeader = _db.OrderHeaders
				.Include(u => u.ApplicationUser)
				.FirstOrDefault(u => u.Id == id);

			if (orderHeader.PaymentStatus != SD.PaymentStatusDelayedPayment)
			{
				var service = new SessionService();
				Session session = service.Get(orderHeader.SessionId);
				// check the stripe status
				if (session.PaymentStatus == "paid")
				{
					orderHeader.PaymentStatus = SD.PaymentStatusApproved;
					orderHeader.OrderStatus = SD.StatusApproved;
					_db.OrderHeaders.Update(orderHeader);
					_db.SaveChanges();
				}
			}


			List<ShoppingCart> shoppingCarts = _db.ShoppingCarts
				.Include(s => s.Product)
				.Where(u => u.ApplicationUserId == orderHeader.ApplicationUserId)
				.ToList();

			_db.ShoppingCarts.RemoveRange(shoppingCarts);
			_db.SaveChanges();
			return View(id);
		}
		public IActionResult Plus(int cartId)
		{
			var cart = _db.ShoppingCarts.FirstOrDefault(u => u.Id == cartId);
			cart.Count++;
			_db.ShoppingCarts.Update(cart);
			_db.SaveChanges();
			return RedirectToAction(nameof(Index));
		}

		public IActionResult Minus(int cartId)
		{
			var cart = _db.ShoppingCarts.FirstOrDefault(u => u.Id == cartId);
			if (cart.Count <= 1)
			{
				_db.ShoppingCarts.Remove(cart);
				var count = _db.ShoppingCarts
					.Where(u => u.ApplicationUserId == cart.ApplicationUserId).ToList().Count - 1;
			}
			else
			{
				cart.Count--;
				_db.ShoppingCarts.Update(cart);
			}
			_db.SaveChanges();
			return RedirectToAction(nameof(Index));
		}

		public IActionResult Remove(int cartId)
		{
			var cart = _db.ShoppingCarts.FirstOrDefault(u => u.Id == cartId);
			_db.ShoppingCarts.Remove(cart);
			_db.SaveChanges();

			var count = _db.ShoppingCarts.Select(u => u.ApplicationUserId == cart.ApplicationUserId).ToList().Count;
			return RedirectToAction(nameof(Index));
		}

		private double GetPriceBasedOnQuantity(double quantity, double price, double price50, double price100)
		{
			if (quantity <= 50)
			{
				return price;
			}
			else
			{
				if (quantity <= 100)
				{
					return price50;
				}
				return price100;
			}
		}
	}
}
