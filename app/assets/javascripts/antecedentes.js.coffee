guardarActividad = (valor,pregunta) ->
  $.ajax '/actividad_fisica',
    type: 'POST'
    data:
      valor : valor
      pregunta : pregunta     
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) ->

calculaActVig = ->
  preg_2 = $('#input-act-fis-2').val()
  preg_3 = $('#input-act-fis-3').val()
  preg_11 = $('#input-act-fis-11').val()
  preg_12 = $('#input-act-fis-12').val()
  return preg_2*preg_3 + preg_11*preg_12

calculaActMod = ->
  preg_5 = $('#input-act-fis-5').val()
  preg_6 = $('#input-act-fis-6').val()
  preg_8 = $('#input-act-fis-8').val()
  preg_9 = $('#input-act-fis-9').val()
  preg_14 = $('#input-act-fis-14').val()
  preg_15 = $('#input-act-fis-15').val()
  return preg_5*preg_6 + preg_8*preg_9 + preg_14*preg_15

actualizarDiagnostico = (edad) ->
  act_vig = calculaActVig()
  act_mod = calculaActMod()
  total_equi = act_vig*2 + act_mod
  total = act_vig + act_mod
  diagnostico = 'insuficiente'
  switch 
    when edad < 5 then diagnostico = 'sin_recomendacion'
    when edad < 18
      preg_11 = $('#input-act-fis-11').val()
      preg_14 = $('#input-act-fis-14').val()
      if total >= 420 
        if preg_11 >= 3 
          diagnostico = 'recomendado'
        if preg_14 >= 3 
          diagnostico = 'ideal'
    else
      if act_vig > 75 or act_mod > 150 or total_equi > 150 then diagnostico = 'recomendado'
      if act_vig > 150 or act_mod > 300 or total_equi > 300 then diagnostico = 'ideal'
   
  switch diagnostico
    when 'sin_recomendacion'
      $('#calculo-actividad-fisica').attr 'class', 'alert alert-warning'
      $('span[name=diag_act_fis]').html('sin recomendaciones') 
    when 'insuficiente'
      $('#calculo-actividad-fisica').attr 'class', 'alert alert-danger'
      $('span[name=diag_act_fis]').html('insuficiente') 
    when 'recomendado'
      $('#calculo-actividad-fisica').attr 'class', 'alert alert-warning'
      $('span[name=diag_act_fis]').html('cumple con las recomendaciones') 
    when 'ideal' 
      $('#calculo-actividad-fisica').attr 'class', 'alert alert-success'
      $('span[name=diag_act_fis]').html('ideal')  

ocultarPreguntas = (valor,pregunta) ->
  $('#preg-'+pregunta).show() if valor == 1 or valor == '1'
  if valor == 0 or valor == '0'
    preg_1 = parseInt( pregunta, 10 )+1
    preg_2 = parseInt( pregunta, 10 )+2
    $('#input-act-fis-'+preg_1).val('0')
    $('#input-act-fis-'+preg_2).val('0')
    $('#preg-'+pregunta).hide()
    calculaAct()
    guardarActividad( 0, preg_1 )
    guardarActividad( 0, preg_2 )
    id_diag = $('span[name=diag_act_fis]').attr "id"
    edad = id_diag.substring(13)
    actualizarDiagnostico(edad) unless edad == 'sin_info' 
    
calculaAct = ->
  act_vig = calculaActVig()
  act_mod = calculaActMod() 
  $('#min_act_fis_vig').html(act_vig)
  $('#min_act_fis_mod').html(act_mod)
  return 

$(document).ready ->
  ocultarPreguntas($('input[name=rad-act-fis-1]:checked').val(),'1')
  ocultarPreguntas($('input[name=rad-act-fis-4]:checked').val(),'4')
  ocultarPreguntas($('input[name=rad-act-fis-7]:checked').val(),'7')
  ocultarPreguntas($('input[name=rad-act-fis-10]:checked').val(),'10')
  ocultarPreguntas($('input[name=rad-act-fis-13]:checked').val(),'13')
  calculaAct()
  id_diag = $('span[name=diag_act_fis]').attr "id"
  edad = id_diag.substring(13) unless !id_diag?
  actualizarDiagnostico(edad) unless edad == 'sin_info'
  $('span[name=diag_act_fis]').html('falta agregar la edad') if edad == 'sin_info' 
  $('input[id^=input-act-fis-]').keyup ->
    calculaAct()
    id_diag = $('span[name=diag_act_fis]').attr "id"
    edad = id_diag.substring(13)
    actualizarDiagnostico(edad) unless edad == 'sin_info'
    actualizarDiagnostico    
    return 
  $('input[type=radio][name^=rad-act-fis-]').change ->
    id = $(this).attr "name"
    pregunta_id = id.substring(12)
    estado = $(this).val()
    ocultarPreguntas(estado,pregunta_id)
    guardarActividad(estado,pregunta_id) 
    return

$("#form_act_fis")
  .bootstrapValidator
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      'dias_actividad[]':
        validators: 
          between:
            message: 'Ingrese un valor positivo entre 1 y 7.'
            min: 1
            max: 7
          notEmpty:
            message: 'Ingrese un valor positivo entre 1 y 7.' 
          integer:   
            message: 'Ingrese un valor entero.'
      'minutos_actividad[]':
        validators: 
          between:
            message: 'Ingrese un valor positivo entre 1 y 1.440.'
            min: 1
            max: 1440
          notEmpty:
            message: 'Ingrese un valor positivo entre 1 y 1.440.' 
          integer:   
            message: 'Ingrese un valor entero.'  
  .on("success.field.bv", "[name=\"dias_actividad[]\"]", (e, data) -> guardarActividad( $(this).val(),($(this).attr "id").substring(14) ))
  .on("success.field.bv", "[name=\"minutos_actividad[]\"]", (e, data) -> guardarActividad( $(this).val(),($(this).attr "id").substring(14) ))

$('#select_medicamento').select2
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