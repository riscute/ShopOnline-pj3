using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class WareHouseController : Controller
    {
        // GET: Admin/WareHouse
        ProjectOnlineEntities db = new ProjectOnlineEntities();
        [Authorize(Roles = "admin, employee")]
        public ActionResult Index()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            return View(db.WareHouses.ToList());
        }
        public static List<Product> SelectAllArticle1()
        {
            var rtn = new List<Product>();
            using (var context = new ProjectOnlineEntities())
            {
                foreach (var item in context.Products)
                {
                    rtn.Add(new Product
                    {
                        ProductID = item.ProductID,
                        ProductName = item.ProductName,
                    });
                }
            }
            return rtn;
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult InsertWareHouse()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }

            WareHouse wareHouse = new WareHouse();
            List<Product> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "ProductID", "ProductName", "");
            return View();
        }
        [HttpPost]
        public ActionResult InsertWareHouse(WareHouse model)
        {
            WareHouse house = new WareHouse();
            List<Product> list = SelectAllArticle1().ToList();
            ViewBag.listCate = new SelectList(list, "ProductID", "ProductName", "");
            house.WareHouseID = model.WareHouseID;
            house.AmountInput = model.AmountInput;
            house.ProductID = model.ProductID;
            house.DateInput = DateTime.Now;
            db.WareHouses.Add(house);
            db.SaveChanges();
            return RedirectToAction("Index");

        }
        
    }
}