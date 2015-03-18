$('#select_medicamento_ant').select2
  width: '380px'
  minimumInputLength: 3
  placeholder: 'Seleccione un medicamento'
  ajax:
    url: '/cargar_medicamentos'
    dataType: 'json'
    type: 'POST'
    data: (term, page) ->
      { q: term }
    results: (data, page) ->
      { results: data }



$('#select_medicamento_ant').on 'change', (e) ->
  value = $('#select_medicamento_ant').select2('data').id
  text = $('#select_medicamento_ant').select2('data').text
  $.ajax
    type: 'POST'
    url: '/agregar_medicamento_ant'
    data:
      persona_id: 'persona'
      medicamento_id: value
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) ->