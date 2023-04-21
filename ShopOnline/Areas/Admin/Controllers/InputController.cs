using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class InputController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/Input
        public ActionResult Index()
        {
            ViewBag.ProductList = new SelectList(db.Products, "ProductID", "ProductName");
            var pro = db.Products.Include(p => p.ProductID).ToList();
            return View(pro);
        }
        public ActionResult Index(string productId)
        {
            ViewBag.ProductList = new SelectList(db.Products, "ProductID", "ProductName");
            var pro = db.Products.Include(p => p.ProductID).ToList();
            return View(pro);

        }
    }
}