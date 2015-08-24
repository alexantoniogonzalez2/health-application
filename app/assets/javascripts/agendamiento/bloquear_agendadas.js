function bloquearHora(agen) {	

  parent = $("#agen"+agen).parent();
    
  $.ajax({
    type: 'POST',
    url: '/bloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).remove(); parent.append('<button id="agen'+agen+'" type="button" class="btn btn-xs btn-warning" onclick="desbloquearHora('+agen+')">Desbloquear Hora</button>'); },
    error: function(xhr, status, error){ alert("No se pudo bloquear la hora.");   }
  });
   
}

function desbloquearHora(agen) {	

  parent = $("#agen"+agen).parent();
    
  $.ajax({
    type: 'POST',
    url: '/desbloquear_hora',
    data: { agendamiento_id: agen },
    success: function(response) { $("#agen"+agen).remove(); parent.append('<button id="agen'+agen+'" type="button" class="btn btn-xs btn-default" onclick="bloquearHora('+agen+')">Bloquear Hora</button>'); },
    error: function(xhr, status, error){ alert("No se pudo desbloquear la hora.");   }
  });
   
}