// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require clipboard
function copyToClipboard(element) {
    var $temp = $("<input>");
    $("body").append($temp);
    console.log(element);
    $temp.val(element.val()).select();
    document.execCommand("copy");
    $temp.remove();
}

$(document).ready(function(){
  $('#menu-btn').click(function(){
    if ($( "#flex-sidebar" ).hasClass( "full" )){
        $( "#flex-sidebar" ).removeClass( "full" ).addClass( "minimized" );
        $( "#content" ).removeClass( "minimized" ).addClass( "full" );
      }
    else{
        $( "#flex-sidebar" ).removeClass( "minimized" ).addClass( "full" );
        $( "#content" ).removeClass( "full" ).addClass( "minimized" );
    }
  });
  new Clipboard('#copy');
  // $("#copy").click(function(){
  //   copyToClipboard($("#link-1"));
  // });
});
$('.confirm>input[type="submit"]').click(function (e) {
  var form = $('#'+$('#money_input').find('input[type="radio"]:checked').data('service_type'));
  var form_id = form.attr('id');
  var form_amount_field;
  if (form_id == 'liqpay') {
    $.ajax({
      url: "/finance_api/payment_form?service_name=liqpay&amount="+parseInt($('input[name="amount"]').val()),
    }).done(function(responce) {
      var anchor_form = $('#liqpay');
      responce = $(responce).css('display','none');
      responce.attr('id', form_id);
      anchor_form.after(responce);
      anchor_form.remove();
      responce.submit();
    });

    // form_amount_field = $('#ac_amount');
  }else if(form_id == 'advcash'){
   
   $.ajax({
      url: "/finance_api/payment_form?service_name=advcash&amount="+parseFloat($('input[name="amount"]').val())+"&order_id="+$('#ac_order_id').val(),
    }).done(function(responce) {
      form.find('#ac_sign').val(responce);
      form.find('#ac_amount').val(parseFloat($('input[name="amount"]').val()));
      console.log(form);
      form.submit();
    });
  }else{
    form_amount_field = form.find('#PAYMENT_AMOUNT');
  }
  if(form_id != 'liqpay' && form_id != 'advcash'){
    form_amount_field.val(parseFloat($('input[name="amount"]').val()));
    form.submit();
  }
})
