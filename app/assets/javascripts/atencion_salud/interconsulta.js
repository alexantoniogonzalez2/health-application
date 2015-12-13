/*$(function() {

  $('.panel_interconsulta').bind('click', function (e) {
    
    var id = $(this).attr('id');      
    p_d = id.substring(9);
    agregarPresInt(p_d,'act');
    
  });
});

$(function() {

  $('.panel_interconsulta_ant').bind('click', function (e) {
    
    var id = $(this).attr('id');      
    p_d = id.substring(9);
    agregarPresInt(p_d,'ant');
    
  });
});*/

function agregarPresInt(p_d,tipo_diag,tipo){
  $('#int_diag'+p_d).empty();
  $.ajax({
    type: 'POST',
    url: '/agregar_pres_int',
    data: { p_d: p_d, tipo_diag: tipo_diag, tipo: tipo },
    success: function(response) { },
    error: function(xhr, status, error){ }
  });

}