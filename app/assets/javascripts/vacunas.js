function actualizarVacunas(vac,estado){
	$.ajax({
    type: 'POST',
    url: '/actualizar_vacunas',
    data: { vac: vac, estado: estado },
    success: function(response) {  },
    error: function(xhr, status, error){  }
  });
  alert('hola');

}

$('input[type=checkbox][id^=checkboxes-vac-]').change(function() {
  var vac = $(this).attr('id').substring(15);
  var estado = $(this).is(':checked');
   var message = $('<p />', { text: 'Click a button to exit the custom dialogue' }),
      ok = $('<button />', {
        text: 'Ok',
        id: 'ok'
      }),
      cancel = $('<button />', {
      	id: 'cancel',
        text: 'Cancel'
      });
  var content = message.add(ok).add(cancel)    

  $('<div />').qtip({
        content: {
            text: content,
            title: 'Do you agree?'
        },
        position: {
            my: 'center', at: 'center',
            target: $(window)
        },
        show: {
            ready: true,
            modal: {
                on: true,
                blur: false
            }
        },
        hide: false,
        style: 'dialogue',
        events: {
            render: function(event, api) {
                $('#ok', api.elements.content).click(function(e) {  actualizarVacunas(vac,estado); api.hide(e); });
                $('#cancel', api.elements.content).click(function(e) { api.hide(e);});
                
            },
            hide: function(event, api) { api.destroy(); }
        }
    });




});

