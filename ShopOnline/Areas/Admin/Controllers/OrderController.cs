using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class OrderController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/Order
        [Authorize(Roles = "admin, employee")]
        public ActionResult ViewOrd(int? page)
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var q = db.Orders.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.DateOrder).ToList();

            return View(q.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult DetailOrd(string id)
        {
            var ls = db.DetailBills.Where(n => n.BillID == id).ToList();
            return View(ls);
        }
        public ActionResult Ord()
        {
            return View();
        }
        public ActionResult Search(string keyword, int? page)
        {
            if (keyword.Equals(""))
            {
                return RedirectToAction("ViewOrd", "Order");
            }
            else
            {
                var q = db.Orders.Where(a => a.OrderID.ToLower().Contains(keyword.ToLower())).ToList();
                ViewBag.keyword = keyword;
                int pageSize = 4;
                int pageNumber = (page ?? 1);
                q = q.OrderByDescending(n => n.OrderID).ToList();
                return View("ViewOrd", q.ToPagedList(pageNumber, pageSize));
            }

        }


    }

}