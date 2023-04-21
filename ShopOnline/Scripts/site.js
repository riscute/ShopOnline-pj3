var SiteController = function () {
    this.initialize = function () {
        regsiterEvents();

    }
    function regsiterEvents() {
        $('.btn-plus').off('click').on('click', function (e) {
            e.preventDefault();
            var id = $(this).data('id');
            var quantity = parseInt($('#ipQuantity_' + id).val()) + 1;
            updateCart(productId, quantity);
        });

        $('.btn-minus').off('click').on('click', function (e) {
            e.preventDefault();
            const id = $(this).data('id');
            const quantity = parseInt($('#ipQuantity_' + id).val()) - 1;
            updateCart(productId, quantity);
        });
    }
    function loadData() {
        $.ajax({
            url: '/Cart/CartBag',
            success: function (res) {
                $('#CartCount').html(res);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    function updateCart(productId, quantity) {
        $(".btn-add-cart").click(function () {
            $.ajax({
                url: "Cart/AddToCartDetail",
                data: {
                    productId: $(this).data('id'),
                    quantity: parseInt($("#ipQuantity_" + this.id).val())
                },
                success: function (res) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thêm giỏ hàng thành công',
                        showConfirmButton: false,
                        timer: 2500
                    });
                    loadData();
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Thêm giỏ hàng thất bại',
                        text: 'Vui lòng thử lại',
                        showConfirmButton: false,
                        timer: 2500
                    });
                }
            });
        });

    }
}