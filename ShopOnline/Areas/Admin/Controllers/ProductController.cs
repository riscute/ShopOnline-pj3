using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/Pro
        [Authorize(Roles = "admin, employee")]
        public ActionResult ViewPro(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var q = new List<Product>();
            q = db.Products.ToList();
            int pageSize = 5;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.ProductID).ToList();
            return View(q.ToPagedList(pageNumber, pageSize));
        }
        public static List<CategoryProduct> SelectAllArticle1()
        {
            var rtn = new List<CategoryProduct>();
            using (var context = new ProjectOnlineEntities())
            {
                foreach (var item in context.CategoryProducts)
                {
                    rtn.Add(new CategoryProduct
                    {
                        CateID = item.CateID,
                        CateName = item.CateName,
                    });
                }
            }
            return rtn;
        }
        [Authorize(Roles = "admin")]
        public ActionResult Pro()
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            Product product = new Product();
            List<CategoryProduct> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "CateID", "CateName", "");
            return View(product);
        }
        [HttpPost]
        public ActionResult Pro(Product model)
        {
            RandomGenerator_Product randomGenerator = new RandomGenerator_Product();
            Product pro = new Product();
            List<CategoryProduct> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "CateID", "CateName", 1);
            pro.CateProduct = model.CateProduct;
            pro.ProductID = randomGenerator.Generate() + model.CateProduct;
            pro.ProductName = model.ProductName;
            pro.Amount = model.Amount;
            pro.Price = model.Price;
            pro.Detail = model.Detail;
            pro.Warranty = model.Warranty;
            pro.Status = true;
            string fileName = Path.GetFileNameWithoutExtension(model.UploadImage.FileName);
            string extension = Path.GetExtension(model.UploadImage.FileName);
            fileName = fileName + DateTime.Now.ToString("yymmssfff") + extension;
            model.Image = fileName;
            fileName = Path.Combine(Server.MapPath("~/Content/Images/"), fileName);
            model.UploadImage.SaveAs(fileName);
            pro.Image = model.Image;
            db.Products.Add(pro);
            db.SaveChanges();

            return RedirectToAction("ViewPro");
        }
        [Authorize(Roles = "admin")]
        public ActionResult EditPro(string id)
        {
            List<CategoryProduct> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "CateID", "CateName", "");
            var data = db.Products.Where(x => x.ProductID == id).FirstOrDefault();
            return View(data);
        }
        [HttpPost]
        public ActionResult EditPro(string id, Product Pro)
        {
            List<CategoryProduct> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "CateID", "CateName", "");
            Pro.ProductID = id;
            string fileName = Path.GetFileNameWithoutExtension(Pro.UploadImage.FileName);
            string extension = Path.GetExtension(Pro.UploadImage.FileName);
            fileName = fileName + DateTime.Now.ToString("yymmssfff") + extension;
            Pro.Image = fileName;
            fileName = Path.Combine(Server.MapPath("~/Content/Images/"), fileName);
            Pro.UploadImage.SaveAs(fileName);
            Pro.Image = Pro.Image;
            db.Entry(Pro).State = System.Data.Entity.EntityState.Modified;

            db.SaveChanges();

            return RedirectToAction("ViewPro");
        }
        [Authorize(Roles = "admin")]
        public ActionResult DeletePro(string id)
        {
            var model = db.Products.Find(id);
            db.Products.Remove(model);
            db.SaveChanges();
            return RedirectToAction("ViewPro");
          
        }
       
        [HttpGet]
        public ActionResult Search(string keyword, int? page)
        {
            if (keyword.Equals(""))
            {
                return RedirectToAction("ViewPro", "Product");
            }
            else
            {
                var q = db.Products.Where(a => a.ProductName.ToLower().Contains(keyword.ToLower()) || a.ProductID.ToLower().Contains(keyword.ToLower())).ToList();
                int pageSize = 4;
                int pageNumber = (page ?? 1);
                q = q.OrderByDescending(n => n.ProductID).ToList();
                ViewBag.keyword = keyword;
                return View("ViewPro", q.ToPagedList(pageNumber, pageSize));
            }
        }
    }
}