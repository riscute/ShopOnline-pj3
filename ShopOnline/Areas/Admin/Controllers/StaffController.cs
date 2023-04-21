using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Areas.Admin.Controllers
{
    [Authorize(Roles = "admin")]
    public class StaffController : Controller
    {
        // GET: Admin/Staff
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();


        // GET: Admin/Staff
        public ActionResult ViewStaff(int? page)
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var q = db.Employees.ToList();
            int pageSize = 2;
            int pageNumber = (page ?? 1);
            q = q.OrderByDescending(n => n.EmployeeID).ToList();
            return View(q.ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult EditStaff(int id)
        {

            var q = db.Employees.Where(a => a.EmployeeID == id).FirstOrDefault();

            return View(q);

        }

        [HttpPost]
        public ActionResult EditStaff(Employee emp, string id)
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            emp.Position = 1;
            db.Entry(emp).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("ViewStaff");

        }



        public ActionResult AdStaff()
        {
            if (Session["idEmp"] == null)
            {
                return RedirectToAction("Login", "Login");
            }
            Employee employee = new Employee();
            List<Position> list = SelectAllArticle().ToList();
            ViewBag.listPosition = new SelectList(list, "PositionID", "PositionName", 1);
            return View(employee);
        }

        private static List<Position> SelectAllArticle()
        {
            var rtn = new List<Position>();
            using (var context = new ProjectOnlineEntities())
            {
                foreach (var item in context.Positions)
                {
                    rtn.Add(new Position
                    {
                        PositionID = item.PositionID,
                        PositionName = item.PositionName
                    });
                }
            }
            return rtn;
        }

        [HttpPost]
        public ActionResult AdStaff(Employee model)
        {

            if (ModelState.IsValid)
            {
                var check = db.Employees.Where(a => a.Phone.Equals(model.Phone)).FirstOrDefault();
                if (check == null)
                {
                    model.Password = GetMD5(model.Password);
                    model.Position = 1;
                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.Employees.Add(model);
                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.Employees.Add(model);
                    db.SaveChanges();

                    return RedirectToAction("ViewStaff");
                }
                else
                {
                    return View();
                }
            }
            return View();

        }

        public JsonResult Check2(string phonenumber)
        {
            System.Threading.Thread.Sleep(200);
            var checkNum = db.Employees.Where(a => a.Phone.Equals(phonenumber)).FirstOrDefault();
            if (checkNum != null)
            {
                return Json(1);
            }

            else
            {
                return Json(0);
            }
        }

        public ActionResult DeleteStaff(string id)
        {
            var model = db.Employees.Find(id);
            db.Employees.Remove(model);
            db.SaveChanges();
            return RedirectToAction("ViewPro");
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