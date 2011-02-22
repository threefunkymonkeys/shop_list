$(document).ready(function() {

    $("a.setPrice").click(function(){
      $(this).parent().find(".priceForm").show();
      return false;
    });
});

