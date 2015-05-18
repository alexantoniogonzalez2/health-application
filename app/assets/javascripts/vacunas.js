function actualizarVacunas(vac,estado,tipo){
  
  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

	$.ajax({
    type: 'POST',
    url: '/actualizar_vacunas',
    data: { vac: vac, estado: estado, tipo: tipo, atencion_salud_id: at_salud_id },
    success: function(response) { 
      $('#body-persona-vacuna tr').length > 0 ? $('#vac').addClass('active-ant') : $('#vac').removeClass('active-ant') ;         
    },
    error: function(xhr, status, error){  }
  });
}

$('input[type=checkbox][id^=checkboxes-vac-]').change(function() {
  var vac = $(this).attr('id').substring(15);
  var estado = $(this).is(':checked');
  actualizarVacunas(vac,estado,'calendario'); 
  /*
  var message = $('<p />', { text: 'Se modificará información sobre las vacunas asociadas a la persona.' }),
  ok = $('<button />', { text: 'Modificar', id: 'ok', class: 'btn btn-sm btn-primary' }),
  cancel = $('<button />', { id: 'cancel', text: 'Cancelar', class: 'btn btn-sm btn-danger'  });
  var content = message.add(ok).add(cancel);
  $('<div />').qtip({ 
    content: { text: content, title: '¿Estás seguro de modificar esta información?' },
    position: { my: 'center', at: 'center', target: $(window) },
    show: { ready: true, modal: { on: true, blur: false } },
    hide: false,
    style: 'dialogue',
    events: {  
      render: function(event, api) {
        $('#ok', api.elements.content).click(function(e) {  actualizarVacunas(vac,estado); api.hide(e); });
        $('#cancel', api.elements.content).click(function(e) { api.hide(e);});                
      },
      hide: function(event, api) { api.destroy(); }
    }
  });*/
});

$('input[type=checkbox][id^=check-vac-otras-]').change(function() {
  var vac = $(this).attr('id').substring(16);
  var estado = $(this).is(':checked');
  actualizarVacunas(vac,estado,'otras'); 
});
