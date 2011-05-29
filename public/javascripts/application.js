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
      var inputBox = $("#item_" + item_id + "_price");
      var item_price = inputBox.val();
      var listItem = $("li#item_" + item_id);
      var itemLoader = listItem.find(".itemLoader"); 

      inputBox.hide();
      itemLoader.show();

      $.ajax({
        url: '/items/' + item_id,
        type: 'post',
        data: {item: {price: item_price}, _method: "put"},
        dataType: 'json',
        async: 'false',
        success: function(data) {
          listItem.find(".priceForm").hide();
          $("#item_" + item_id + "_price_label").html("$ " + (parseFloat(data.item.price) / 100) );
          inputBox.removeClass("priceChanged");
          inputBox.addClass("priceUpdated");
          itemLoader.hide();
          inputBox.show();
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

