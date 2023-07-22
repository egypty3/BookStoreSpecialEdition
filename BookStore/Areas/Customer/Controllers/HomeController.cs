using BookStore.Data;
using BookStore.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using System.Security.Claims;
using Utility;

namespace BookStore.Areas.Customer.Controllers
{
    [Area("Customer")]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
		private ApplicationDbContext _db;

		public HomeController(ILogger<HomeController> logger, ApplicationDbContext db)
        {
			_db = db;
			_logger = logger;
        }

        public IActionResult Index()
        {
			IEnumerable<Product> productList = _db.Products
				.Include(p => p.Category)
				.Include(p => p.CoverType)
				.ToList();

			return View(productList);
		}
		public IActionResult Details(int productId)
		{
			ShoppingCart cartObj = new()
			{
				Count = 1,
				ProductId = productId,
				Product = _db.Products
				.Include(p => p.Category)
				.Include(p => p.CoverType).FirstOrDefault(u => u.Id == productId)
			};

			return View(cartObj);
		}
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize]
        public IActionResult Details(ShoppingCart shoppingCart)
        {
            var claimsIdentity = (ClaimsIdentity)User.Identity;
            var claim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);
            shoppingCart.ApplicationUserId = claim.Value;
            
            _db.ShoppingCarts.Add(shoppingCart);
            _db.SaveChanges();


            return RedirectToAction(nameof(Index));
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}