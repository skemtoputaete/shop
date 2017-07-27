$(document).ready(function() {
  $(".quantity").bind('change', function () {
    var position_id = $(this).attr('id');
    var quantity = $(this).val();
    if (quantity < 1) {
       alert('Количество товара должно быть больше единицы!');
    }
    else {
      $.ajax({
        url: '/orders/update_quantity/',
        type: 'GET',
        dataType: 'html',
        data: {position_id: position_id, quantity: quantity},
        success: function(result){
          $('#cost').html(result)
        }
      })
    }
  })
})
