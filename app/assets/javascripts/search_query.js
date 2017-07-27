$(document).ready(function() {
  $("#search-field").bind('keypress', function () {
    var query = $(this).val();
    if (query.length > 2) {
      $.ajax({
        url: '/search/search_autocomplete/',
        type: 'GET',
        dataType: 'html',
        data: { search: query },
        success: function(result){
          $('#search-results').html(result)
        }
      })
    }
  })
});
