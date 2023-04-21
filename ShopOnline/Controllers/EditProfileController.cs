using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Windows;

namespace ShopOnline.Controllers
{
    public class EditProfileController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();

        // GET: EditProfile
        public ActionResult Index()
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }
            var session = Convert.ToInt32(Session["id"]);
            var q = (from a in db.Customers where a.CusID == session select a).ToList();

            return View(q);
        }
        [HttpPost]
        public ActionResult editprofile(Customer customer)
        {

            int idcus = Convert.ToInt32(Request.Form["id_cus"]);
            Debug.WriteLine("id: " + idcus);
            try
            {

                var p = (from a in db.Customers where a.CusID == idcus select a).FirstOrDefault();

                string name = Request.Form.Get("inputName");
                string phone = Request.Form["inputPhone"];
                string address = Request.Form["inputLocation"];
                string username = Request.Form["inputUsername"];
                string pass =GetMD5(Request.Form["inputPass"]);

                p.CusName = name;
                p.Email = username;
                p.Phone = phone;
                p.Address = address;
                p.Password = pass;
                db.SaveChanges();
                //Debug.WriteLine("sucess");

                //MessageBox.Show("Update Successful !!!");
                return RedirectToAction("Index", "EditProfile");
            }
            catch
            {
                return RedirectToAction("Index", "EditProfile", new { id = idcus });

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
        [HttpPost]
        public ActionResult UpdateAvartar(HttpPostedFileBase file)
        {
            if (file == null)
            {
                return RedirectToAction(actionName: "Index");
            }
            var path = Server.MapPath("~/asset/images");
            var avatar = Commom.UploadImage.Upload(file, path);
            if (avatar == null)
            {
                RedirectToAction(actionName: "Index");
            }
            var idCus = Convert.ToInt32(Session["id"]);
            var cus = (from a in db.Customers where a.CusID == idCus select a).FirstOrDefault();
            cus.Image = avatar;
            db.SaveChanges();
            return RedirectToAction(actionName: "Index");

        }
        [HttpGet]
        public ActionResult EditPass()
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }
            return View();
        }
        [HttpPost]
        public ActionResult EditPass(string NewPass)
        {
            try
            {
                var session = Convert.ToInt32(Session["id"]);
                var check = (from a in db.Customers where a.CusID == session select a).FirstOrDefault();
                string pass = GetMD5(NewPass);
                check.Password = pass;
                db.SaveChanges();
                //Debug.WriteLine("sucess");
                //MessageBox.Show("Update Successful !!!");
                return RedirectToAction("Index", "EditProfile");
            }
            catch
            {
                return RedirectToAction("Index", "EditProfile");

            }
        }
        public JsonResult Check(string currentpass)
        {
          
            var f_pass = GetMD5(currentpass);
                var checkNum = db.Customers.Where(x => x.Password == f_pass).FirstOrDefault();
                if (checkNum != null)
                {
                    return Json(1);
                }

                else
                {
                    return Json(0);
                }

        }
    }
}