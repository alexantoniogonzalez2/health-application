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

$('select.select-diag-endo').select2({ width: "100%",placeholder: 'Selecciona un diagnóstico', allowClear: true });