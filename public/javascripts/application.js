$(document).ready(function() {
    
    $("#listItems .listItem input[type='number']").live('input, keypress, change, keyup', function(event) {
      if (event.keyCode == 13) {
        $(this).parent().find("a.setPrice").click();
        //call it's a.setPrice#click sibling 
      } else {
        $(this).addClass("priceChanged");
      }
    });

   $("#listItems .listItem a.setPrice").live('click', function() {
      var button = $(this);
      
      var item_id = $(this).attr('data-item');
      var list_id = $(this).attr('data-list');
      var priceBox = $("#item_" + item_id + "_price");
      var quantityBox = $("#item_" + item_id + "_quantity");
      var item_price = priceBox.val();
      var item_quantity = quantityBox.val();
      var listItem = $("li#item_" + item_id);
      var itemLoader = listItem.find(".itemLoader"); 
      var dataContainer = listItem.find(".itemDataContainer");

      //priceBox.hide();
      dataContainer.hide();
      itemLoader.show();

      $.ajax({
        url: '/items/' + item_id,
        type: 'post',
        data: {item: {price: item_price, quantity: item_quantity}, _method: "put"},
        dataType: 'json',
        async: 'false',
        success: function(data) {
          listItem.find(".priceForm").hide();
          $("#item_" + item_id + "_price_label").html("$ " + (parseFloat(data.item.price) / 100) );
          priceBox.removeClass("priceChanged");
          quantityBox.removeClass("priceChanged");
          priceBox.addClass("priceUpdated");
          quantityBox.addClass("priceUpdated");
          itemLoader.hide();
          dataContainer.show();
          //priceBox.show();
        }
      });

     return false;
   });

   $("[data-type=submitter]").live('click', function() {
     try {
      $(this).parent().submit();
     } catch (e) {
      console.log("Cannot submit a non-form element");
     }
     return false;
   });

   $(".feedback").click(function(){
     var container = $(this).attr('data-container');
     var form = $(container + " form:first") 
     
     form.attr("data-remote", 'true'); //make it an AJAX form for rails
     form.submit(function(){
       $(container).trigger('close');
     });

     $(container).lightbox_me({
      onLoad: function(){
                $(container).find("textarea:first").focus();
              }
     });
     return false;
   });

});

