using BookStore.Data;
using BookStore.Models.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using Utility;

namespace BookStore.Areas.Customer.Controllers
{
    [Area("Customer")]
    [Authorize]
    public class CartController : Controller
    {
		private ApplicationDbContext _db;
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
			};
			foreach (var cart in ShoppingCartVM.ListCart)
			{
				cart.Price = GetPriceBasedOnQuantity(cart.Count, cart.Product.Price,
					cart.Product.Price50, cart.Product.Price100);
                ShoppingCartVM.CartTotal += (cart.Price * cart.Count);
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
			};

			foreach (var cart in ShoppingCartVM.ListCart)
			{
				cart.Price = GetPriceBasedOnQuantity(cart.Count, cart.Product.Price,
					cart.Product.Price50, cart.Product.Price100);
				ShoppingCartVM.CartTotal += (cart.Price * cart.Count);
			}
			return View(ShoppingCartVM);
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
