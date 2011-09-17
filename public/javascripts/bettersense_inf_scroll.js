(function() {
  var page = 1;
  var loading = false;

  function nearBottomOfPage() {
    return (($(window).scrollTop() > $(document).height() - $(window).height() - 800) && !(window.cancel_scroll));
  }
  $(window).scroll(function(){
    if (loading) {
      return;
    }

    if(nearBottomOfPage()) {
      loading=true;
      page++;
      $('.loading').fadeIn('fast');
      $.ajax({
        url: url + "" + page,
        type: 'get',
        dataType: 'script',
        statusCode: {
          404: function() {
            alert('page not found'); },
          500: function() {
            alert('500 error, please reload the page!'); }
        },
        success: function() {
          $(window).sausage('draw');
          loading=false
          $('.loading').fadeOut('fast');
        }
      });
      
    }
  });
  $(window).sausage();
}());
