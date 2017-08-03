$(document).ready(function() {
  $("#search-field").bind('keydown', function() {
    var query = $(this).val();
    if (query.length > 3) {
      $.ajax({
        url: '/search/search_autocomplete/',
        type: 'GET',
        dataType: 'html',
        data: {
          search: query
        },
        success: function(result) {
          if (result.length > 1) {
            $('#search-results').html(result);
            $('#search-results').css('display', 'block');
          }
        }
      })
    } else {
      $('#search-results').css('display', 'none');
    }
  })
});
