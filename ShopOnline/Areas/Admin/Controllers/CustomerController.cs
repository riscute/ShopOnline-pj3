using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class CustomerController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/Customer
        [Authorize(Roles = "admin, employee")]
        public ActionResult ViewCus(int? page)
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var q = db.Customers.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.CusID).ToList();
            return View(q.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Search(string keyword, int? page)
        {
            if (keyword.Equals(""))
            {
                return RedirectToAction("ViewCus", "Customer");
            }
            else
            {
                var q = db.Customers.Where(a => a.CusName.ToLower().Contains(keyword.ToLower()) || a.Phone.Contains(keyword)).ToList();
                int pageSize = 4;
                int pageNumber = (page ?? 1);
                q = q.OrderByDescending(n => n.CusID).ToList();
                ViewBag.keyword = keyword;
                return View("ViewCus", q.ToPagedList(pageNumber, pageSize));
            }
        }

    }
}