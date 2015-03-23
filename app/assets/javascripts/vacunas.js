function actualizarVacunas(vac,estado){
	$.ajax({
    type: 'POST',
    url: '/actualizar_vacunas',
    data: { vac: vac, estado: estado },
    success: function(response) { 
      if(!estado){
        $("#tr-pers-vac-"+response).remove();
        var rowCount = $('#tabla-persona-vacunas tr').length;
        if (rowCount == 1)
          $("#body-persona-vacuna").append('<tr id="tr-pers-vac-sin"><td colspan="4">No hay información de vacunas administradas.</td></tr> ');        
      }
      else
        $("#tr-pers-vac-sin").remove();           
    },
    error: function(xhr, status, error){  }
  });
}

$('input[type=checkbox][id^=checkboxes-vac-]').change(function() {
  var vac = $(this).attr('id').substring(15);
  var estado = $(this).is(':checked');
  actualizarVacunas(vac,estado); 
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

