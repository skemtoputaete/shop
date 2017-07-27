$(document).ready(function() {
  $("#search-field").bind('keypress', function () {
    var query = $(this).val();
    if (query.length > 2) {
      // alert('s');
      $.ajax({
        url: '/search/search/',
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
