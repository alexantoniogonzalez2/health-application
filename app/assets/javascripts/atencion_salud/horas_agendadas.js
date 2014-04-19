function bloquearHora(agen) {	
    
  $.ajax({
    type: 'POST',
    url: '/bloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).html('<button id="agen'+agen+'" type="button" class="btn btn-xs btn-warning" onclick="desbloquearHora('+agen+')">Desbloquear Hora</button>'); },
    error: function(xhr, status, error){ alert("No se pudo bloquear la hora.");   }
  });
   
}

function desbloquearHora(agen) {	
    
  $.ajax({
    type: 'POST',
    url: '/desbloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).html('Holi'); },
    error: function(xhr, status, error){ alert("No se pudo desbloquear la hora.");   }
  });
   
}