using BookStore.Data;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class MobilePhonesController : Controller
	{
		public IActionResult Index()
		{
			var myList = Phones.GetPhonesList();

			return View(myList);
		}
	}
}
