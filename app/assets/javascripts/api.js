$(document).ready(function() {

  function render_categories(categories, parent) {
    if (parent != undefined) {
      var parent_element = $('<div class="col-xs-12 text-center">').append(parent);
      parent_element.appendTo('#api_res');
    }

    categories.forEach(function(item, i) {
      var item_div = $('<div>').append(item.name);
      item_div.attr('id', 'show_category');
      item_div.attr('item', item.id);
      if (item.children === undefined) {
        item_div.attr('products', 1);
      } else {
        item_div.attr('products', 0);
      }
      var paragraph = $('<p>').append(item_div);
      var element = $("<div class='col-xs-6 col-sm-6 col-md-4 col-lg-4'>").append(paragraph);
      element.appendTo('#api_res');
    })
  };

  function render_products(products) {
    if (!$.isEmptyObject(products)) {
      products.forEach(function(item) {
        var product_div = $('<div class="col-xs-6" id="show_product">').append(item.name);
        product_div.attr('product', item.id);
        var products = $('<div>').append(product_div);
        products.appendTo('#api_res');
      })
    }
  };

  function render_description(product) {
    var product_header = $('<h2>', {
      'class': 'h2 page-header text-center',
      text: product.name
    });
    product_header.appendTo('#api_res');
    var product_div = $('<div class="row">');
    var product_img = $('<div class="col-xs-12 col-sm-12 col-md-2">');
    product_img.append($('<img>', {
      'class': "description-image",
      'src': product.picture
    }));
    var product_des = $('<div class="col-xs-12 col-sm-12 col-md-10">');
    product_des.append($('<p>', {
      text: 'Стоимость: ' + product.price
    }));
    product_des.append($('<p>', {
      text: 'Рейтинг: ' + product.rating
    }));
    product_des.append($('<p>', {
      text: product.description
    }));
    product_div.append(product_img);
    product_div.append(product_des);
    product_div.appendTo('#api_res');
  };

  $.ajax({
    url: '/testapi/index/',
    type: 'GET',
    dataType: 'json',
    success: function(result) {
      render_categories(result)
    }
  });

  $('body').on('click', '#show_category', function() {
    var item_id = $(this).attr('item');
    var products = $(this).attr('products');
    var item_name = $(this).text();
    $.ajax({
      url: '/testapi/show?id=' + item_id,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        $('#api_res').empty();
        render_categories(result, item_name);
      }
    });
    $.ajax({
      url: '/testapi/products?id=' + item_id,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        render_products(result);
      }
    });
  });

  $('body').on('click', '#show_product', function() {
    var product_id = $(this).attr('product');
    $.ajax({
      url: '/testapi/description?id=' + product_id,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        $('#api_res').empty();
        render_description(result);
      }
    });
  });

});
