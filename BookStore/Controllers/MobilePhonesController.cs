using BookStore.Data;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Controllers
{
	public class MobilePhonesController : Controller
	{
		public IActionResult Index()
		{
			var myList = Phones.GetPhonesList();

			return View(myList);
		}
	}
}
