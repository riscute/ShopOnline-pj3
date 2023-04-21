using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Controllers
{
    public class ProductController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Product

        public ActionResult Index(int? page)
        {
            var q = new List<Product>();
            q = db.Products.ToList();
            int pageSize = 6;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.ProductID).ToList();
            return View(q.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Product()
        {
            return View();
        }
        public ActionResult CategoryProduct()
        {
            return View();
        }
        public PartialViewResult ProductCategory()
        {
            var q = db.CategoryProducts.ToList();
            return PartialView(q);
        }
        public ActionResult ProductDetail(string id)
        {
            Product d = db.Products.Find(id);
            return View(d);
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
        public ActionResult FindProByCate(string cateId, int? page)
        {
            var products = new List<Product>();
            products = db.Products.Where(x => x.CateProduct.Equals(cateId)).ToList();
            //int pageSize = 1;
            //int pageNumber = (page ?? 1);
            //ViewBag.idCate = cateId;
            //products = products.OrderByDescending(n => n.ProductID).ToList();
            // return View(products.ToPagedList(pageNumber, pageSize));
            return View(products);
        }
        public PartialViewResult ListPro()
        {
            List<Product> q = db.Products.Take(5).ToList();
            q = q.OrderByDescending(x => x.ProductID).ToList();
            return PartialView(q);
        }
      
        [HttpGet]
        public ActionResult Search(string keyword)
        {
            var q = db.Products.Where(a => a.ProductName.ToLower().Contains(keyword.ToLower())).ToList();
            ViewBag.keyword = keyword;
            ViewBag.model = q;
            return View("FindProByCate", q);
        }
    }
}