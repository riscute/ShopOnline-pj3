using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class CateOrdController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/CateOrd
        [Authorize(Roles = "admin, employee")]
        public ActionResult ViewCateOrd()
        {

            return View();
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult updateStatus(string id)
        {
            var q = db.Orders.FirstOrDefault(a => a.OrderID == id);

            if (q != null)
            {
                q.Stt = "Confirmed";
                db.SaveChanges();
            }

            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult delever(string id, string idBill)
        {
            var q = db.Orders.FirstOrDefault(a => a.OrderID == id);

            if (q != null)
            {
                q.Stt = "Delivering";
                db.SaveChanges();
            }
            foreach (var item in db.DetailBills)
            {
                if(item.BillID == idBill)
                {
                    var pro = db.Products.DefaultIfEmpty().Single(pr => pr.ProductID == item.ProductID);
                    pro.Amount = pro.Amount - item.Amount;
                }
            
            }
            db.SaveChanges();
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult Confirm(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            List<Order> list = (from a in db.Orders where a.Stt == "Wait for confirmation" select a).ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
          
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult Confirmed(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            List<Order> list = (from a in db.Orders where a.Stt == "Confirmed" select a).ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();

            return View(list.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult Delivering(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            List<Order> list = (from a in db.Orders where a.Stt == "Delivering" select a).ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();

            return View(list.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult Delivered(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            List<Order> list = (from a in db.Orders where a.Stt == "Delivered" select a).ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        [Authorize(Roles = "admin, employee")]
        public ActionResult DetailOrd(string id)
        {
            var ls = db.DetailBills.Where(n => n.BillID == id).ToList();
            return View(ls);
        }

        
    }
}