function actualizarDiagPres(p_p,tipo){
	if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  $('#div-diag-pres'+p_p).empty();
  $.ajax({
    type: 'POST',
    url: '/agregar_diag_pres',
    data: { id: p_p, atencion_salud_id: at_salud_id, tipo: tipo },
    success: function(response) { },
    error: function(xhr, status, error){ }
  });
}