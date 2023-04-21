using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ShopOnline.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Admin/Login
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string phone, string password)
        {
            if (ModelState.IsValid)
            {
                var f_password = GetMD5(password);
                var data = db.Employees.Where(x => x.Phone.Equals(phone) && x.Password.Equals(f_password)).ToList();
                if (data.Count() > 0)
                {
                    Session["nameEmp"] = data.FirstOrDefault().EmployeeName;
                    Session["idEmp"] = data.FirstOrDefault().EmployeeID;
                    Session["position"] = data.FirstOrDefault().Position1.PositionName;
                    var ticket = new FormsAuthenticationTicket(phone, true, 3000);
                    string encrypt = FormsAuthentication.Encrypt(ticket);
                    var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypt);
                    cookie.Expires = DateTime.Now.AddHours(24);
                    cookie.HttpOnly = true;
                    Response.Cookies.Add(cookie);
                    return RedirectToAction("Confirm", "CateOrd");

                }
                else
                {
                    ModelState.AddModelError("", "UserName or Password failed. Try Again!");

                }
            }
            return View();
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

        public ActionResult Logout()
        {
            Session.Remove("nameEmp");
            Session.Remove("idEmp");
            Session.Remove("position");
            return RedirectToAction("Login");
        }
    }
}
