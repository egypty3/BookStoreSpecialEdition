using BookStore.Data;
using BookStore.Models;
using BookStore.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class ProductController : Controller
    {
        private ApplicationDbContext _db;
        private IWebHostEnvironment _hostEnviroment;
        public ProductController(ApplicationDbContext db, IWebHostEnvironment hostEnvironment)
        {
            _db = db;
            _hostEnviroment = hostEnvironment;
        }
        public IActionResult Index()
        {
            return View();
        }

        // GET 
        public IActionResult Upsert(int? id)
        {
            ProductVM productVM = new()
            {
                Product = new(),
                CategoryList = _db.Categories.Select(i => new SelectListItem
                {
                    Text = i.Name,
                    Value = i.Id.ToString()
                }),
                CoverTypeList = _db.CoverTypes.Select(i => new SelectListItem
                {
                    Text = i.Name,
                    Value = i.Id.ToString()
                })
            };

            if (id == null || id == 0)
            {

                // create product
                //ViewBag.CategoryList = CategoryList;
                //ViewData["CoverTypeList"] = CoverTypeList;
                return View(productVM);
            }
            else
            {
                // update product

                var productFromDB = _db.Products.FirstOrDefault(u => u.Id == id);
                if (productFromDB != null)
                {
                    productVM.Product = productFromDB;
                    return View(productVM);
                }
                else
                {
                    return NotFound();
                }

            }
        }
        //POST 
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Upsert(ProductVM obj, IFormFile? file)
        {
            if (obj.Product.Price100 > obj.Product.Price50)
            {
                ModelState.AddModelError("Price100",
                    "Price for  100+ quantity could not be hight that price for 51-100 quantity");
            }
            if (ModelState.IsValid)
            {
                string wwwRootPath = _hostEnviroment.WebRootPath;
                if (file != null)
                {
                    string fileName = Guid.NewGuid().ToString();
                    var uploads = Path.Combine(wwwRootPath, @"images\products");
                    var extension = Path.GetExtension(file.FileName);

                    if (obj.Product.ImageUrl != null)
                    {
                        var oldImagePath = Path.Combine(wwwRootPath, obj.Product.ImageUrl.TrimStart('\\'));
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    using (
                            var fileStream = new FileStream(
                            Path.Combine(uploads, fileName + extension)
                            ,
                            FileMode.Create)
                        )
                    {
                        file.CopyTo(fileStream);
                    }
                    obj.Product.ImageUrl = @"\images\products\" + fileName + extension;
                }
                if (obj.Product.Id == 0)
                {
                    // Create Product
                    _db.Products.Add(obj.Product);
                }
                else
                {
                    // Update Product
                    var objFromDb = _db.Products.FirstOrDefault(u => u.Id == obj.Product.Id);
                    if (objFromDb != null)
                    {
                        objFromDb.Title = obj.Product.Title;
                        objFromDb.ISBN = obj.Product.ISBN;
                        objFromDb.Price = obj.Product.Price;
                        objFromDb.Price50 = obj.Product.Price50;
                        objFromDb.Price100 = obj.Product.Price100;
                        objFromDb.Description = obj.Product.Description;
                        objFromDb.CategoryId = obj.Product.CategoryId;
                        objFromDb.Author = obj.Product.Author;
                        objFromDb.CoverTypeID = obj.Product.CoverTypeID;

                        if (file != null)
                        {
                            objFromDb.ImageUrl = obj.Product.ImageUrl;
                        }
                        _db.Products.Update(objFromDb);

                    }
                }
                _db.SaveChanges();
                TempData["success"] = "Product created successfully";
                return RedirectToAction("Index");
            }
            return View(obj);
        }

        #region API CALLs
        [HttpGet]
        public IActionResult GetALL()
        {
            var productList = _db.Products
                .Include(p => p.Category)
                .Include(p => p.CoverType)
                .ToList();
            return Json(new { data = productList });
        }

        [HttpDelete]
        public IActionResult Delete(int id)
        {
            var obj = _db.Products.FirstOrDefault(u => u.Id == id);
            if (obj == null)
            {
                return Json(new { success = false, message = "Error while deleting" });
            }
            // delete the product image from server file system
            var oldImagePath = Path.Combine(_hostEnviroment.WebRootPath, obj.ImageUrl.TrimStart('\\'));
            if (System.IO.File.Exists(oldImagePath))
            {
                System.IO.File.Delete(oldImagePath);
            }
            // delete product row from db
            _db.Products.Remove(obj);
            _db.SaveChanges();
            return Json(new { success = true, message = "Delete Successful" });
        }
        #endregion
    }
}
