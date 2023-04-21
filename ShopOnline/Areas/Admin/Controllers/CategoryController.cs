using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        ProjectOnlineEntities db = new ProjectOnlineEntities();
        // GET: Admin/Category
        [Authorize(Roles = "admin, employee")]
        // GET: Admin/Category
        public ActionResult ViewCategory(int? page)
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var q = new List<CategoryProduct>();
            q = db.CategoryProducts.ToList();
            int pageSize = 5;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.CateID).ToList();
            return View(q.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult CreateCate()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            CategoryProduct cate = new CategoryProduct();
            return View(cate);
        }
        [HttpPost]
        public ActionResult CreateCate(CategoryProduct model)
        {
            if (db.CategoryProducts.Where(x => x.CateName.Contains(model.CateName)).Count() > 0)
            {
                return View();
            }
            else
            {

            CategoryProduct cate = new CategoryProduct();
            RandomGenerator randomGenerator = new RandomGenerator();
            cate.CateID = randomGenerator.Generate();
            cate.CateName = model.CateName;
            cate.Status = model.Status;
            db.CategoryProducts.Add(cate);
            db.SaveChanges();
            return RedirectToAction("ViewCategory");
            }
        }
            [Authorize(Roles = "admin, employee")]
        public ActionResult EditCate()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            return View();
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult DeleteCate()
        {
            return View();
        }
    }
}