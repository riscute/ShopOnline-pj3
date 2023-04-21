using BotDetect.Web.Mvc;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Controllers
{
    public class LoginController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Login
        [HttpGet]
        public ActionResult LoginUser()
        {
            return View();
        }
        [HttpPost]
        public ActionResult LoginUser(string phone, string password)
        {
            if (ModelState.IsValid)
            {
                var f_password = GetMD5(password);
                var data = db.Customers.Where(x => x.Phone.Equals(phone) && x.Password.Equals(f_password)).ToList();
                if (data.Count() > 0)
                {
                    Session["name"] = data.FirstOrDefault().CusName;
                    Session["id"] = data.FirstOrDefault().CusID;
                    Session["phone"] = data.FirstOrDefault().Phone;
                    Session["address"] = data.FirstOrDefault().Address;
                    Session["email"] = data.FirstOrDefault().Email;
                    return Json(1);
                   
                }
                else
                {
                    return Json(0);

                }
            }
            return View();
        }
        public ActionResult Logout()
        {
           // Session.Clear();//remove session
            Session.Remove("name");
            Session.Remove("id");
            Session.Remove("phone");
            Session.Remove("addresss");
            Session.Remove("email");
            return RedirectToAction("LoginUser");
        }
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(Customer customer)
        {
            try
            {               
                if (ModelState.IsValid)
                {
                    var check = db.Customers.Where(x => x.Phone == customer.Phone).FirstOrDefault();
                    if(check == null)
                    {
                        customer.Password = GetMD5(customer.Password);
                        db.Configuration.ValidateOnSaveEnabled = false;
                        db.Customers.Add(customer);
                        db.SaveChanges();
                        return RedirectToAction("LoginUser", "Login");
                    }
                    else
                    {
                        return View();
                    }
                  
                }
            }
            catch(Exception ex)
            {
                TempData["Msg"] = "Failed" + ex.Message;
                RedirectToAction("Register");
            }

            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }
        public JsonResult Check2(string phonenumber)
        {
           
            var checkNum = db.Customers.Where(x => x.Phone == phonenumber).FirstOrDefault();
            if (checkNum != null)
            {
                return Json(1);
            }

            else
            {
                return Json(0);
            }
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
    }
}