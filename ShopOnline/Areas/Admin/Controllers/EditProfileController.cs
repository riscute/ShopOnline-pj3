using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    [Authorize(Roles = "admin, employee")]
    public class EditProfileController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/EditProfile
        public ActionResult Index()
        {
            if ( Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var session = Convert.ToInt32( Session["idEmp"]);
            var q = db.Employees.Where(a => a.EmployeeID.Equals(session)).FirstOrDefault();
            return View(q);
        }

        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;

            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");

            }
            return byte2String;
        }

        [HttpGet]
        public ActionResult EditPass()
        {
            return View();
        }
        [HttpPost]
        public ActionResult EditPass(Employee employee)
        {
            try
            {
                if ( Session["idEmp"] == null)
                {
                    return RedirectToAction("Login", "Login");
                }
                var session = Convert.ToInt32( Session["idEmp"]);
                var q = db.Employees.Where(a => a.EmployeeID.Equals(session)).FirstOrDefault();
                string pass = GetMD5(Request.Form["NewPass"]);
                q.Password = pass;
                db.SaveChanges();
                return RedirectToAction("Index", "EditProfile");
            }
            catch
            {
                return RedirectToAction("Index", "EditProfile");
            }
        }
        public JsonResult Check(string currentpass)
        {
            System.Threading.Thread.Sleep(200);
            var session = Convert.ToInt32( Session["idEmp"]);
            var f_pass = GetMD5(currentpass);
            var p = db.Employees.Where(a => a.EmployeeID.Equals(session)).FirstOrDefault();

            if (p != null)
            {
                var checkNum = db.Employees.Where(x => x.Password == f_pass).FirstOrDefault();
                if (checkNum != null)
                {
                    return Json(1);
                }

                else
                {
                    return Json(0);
                }
            }
            else
            {
                return Json(3);
            }

        }
       

    }
}