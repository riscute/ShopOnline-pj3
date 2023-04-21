using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class AdminIndexController : Controller
    {
       [Authorize(Roles = "admin, employee")]
        // GET: Admin/AdminIndex
        public ActionResult Index()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            return View();
        }
    }}