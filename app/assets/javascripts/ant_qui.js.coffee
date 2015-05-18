$('#select_procedimiento_ant').select2
  width: '380px'
  minimumInputLength: 3
  placeholder: 'Seleccione un procedimiento'
  ajax:
    url: '/cargar_prestaciones'
    dataType: 'json'
    type: 'POST'
    data: (term, page) ->
      { q: term, tipo: 'procedimiento' }
    results: (data, page) ->
      { results: data }

$('#select_procedimiento_ant').on 'change', (e) ->
  value = $('#select_procedimiento_ant').select2('data').id
  text = $('#select_procedimiento_ant').select2('data').text
  if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'
  $.ajax
    type: 'POST'
    url: '/agregar_prestacion_ant'
    data:
      atencion_salud_id: at_salud_id
      prestacion_id: value
      tipo: 'procedimiento'
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) -> $('#ant_qui').addClass 'active-ant' if $('#lista-procedimientos tr').length > 0