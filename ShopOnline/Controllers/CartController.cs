using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using PagedList;
using ShopOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace ShopOnline.Controllers
{
    public class CartController : Controller
    {
        Models.ProjectOnlineEntities db = new Models.ProjectOnlineEntities();
        private const string CartSession = "CartSession";
        // GET: Cart
        public ActionResult Index()
        {
            var session = Session[CartSession];
            List<CartModel> currentCart = new List<CartModel>();
            if (session != null)
            {
                currentCart = (List<CartModel>)session;
            }
            return View(currentCart);
        }
       
        public ActionResult AddToCart(string productId)
        {
            var session = Session[CartSession];
            if (session == null)
            {

                List<CartModel> cart = new List<CartModel>();
                cart.Add(new CartModel
                {
                    product = db.Products.Find(productId),
                    Quantity = 1
                });
                Session[CartSession] = cart;
                //Session["count"] = 1;
            }
            else
            {
                List<CartModel> cart = (List<CartModel>)session;
                int index = isExist(productId);
                if (index != -1)
                {
                    cart[index].Quantity++;
                }
                else
                {
                    cart.Add(new CartModel { product = db.Products.Find(productId), Quantity = 1 });
                    //Session["count"] = Convert.ToInt32(Session["count"]) + 1;
                }
                Session[CartSession] = cart;
            }
            return RedirectToAction("Index", "Product");

        }
        public ActionResult AddToCartDetail(string productId, int quantity, int amount)
        {
            string a = "";
            if (quantity > amount)
            {
                a = "1";
            }
            else
            {

                var session = Session[CartSession];
                if (session == null)
                {

                    List<CartModel> cart = new List<CartModel>();
                    cart.Add(new CartModel
                    {
                        product = db.Products.Find(productId),
                        Quantity = quantity
                    });
                    Session[CartSession] = cart;
                    //Session["count"] = 1;
                    a = "2";
                }
                else
                {
                    List<CartModel> cart = (List<CartModel>)session;
                    int index = isExist(productId);

                    if (index != -1)
                    {
                        if (amount >= (cart[index].Quantity + quantity))
                        {
                            cart[index].Quantity += quantity;
                            a = "2";
                        }
                        else
                        {
                            a = "3";
                        }
                          
                    }
                    else
                    {
                        cart.Add(new CartModel { product = db.Products.Find(productId), Quantity = quantity });
                        //Session["count"] = Convert.ToInt32(Session["count"]) + 1;
                        a = "2";
                    }

                    Session[CartSession] = cart;

                }
            }

            return Json(a, JsonRequestBehavior.AllowGet);

        }
        private int isExist(string productId)
        {
            List<CartModel> cart = (List<CartModel>)Session[CartSession];
            for (int i = 0; i < cart.Count; i++)
                if (cart[i].product.ProductID.Equals(productId))
                    return i;
            return -1;
        }

        public ActionResult Update(string id, int quantity)
        {
            var session = Session[CartSession];
            List<CartModel> currentCart = new List<CartModel>();
            if (session != null)
                currentCart = (List<CartModel>)session;
            foreach (var item in currentCart)
            {
                if (item.product.ProductID == id)
                {
                    if (quantity == 0)
                    {
                        currentCart.Remove(item);
                        //Session["count"] = Convert.ToInt32(Session["count"]) - 1;
                        break;
                    }
                    item.Quantity = quantity;
                }
            }

            Session[CartSession] = currentCart;
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }

        public ActionResult DeleteAll()
        {
            Session[CartSession] = new List<CartModel>();
            return Json(new
            {
                status = true
            });

        }

        //public ActionResult DeleteItem(string id)
        //{
        //    var cartSession = (List<CartModel>)Session[CartSession];
        //    if (cartSession != null)
        //    {
        //        cartSession.RemoveAll(x => x.product.ProductID == id);
        //        Session[CartSession] = cartSession;
        //        Session["count"] = Convert.ToInt32(Session["count"]) - 1;
        //        return RedirectToAction("Index", "Cart");
        //    }
        //    return RedirectToAction("Index", "Cart");
        //}
        public ActionResult Checkout()
        {
            Decimal shipfee = 0;
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }
            switch (Session["address"].ToString())
            {
                case "TPHCM":
                    shipfee = 1M;
                    break;
                case "Thành phố Hồ Chí Minh":
                    shipfee = 1M;
                    break;
                case "Hà Nội":
                    shipfee = 2M;
                    break;
                case "HN":
                    shipfee = 2M;
                    break;

            }

            var session = Session[CartSession];
            List<CartModel> currentCart = new List<CartModel>();
            if (session != null)
            {
                currentCart = (List<CartModel>)session;
            }
            IEnumerable<NVC> nVCs = NVC.GetNhaVanChuyen();
            // Set vào ViewBag
            ViewBag.NVCList = nVCs;
            Decimal total = 0;
            Decimal TT = 0;
            ViewBag.Address = shipfee;
            foreach (var item in currentCart)
            {
                total += (item.Quantity * item.product.Price);
                TT = total + ViewBag.Address;
            }
            ViewBag.TotalMoney = TT;
            return View(currentCart);

        }
        public ActionResult Order_Tracking(int? page)// chua duyet
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }

            var currentCart = new List<Order>();
            var session = Convert.ToInt32(Session["id"]);
            List<Order> list = (from a in db.Orders where a.Stt == "Wait for confirmation" && a.CusID == session select a).ToList();
            currentCart = list.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));

        }
        public ActionResult Order_Tracking1(int? page)
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }

            var currentCart = new List<Order>();
            var session = Convert.ToInt32(Session["id"]);
            List<Order> list = (from a in db.Orders where a.Stt == "Confirmed" && a.CusID == session select a).ToList();
            currentCart = list.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Done(string id)
        {
            var q = db.Orders.FirstOrDefault(a => a.OrderID == id);

            if (q != null)
            {
                q.Stt = "Delivered";
                db.SaveChanges();
            }

            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }
        public ActionResult Order_Tracking2(int? page)
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }

            var currentCart = new List<Order>();
            var session = Convert.ToInt32(Session["id"]);
            List<Order> list = (from a in db.Orders where a.Stt == "Delivering" && a.CusID == session select a).ToList();
            currentCart = list.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Order_Tracking3(int? page)
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }

            var currentCart = new List<Order>();
            var session = Convert.ToInt32(Session["id"]);
            List<Order> list = (from a in db.Orders where a.Stt == "Delivered" && a.CusID == session select a).ToList();
            currentCart = list.ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Cancel(int? page)
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("LoginUser", "Login");
            }

            var session = Convert.ToInt32(Session["id"]);
            List<Order> list = (from a in db.Orders where a.Stt == "Canceled" && a.CusID == session select a).ToList();
            int pageSize = 4;
            int pageNumber = (page ?? 1);
            list = list.OrderByDescending(n => n.DateOrder).ToList();
            return View(list.ToPagedList(pageNumber, pageSize));
        }
        public PartialViewResult CartBag()
        {
            int total = 0;
            var session = Session[CartSession];
            var currentCart = new List<CartModel>();
            if (session != null)
                currentCart = (List<CartModel>)session;
            var t1 = currentCart.Sum(s => s.Quantity);
            total = currentCart.Count(x => x.Quantity <= t1);
            ViewBag.QuantityCart = total;
            return PartialView("CartBag");
        }
        public ActionResult DetailOrd(string id)
        {
            var ls = db.DetailBills.Where(n => n.BillID == id).ToList();
            return View(ls);
        }

        public ActionResult Delete(string status, string id)
        {
            var q = db.Orders.FirstOrDefault(a => a.OrderID == id);
            if (status == "Paid")
            {
                if (q != null)
                {
                    q.Stt = "Canceled";
                    q.Bill.Status = "Refunded";
                    db.SaveChanges();
                }
            }
            else
            {
                if (q != null)
                {
                    q.Stt = "Canceled";
                    db.SaveChanges();
                }

            }
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }

    }
}