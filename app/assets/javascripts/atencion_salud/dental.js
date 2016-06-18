$("#tooltip_dental").mouseleave(function() {
  $( "#tooltip_dental" ).hide(); 
});

$("#tooltip_endodoncia").mouseleave(function() {
  $( "#tooltip_endodoncia" ).hide(); 
});

$(".content-tooltip").mouseleave(function() {
  	$( "#tooltip_endodoncia" ).hide();
});

$('select.select-diag-endo').select2({ width: "100%",placeholder: 'Selecciona un diagnóstico', allowClear: true });
