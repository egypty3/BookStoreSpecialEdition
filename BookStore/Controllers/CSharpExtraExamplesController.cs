using Microsoft.AspNetCore.Mvc;

namespace BookStore.Controllers
{
    public class CSharpExtraExamplesController : Controller
    {
        public IActionResult LambdaExample1()
        {
            var myArray = new int[] { 1, 2, 3 , 8 , 33, 55,22, 20 ,4, 8};
            var newArray = myArray.Where(n => n > 5);
            ViewBag.newArray = newArray;
            return View();
        }

        public IActionResult LambdaExample2()
        {
            Func<int , int > fun = i => i * i;
            return Content("Lambda expression example  : " + fun(5));
        }
		public IActionResult LambdaExample3()
		{
            var students = new string[] { "Amr", "Ahmed", "Alaa", "Moataz", "Reda" };
            var studentsFirst3Letters = students.Select(s => s.Substring(0, 3));
			ViewBag.studentsFirst3Letters = studentsFirst3Letters;
			return View();
		}
	}
}
