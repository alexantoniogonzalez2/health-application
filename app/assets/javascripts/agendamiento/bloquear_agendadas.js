function bloquearHoraAgen(agen) {	
  parent = $("#agen"+agen).parent();    
  $.ajax({
    type: 'POST',
    url: '/bloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).remove(); parent.append('<button id="agen'+agen+'" type="button" class="btn btn-xs btn-warning" onclick="desbloquearHoraAgen('+agen+')">Desbloquear Hora</button>'); },
    error: function(xhr, status, error){ alert("No se pudo bloquear la hora.");   }
  });   
}

function desbloquearHoraAgen(agen) {	
  parent = $("#agen"+agen).parent();    
  $.ajax({
    type: 'POST',
    url: '/desbloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).remove(); parent.append('<button id="agen'+agen+'" type="button" class="btn btn-xs btn-default" onclick="bloquearHoraAgen('+agen+')">Bloquear Hora</button>'); },
    error: function(xhr, status, error){ alert("No se pudo desbloquear la hora.");   }
  });   
}