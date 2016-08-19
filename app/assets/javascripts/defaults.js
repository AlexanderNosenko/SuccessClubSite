//= require toastr/toastr.min.js

$(document).ready(function() {
  var toastElem = $(".toastr");
  //console.log(toastElem.get(0));
  if(toastElem.get(0)){
    toastr.success(toastElem.text());
  }
});
