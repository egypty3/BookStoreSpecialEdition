using BookStore.Data;
using BookStore.Models;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class CompanyController : Controller
	{
		private ApplicationDbContext _db;
		public CompanyController(ApplicationDbContext db)
		{
			_db = db;
		}

		public IActionResult Index()
		{
			return View();
		}

		//GET
		public IActionResult Upsert(int? id)
		{
			Company company = new();

			if (id == null || id == 0)
			{
				return View(company);
			}
			else
			{
				company = _db.Companies.FirstOrDefault(u => u.Id == id);
				return View(company);
			}
		}

		//POST
		[HttpPost]
		[ValidateAntiForgeryToken]
		public IActionResult Upsert(Company obj)
		{

			if (ModelState.IsValid)
			{

				if (obj.Id == 0)
				{
					_db.Companies.Add(obj);
					TempData["success"] = "Company created successfully";
				}
				else
				{
					_db.Companies.Update(obj);
					TempData["success"] = "Company updated successfully";
				}
				_db.SaveChanges();

				return RedirectToAction("Index");
			}
			return View(obj);
		}



		#region API CALLS
		[HttpGet]
		public IActionResult GetAll()
		{
			var companyList = _db.Companies.ToList();
			return Json(new { data = companyList });
		}

		//POST
		[HttpDelete]
		public IActionResult Delete(int? id)
		{
			var obj = _db.Companies.FirstOrDefault(u => u.Id == id);
			if (obj == null)
			{
				return Json(new { success = false, message = "Error while deleting" });
			}

			_db.Companies.Remove(obj);
			_db.SaveChanges();
			return Json(new { success = true, message = "Delete Successful" });

		}
		#endregion
	}
}
