using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Controllers
{
    public class ContactController : Controller
    {
        // GET: Contact
        [HttpPost]
        public ActionResult Send(string fname, string lname, string email, string subject, string message)
        {
            var fullName = fname + " " + lname;
            try
            {
                string content = System.IO.File.ReadAllText(Server.MapPath("~/content/template/newcontact.html"));
                content = content.Replace("{{CusName}}", fullName);
                content = content.Replace("{{Email}}", email);
                content = content.Replace("{{Subject}}", subject);
                content = content.Replace("{{Message}}", message);
                var toEmail = ConfigurationManager.AppSettings["ToEmailAddress"].ToString();

                new MailHelper().SendMail(email, " Contact information from customer", content);
                new MailHelper().SendMail(toEmail, " Contact information from customer", content);

                //Clear form contact
                Session["fname"] = " ";
                Session["lname"] = " ";
                Session["email"] = " ";
                Session["subject"] = " ";
                Session["message"] = " ";
            }
            catch
            {
                return RedirectToAction("Failed", "Home");
            }
            return RedirectToAction("Thanks", "Home");
        }
    }
}