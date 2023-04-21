var CartController = function () {
    this.initialize = function () {

        registerEvents();
      
    }
    function registerEvents() {
        $('.btn-plus').off('click').on('click', function (e) {
            e.preventDefault();
            var id = $(this).data('id');
            var quantity = parseInt($('#txt_quantity_' + id).val()) + 1;
            var a = $(this).data('amount');
            if (quantity > a) {
                Swal.fire({
                    icon: 'error',
                    title: 'Has exceeded the amount that can be met',
                    text: 'Please choose quantity below or equal '+ a,
                    showConfirmButton: false,
                    timer: 2500
                });
                quantity = a;
            }
            else {
                updateCart(id, quantity);
            }
           
        });

        $('.btn-minus').off('click').on('click', function (e) {
            e.preventDefault();
            const id = $(this).data('id');
            const quantity = parseInt($('#txt_quantity_' + id).val()) - 1;
            updateCart(id, quantity);
        });
        $('.btn-remove').off('click').on('click', function (e) {
            e.preventDefault();
            const id = $(this).data('id');
            updateCart(id, 0);
        });
    }

    
    function updateCart(id, quantity) {
        $.ajax({
            url: 'Cart/Update',
            type: 'POST',
            data: {
                id: id,
                quantity: quantity
            },
            success: function (res) {
                window.location.reload(false);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
    //function loadData() {
    //    $.ajax({
    //        type: "GET",
    //        url: '/Cart/GetListItems',
    //        dataType: 'json',
    //        success: function (res) {
    //            if (res.status) {
    //                $('#tbl_cart').html();
    //            }
    //            else {
    //                $('#tbl_cart').hide();
    //            }
    //            var html = '';
    //            var total = 0;
    //            var data = res.data;
    //            $.each(data, function (i, item) {
    //                var amounts = item.product.Price * item.Quantity;
    //                html += "<tr id=\"product-" + item.ProductID + "\"/>"
    //                    + "<td class=\"product-thumbnail\">"
    //                    + "<img src=\"" + item.product.Image + "\" alt=\"\" class=\"img-fluid\">"
    //                    + "</td>"
    //                    + "<td class=\"product-name\">"
    //                    + "<h2 class=\"h5 text-black" > + item.ProductName + "\"</h2>"
    //                    + "</td>"
    //                + "<td>" + item.product.Price + "</td>"
    //                    + "<td>"
    //                    + "<div class=\"input-group mb-3\" style=\"max-width: 120px;\">"
    //                    + "<div class=\"input-group-prepend\">"
    //                    + "<button class=\"btn btn-minus\" data-id=\"" + item.ProductID + "\" type=\"button\">&minus;</button>"
    //                + "</div>"
    //                + "<input type=\"button\" class=\"form-control text-center\" value=\"" + item.Quantity + "\" id=\"txt_quantity_" + item.ProductID + "\"  placeholder=\"1\"  aria-label=\"Example text with button addon\" aria-describedby=\"button-addon1\">"
    //                + "<div class=\"input-group-append\">"
    //                + "<button class=\"btn btn-plus\" data-id=\"" + item.ProductID + "\"  type=\"button\">&plus;</button>"
    //                    + "</div>"
    //                    + "</div>"
    //                    + "</td>"
    //                + "<td>" + numberWithCommas(item.product.Price) + "</td>"
    //                + "<td>" + numberWithCommas(amounts) + "</td>"
    //                + "<td><a href=\"#\" class=\"btn btn-primary btn-remove\" data-id=\"" + item.ProductID + "\">X</a></td>"
    //                    + "</tr>";
    //                total += amounts;
    //            });
    //            $('#cart_body').html(html);
    //            $('#CartCount').text(res.length);
    //            $('#lbl_total').text(numberWithCommas(total));
    //        }
    //    });
    //}
}