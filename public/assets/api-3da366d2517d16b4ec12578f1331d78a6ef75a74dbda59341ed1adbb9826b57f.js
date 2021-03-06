$(document).ready(function() {

  var index_path = '/testapi/index';
  var category_path = '/testapi/show';
  var products_path = '/testapi/products';
  var description_path = '/testapi/description';

  var categoryParentName = [];

  onpopstate = function(event) {

    var path = location.pathname;
    var param = location.search;
    var categoryId = param.split('=');

    categoryId = categoryId[1];

    var choice = 0;

    switch (path) {
      case category_path:
        choice = 1;
        break;
      case description_path:
        choice = 2;
        break;
      case index_path:
      case '/testapi':
        break;
      default:
        console.log('Something wrong.');
    }

    if (choice != 0) {
      $.ajax({
        url: path + param,
        type: 'GET',
        dataType: 'json',
        success: function(result) {
          $('#api_res').empty();
          if (choice == 1) {
            render_categories(result, categoryParentName[categoryId], categoryId);
          } else {
            render_description(result);
          }
        }
      });
    }

  }

  function render_categories(categories, parent_name, parent_id) {
    if (parent_name != undefined) {
      var parent_element = $('<div class="col-xs-12 text-center">').append(parent_name);
      parent_element.appendTo('#api_res');
    }

    categories.forEach(function(item, i) {
      var item_div = $('<a>').append(item.name);
      item_div.attr('link', '/testapi/show');
      item_div.attr('data-remote', 'false');
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
    });

    if (parent_id != undefined) {
      $.ajax({
        url: '/testapi/products?id=' + parent_id,
        type: 'GET',
        dataType: 'json',
        success: function(result) {
          render_products(result);
        }
      });
    }
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

  if (location.pathname == index_path || location.pathname == '/testapi') {

    var categoryId = location.search.split('=');
    categoryId = categoryId[1];    

    $.ajax({
      url: index_path,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        render_categories(result)
      }
    });
  }

  if (location.pathname == category_path || location.pathname == description_path) {

    $.ajax({
      url: location.pathname + location.search,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        switch (location.pathname) {
          case category_path:

            break;
          case description_path:
              render_description(result);
            break;
        }
      }
    });
  }

  $('body').on('click', '#show_category', function() {

    var item_id = $(this).attr('item');
    var products = $(this).attr('products');
    var item_name = $(this).text();
    var urlAjax = category_path + '?id=' + item_id;

    categoryParentName[item_id] = item_name;

    history.pushState(null, null, urlAjax);

    $.ajax({
      url: urlAjax,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        $('#api_res').empty();
        render_categories(result, item_name, item_id);
      }
    });

  });

  $('body').on('click', '#show_product', function() {

    var product_id = $(this).attr('product');
    var urlAjax = description_path + '?id=' + product_id;

    history.pushState(null, null, urlAjax);

    $.ajax({
      url: urlAjax,
      type: 'GET',
      dataType: 'json',
      success: function(result) {
        $('#api_res').empty();
        render_description(result);
      }
    });

  });

});
