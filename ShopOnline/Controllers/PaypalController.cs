using ShopOnline.Models;
using ShopOnline.Pay;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopOnline.Controllers
{
    public class PaypalController : Controller
    {
        private const string CartSession = "CartSession";
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        // GET: Paypal
        public ActionResult Index()
        {
            return View();
        }
      
        public ActionResult GetDataPaypal(string data)
        {
            var getData = new GetDataPaypal();
            var order = getData.InformationOrder(getData.GetPayPalResponse(Request.QueryString["tx"]));
            ViewBag.tx = Request.QueryString["tx"];
            RandomGenerator_Bill generator = new RandomGenerator_Bill();
            //get product cart first 
            var listCart = (List<CartModel>)Session[CartSession];
            var q = listCart.FirstOrDefault();
            //get total price = total + ship
            
            Bill bill = new Bill();
            bill.BillID = generator.Generate();
            bill.CusID = int.Parse(Session["id"].ToString());
            bill.DateOrder = DateTime.Now;
            bill.TypeBill = "PayPal";
            bill.Status = "Paid";
            bill.ShippingName = data;
            Decimal shipfee = 0;
            switch (Session["address"].ToString())
            {
                case "TPHCM":
                    shipfee = 1M;
                    bill.TransportPrice = shipfee;
                    break;
                case "Thành phố Hồ Chí Minh":
                    shipfee = 1M;
                    bill.TransportPrice = shipfee;
                    break;
                case "Hà Nội":
                    shipfee = 2M;
                    bill.TransportPrice = shipfee;
                    break;
                case "HN":
                    shipfee = 2M;
                    bill.TransportPrice = shipfee;
                    break;

            }
            Decimal total = 0;
            Decimal TT = 0;
            ViewBag.Address = shipfee;
            foreach (var item in listCart)
            {
                total += (item.Quantity * item.product.Price);
                TT = total + ViewBag.Address;
            }
           
            bill.TotalPayment = TT;
            db.Bills.Add(bill);
            db.SaveChanges();
            string IDOrder = bill.BillID;

            List<DetailBill> lsdetail = new List<DetailBill>();
            //List<Models.Order> lsord = new List<Order>();
            foreach (var item in listCart)
            {
                DetailBill dt = new DetailBill();
                dt.BillID = IDOrder;
                dt.Amount = item.Quantity;
                dt.Price = item.product.Price;
                dt.ProductID = item.product.ProductID;
                dt.TotalPrice = (item.product.Price * item.Quantity);
                lsdetail.Add(dt);
            }
            db.DetailBills.AddRange(lsdetail);
            db.SaveChanges();

            string proid = q.product.ProductID;
            Order or = new Order();
            or.OrderID = bill.BillID + proid + bill.ShippingName;
            or.CusID = int.Parse(Session["id"].ToString());
            or.DateOrder = bill.DateOrder;
            or.Stt = "Wait for confirmation";
            or.BillID = IDOrder;
            //lsord.Add(or);
            db.Orders.Add(or);
            db.SaveChanges();
            Session[CartSession] = null;
            Session["count"] = null;           
            return View();
        }
        [HttpGet]
        public ActionResult Success()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Success(Product product)
        {

            RandomGenerator_Bill generator = new RandomGenerator_Bill();
            var listCart = (List<CartModel>)Session[CartSession];
            Bill bill = new Bill();
            bill.BillID = generator.Generate();
            bill.CusID = int.Parse(Session["id"].ToString());
            bill.DateOrder = DateTime.Now;          
            bill.TypeBill = "COD";
            bill.Status = "Unpaid";
            if (Session["address"].ToString() == "TPHCM")
            {
                bill.TransportPrice = 1;
            }
            if (Session["address"].ToString() == "Thành phố Hồ Chí Minh")
            {
                bill.TransportPrice = 1;
            }
            if (Session["address"].ToString() == "Hà Nội")
            {
                bill.TransportPrice = 2;
            }
            if (Session["address"].ToString() == "HN")
            {
                bill.TransportPrice = 2;
            }
            db.Bills.Add(bill);
            db.SaveChanges();
            string IDOrder = bill.BillID;

            List<DetailBill> lsdetail = new List<DetailBill>();
            foreach (var item in listCart)
            {
                DetailBill dt = new DetailBill();
                dt.BillID = IDOrder;
                dt.Amount = item.Quantity;
                dt.Price = item.product.Price;
                dt.ProductID = item.product.ProductID;
                dt.TotalPrice = (item.product.Price * item.Quantity);
                lsdetail.Add(dt);
            }
            db.DetailBills.AddRange(lsdetail);
            db.SaveChanges();
            Session[CartSession] = null;
            Session["count"] = null;
            return View();
        }

        [HttpGet]
        public ActionResult Success1()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Success1(string data)
        {
            RandomGenerator_Bill generator = new RandomGenerator_Bill();
            var listCart = (List<CartModel>)Session[CartSession];
            var q = listCart.FirstOrDefault();
            Bill bill = new Bill();
            bill.BillID = generator.Generate();
            bill.CusID = int.Parse(Session["id"].ToString());
            bill.DateOrder = DateTime.Now;
            bill.TypeBill = "COD";
            bill.Status = "Unpaid";

            bill.ShippingName = data;
            Decimal shipfee = 0;
            switch (Session["address"].ToString())
            {
                case "TPHCM":
                    shipfee = 1M;
                    bill.TransportPrice = shipfee;
                    break;
                case "Thành phố Hồ Chí Minh":
                    shipfee = 1M;
                    bill.TransportPrice = shipfee;
                    break;
                case "Hà Nội":
                    shipfee = 2M;
                    bill.TransportPrice = shipfee;
                    break;
                case "HN":
                    shipfee = 2M;
                    bill.TransportPrice = shipfee;
                    break;

            }
            Decimal total = 0;
            Decimal TT = 0;
            ViewBag.Address = shipfee;
            foreach (var item in listCart)
            {
                total += (item.Quantity * item.product.Price);
                TT = total + ViewBag.Address;
            }
            bill.TotalPayment = TT;
            db.Bills.Add(bill);
            db.SaveChanges();
            string IDOrder = bill.BillID;

            List<DetailBill> lsdetail = new List<DetailBill>();
            //List<Models.Order> lsord = new List<Order>();
            foreach (var item in listCart)
            {
                DetailBill dt = new DetailBill();
                dt.BillID = IDOrder;
                dt.Amount = item.Quantity;
                dt.Price = item.product.Price;
                dt.ProductID = item.product.ProductID;
                dt.TotalPrice = (item.product.Price * item.Quantity);
                lsdetail.Add(dt);      
            }
            db.DetailBills.AddRange(lsdetail);
            db.SaveChanges();
            string proid = q.product.ProductID;
            Order or = new Order();
            or.OrderID = bill.BillID + proid + bill.ShippingName;
            or.CusID = int.Parse(Session["id"].ToString());
            or.DateOrder = bill.DateOrder;
            or.Stt = "Wait for confirmation";
            or.BillID = IDOrder;
            //lsord.Add(or);
            db.Orders.Add(or);
            db.SaveChanges();
            Session[CartSession] = null;
            Session["count"] = null;
            string content = System.IO.File.ReadAllText(Server.MapPath("~/content/template/neword.html"));

            content = content.Replace("{{CusName}}", Session["name"].ToString());
            content = content.Replace("{{Phone}}", Session["phone"].ToString());
            content = content.Replace("{{Email}}", Session["email"].ToString());
            content = content.Replace("{{Address}}", Session["address"].ToString());
            content = content.Replace("{{TotalPrice}}", bill.TotalPayment.ToString());
            var toEmail = ConfigurationManager.AppSettings["ToEmailAddress"].ToString();

            // Để Gmail cho phép SmtpClient kết nối đến server SMTP của nó với xác thực 
            //là tài khoản gmail của bạn, bạn cần thiết lập tài khoản email của bạn như sau:
            //Vào địa chỉ https://myaccount.google.com/security  Ở menu trái chọn mục Bảo mật, sau đó tại mục Quyền truy cập 
            //của ứng dụng kém an toàn phải ở chế độ bật
            //  Đồng thời tài khoản Gmail cũng cần bật IMAP
            //Truy cập địa chỉ https://mail.google.com/mail/#settings/fwdandpop

            new MailHelper().SendMail(Session["email"].ToString(), "New order from Shop Online", content);
            new MailHelper().SendMail(toEmail, "New order from Shop Online", content);
            return View();
        }

    }
}