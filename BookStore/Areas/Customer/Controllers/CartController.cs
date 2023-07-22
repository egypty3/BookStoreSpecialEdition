using BookStore.Data;
using BookStore.Models.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

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

			return View(ShoppingCartVM);
        }
    }
}
