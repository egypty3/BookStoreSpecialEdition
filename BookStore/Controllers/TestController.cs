using Microsoft.AspNetCore.Mvc;

namespace BookStore.Controllers
{
	public class TestController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
