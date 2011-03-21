$(document).ready(function() {
    $("a.setPrice").live('click', function(){
      $(this).parent().find(".priceForm").show();
      return false;
    });

    $("a.cancelPriceUpdate").live('click', function() {
      $(this).parent().hide();
      return false;
    });

   $("#listItems .listItem .priceForm input[type='button']").live('click', function() {
      var button = $(this);
      
      var item_id = $(this).attr('data-item');
      var list_id = $(this).attr('data-list');
      var item_price = $("#item_" + item_id + "_price").val();

      $.ajax({
        url: '/items/' + item_id,
        type: 'post',
        data: {item: {price: item_price}, _method: "put"},
        dataType: 'json',
        async: 'false',
        success: function(data) {
          var listItem = $("li#item_" + item_id);
          listItem.find(".priceForm").hide();
          $("#item_" + item_id + "_price_label").html("$ " + (parseFloat(data.item.price) / 100) );
        }
      });

     return false;
   });
});

