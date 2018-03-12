$("#tooltip_dental").mouseleave(function() {
  $( "#tooltip_dental" ).hide(); 
});

$("#tooltip_endodoncia").mouseleave(function() {
  $( "#tooltip_endodoncia" ).hide(); 
});

$(".content-tooltip").mouseleave(function() {
  $( "#tooltip_endodoncia" ).hide();
});

$("#tooltip_test").mouseleave(function() {
  $( "#tooltip_test" ).hide(); 
});

$(".ajus-end").mouseleave(function() {
  $( "#tooltip_test" ).hide(); 
});

$("#tooltip_tratamiento").mouseleave(function() {
  $( "#tooltip_tratamiento" ).hide(); 
});

$(".content-tooltip-trat").mouseleave(function() {
  $( "#tooltip_tratamiento" ).hide(); 
});


function isNumber(evt) {
  evt = (evt) ? evt : window.event;
  var charCode = (evt.which) ? evt.which : evt.keyCode;
  if (charCode > 48 && charCode < 53 ) {
      return true;
  }
  return false;
}