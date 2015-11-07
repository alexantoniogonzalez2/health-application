$('.ges-cancelar').click(function() {
  var pd = $(this).attr('id').substring(13);
  $("#per_not_"+pd).collapse('hide');
});

$('.int-cancelar').click(function() {
  var pd = $(this).attr('id').substring(13);
  $("#per_int_"+pd).collapse('hide');
});

$('.panel-int2').on('shown.bs.collapse', function() { 
  var pd = $(this).attr('id').substring(8);
  $("#int_nombre_"+pd+","+"#int_rut_"+pd+","+"#int_correo_"+pd+","+"#int_celular_"+pd).val('');
  $("#row_int_nombre_"+pd+","+"#row_int_rut_"+pd+","+"#row_int_correo_"+pd+","+"#row_int_celular_"+pd).hide();  
  $("#int_div_"+pd).show(); 
  $("#int_div_"+pd).css( "display", "block !important");
});

$('.panel-int2').on('hidden.bs.collapse', function() { 
  var pd = $(this).attr('id').substring(8);
  $("#int_div_"+pd).hide();
  $("#row_int_nombre_"+pd+","+"#row_int_rut_"+pd+","+"#row_int_correo_"+pd+","+"#row_int_celular_"+pd).show(''); 
});

$('.panel-ges2').on('shown.bs.collapse', function() { 
  var pd = $(this).attr('id').substring(8);
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).val('');
  $("#row_nombre_"+pd+","+"#row_rut_"+pd+","+"#row_correo_"+pd+","+"#row_celular_"+pd).hide();  
  $("#ges_div_"+pd).show(); 
  $("#ges_div_"+pd).css( "display", "block !important");
});

$('.panel-ges2').on('hidden.bs.collapse', function() { 
  var pd = $(this).attr('id').substring(8);
  $("#ges_div_"+pd).hide();
  $("#row_nombre_"+pd+","+"#row_rut_"+pd+","+"#row_correo_"+pd+","+"#row_celular_"+pd).show(''); 
});

function actualizarEstado(pers_diag,e_d){
  
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  (e_d == 1) ? $( '#checkboxes-trat-div-'+pers_diag).show() : $( '#checkboxes-trat-div-'+pers_diag).hide();
 
  if(e_d == 1) { 
    estado_trat = (trat == 1) ? 2 : 1; 
    $('input[name=radios-ges-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
    $('input[name=radios-int-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  }
  else { 
    $('input[name=radios-ges-'+pers_diag+']').prop('checked', false);
    $('input[name=radios-int-'+pers_diag+'][value=1]').prop('checked', false);
    $('input[name=radios-int-'+pers_diag+'][value=2]').prop('checked', false);
  }
  guardarDiagnostico(pers_diag,false);
}
function guardarDiagReabrir(pers_diag){
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  e_d = $('input[type=radio][name=radios-estado-'+pers_diag+']:checked').val();
  (e_d == 1) ? $( '#checkboxes-trat-div-'+pers_diag).show() : $( '#checkboxes-trat-div-'+pers_diag).hide(); 
  if(e_d == 1) { 
    estado_trat = (trat == 1) ? 2 : 1; 
    $('input[name=radios-ges-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
    $('input[name=radios-int-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  }
  else { 
    $('input[name=radios-ges-'+pers_diag+']').prop('checked', false);
    $('input[name=radios-int-'+pers_diag+'][value=1]').prop('checked', false);
    $('input[name=radios-int-'+pers_diag+'][value=2]').prop('checked', false);
  }
  var fecha_hora = getFechaActual() + ' ' + getHoraActual(); 
  var pre_estado = $("label[for='radios-"+pers_diag+"-"+pre_e_d+"']").text();
  $('#reabrir-estado-diag-'+pers_diag).append("<span>Fecha: "+fecha_hora+" Estado anterior: "+pre_estado+" </span><br/>")
  
  guardarDiagnostico(pers_diag,false);
}

function agregarPropInt(pers_diag,value){
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'proposito',
      valor: value,
      pers_diag: pers_diag,
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("No se pudo agregar la información."); }
  });
}

$('input[type=checkbox][id^=checkboxes-trat-]').change(function() {
  var pers_diag = $(this).attr('id').substring(16);
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  
  estado_trat = (trat == 1) ? 2 : 1;
  $('input[name=radios-ges-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  $('input[name=radios-int-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  guardarDiagnostico(pers_diag,false);

});

function actualizarEnfCron(pers_diag){
  guardarDiagnostico(pers_diag,false);
}

$('.modal-diag').on('show.bs.modal', function (e) {
  id_mod = this.id.substring(21);
  pre_f_i = $('.datepicker[name=f_i_'+id_mod+']').datepicker("getDate");
  pre_f_t = $('.datepicker[name=f_t_'+id_mod+']').datepicker("getDate");
  pre_e_d = $('#e_d_'+id_mod).find('input[name=radios-estado-'+id_mod+']:checked').val();
  pre_enf_cro = $('#enf_cro_'+id_mod).find('input[name=checkboxes]').is(':checked');
  pre_trat = $('#trat_'+id_mod).find('input[name=checkboxes]').is(':checked');
  pre_comentario = $('#comentario_'+id_mod).val();
})


$('#motivo_consulta').keyup( function(e) {
  if (typeof contador_mot === 'undefined') { } 
  else { clearTimeout(contador_mot);}
  contador_mot = setTimeout(function(){ guardarTexto('motivo') },2000);
})

$('#examen_fisico').keyup( function(e) { 
  if (typeof contador_exa === 'undefined') { } 
  else { clearTimeout(contador_exa);}
  contador_exa = setTimeout(function(){ guardarTexto('examen') },2000);
})

$('#indicaciones_generales').keyup( function(e) { 
  if (typeof contador_ind === 'undefined') { } 
  else { clearTimeout(contador_ind);}
  contador_ind = setTimeout(function(){ guardarTexto('indicaciones') },2000);
})

$('#anamnesis').keyup( function(e) { 
  if (typeof contador_ana === 'undefined') { } 
  else { clearTimeout(contador_ana);}
  contador_ana = setTimeout(function(){ guardarTexto('anamnesis') },2000);
})

function autoguardarComentarioOnkeyup(p_d) {  
  if (typeof contador_com === 'undefined') { } 
  else { clearTimeout(contador_com);}
  contador_com = setTimeout(function(){ autoguardarComentario(p_d) },2000);
}

function autoIntComment(p_d){  
  if (typeof contador_int_com === 'undefined') { } 
  else { clearTimeout(contador_int_com);}
  contador_int_com = setTimeout(function(){ autoguardarComentarioInt(p_d) },2000);
}

function autoIntPdt(p_d){
  if (typeof contador_int_pdt === 'undefined') { } 
  else { clearTimeout(contador_int_pdt);}
  contador_int_pdt = setTimeout(function(){ autoguardarPrestadorDestinoTexto(p_d) },2000); 
}

$('select.select_especialidad').select2({ width: '80%', placeholder: 'Selecciona una especialidad', allowClear: true });
$('select.select_prestadores').select2({ width: '80%', placeholder: 'Selecciona un establecimiento', allowClear: true });
$('select.select-conf-diag').select2({ width: '80%', placeholder: 'Selecciona un tipo de diagnóstico', allowClear: true });


$('#select_diagnostico').select2({
  width: '380px',
  style: 'float: right',
  minimumInputLength: 3,
  placeholder: "Selecciona un diagnóstico",
  ajax: {
    url: '/cargar_diagnosticos',
    dataType: 'json',
    type: 'POST',
    data: function (params) { return { q: params.term, page: params.page, diag_no_frec: diagnosticoNoFrecuente('#diag-no-frec') }; },
    processResults: function (data, page) { return { results: data }; }   
  },
  cache: true
});

$('#select_examen').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Selecciona un examen",
  ajax: {
    url: '/cargar_prestaciones',
    dataType: 'json',
    type: 'POST',
    data: function (params) { return { q: params.term, tipo: 'examen' }; },
    processResults: function (data, page) { return { results: data }; },
  }
});

$('#select_procedimiento').select2({
  width: '360px',
  minimumInputLength: 3,
  placeholder: "Selecciona un procedimiento",
  ajax: {
    url: '/cargar_prestaciones',
    dataType: 'json',
    type: 'POST',
    data: function (params) { return { q: params.term, tipo: 'procedimiento'}; },
    processResults: function (data, page) { return { results: data }; }
  }
});

$('#select_medicamento').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Selecciona un medicamento",
  ajax: {
    url: '/cargar_medicamentos',
    dataType: 'json',
    type: 'POST',
    data: function (params) { return { q: params.term }; },
    processResults: function (data, page) { return { results: data }; }
  }
});

$("#select_diagnostico").on("change", function(e) { 
  var value = $("#select_diagnostico").val();
  if (value != '')
    agregarDiagnostico(value);
})

$('.select_diag').on("change", function(e) { 
  var id = $(this).attr('id').substring(16);
  var tipo = $(this).attr('id').substring(12,15);
  if (id != 'new' && tipo != 'cro') 
    guardarAntecedenteFamiliarMuerte(id,false);  
})

function cambiarAntecedente(id){  
  guardarAntecedenteFamiliarMuerte(id,true); 
}

$('.cambiar_antecedente_cro').click(function() {
  var id = $(this).attr('id').substring(20); 
  guardarAntecedenteFamiliarCronica(id,true);  
});

$(".select_prestadores").on("change", function(e) { 
  var pd = $(this).attr('id').substring(22);   
  value = $("#select_prestadores_int"+pd).val();;    
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'prestador',
      valor: value,
      pers_diag: pd,
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("No se pudo agregar el prestador."); }
  });   
})

function selectPersonaIntNot(p_d,tipo){ 
  var url = '/agregar_info_interconsulta';
  if (tipo == "not_")
    url = '/agregar_persona_notificacion';   
  value = $("#select_"+tipo+p_d).val();
  $.ajax({
    type: 'POST',
    url: url,
    data: { tipo: 'persona', valor: value, pers_diag: p_d},
    success: function(response){
      $("#"+tipo+"nombre_"+p_d).html( response.nombre );
      $("#"+tipo+"rut_"+p_d).html( response.rut );
      $("#"+tipo+"correo_"+p_d).html( response.correo );
      $("#"+tipo+"celular_"+p_d).html( response.celular ); 
      $("#"+tipo+"telefono_"+p_d).html( response.telefono ); 
    },
    error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
  });  
}

function selectEspecialidadInterconsulta(p_d){ 
  value = $("#select_especialidad_int"+p_d).val();    
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'especialidad',
      valor: value,
      pers_diag: p_d,
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("No se pudo agregar la especialidad."); }
  });  
}

$("#select_examen").on("change", function(e) { 

  var value = $("#select_examen").val();

  if (value != ''){  
    $.ajax({
      type: 'POST',
      url: '/agregar_prestacion',
      data: {
        persona_id: persona_id,
        prestacion_id: value,
        atencion_salud_id: atencion_salud_id,
        tipo: 'examen'
      },
      success: function(response) { $("#select_examen").select2("val", ""); },
      error: function(xhr, status, error){ alert("No se pudo agregar el examen del paciente."); }
    }); 
  }
})

$("#select_procedimiento").on("change", function(e) { 

  var value = $("#select_procedimiento").val();
  if (value != ''){ 
    $.ajax({
      type: 'POST',
      url: '/agregar_prestacion',
      data: {
        persona_id: persona_id,
        prestacion_id: value,
        atencion_salud_id: atencion_salud_id,
        tipo: 'procedimiento'
      },
      success: function(response) { $("#select_procedimiento").select2("val", ""); },
      error: function(xhr, status, error){ alert("No se pudo agregar el procedimiento o cirugía del paciente."); }
    });
  }
})

$("#select_medicamento").on("change", function(e) { 

  var value = $("#select_medicamento").val();
  
  if (value != ''){ 
    $.ajax({
      type: 'POST',
      url: '/agregar_medicamento',
      data: {
        persona_id: persona_id,
        medicamento_id: value,
        atencion_salud_id: atencion_salud_id,
      },
      success: function(response) { $("#select_medicamento").select2("val", ""); },
      error: function(xhr, status, error){ alert("No se pudo agregar el medicamento del paciente."); }
    });  
  }
})

function selectPaisContagio(p_d){
  var value = $("#select-pais-contagio"+p_d).val();
  agregarInfoEno(p_d,value,'pais');
}

function selectConfirmacion(p_d){
  var value = $("#select-confirmacion"+p_d).val();
  agregarInfoEno(p_d,value,'confirmacion');
}

function radioAntVac(p_d,value){
  agregarInfoEno(p_d,value,'vacunacion');
}

function radiosEmb(p_d,value){
  agregarInfoEno(p_d,value,'embarazo');
}

function radiosTbc(p_d,value){
  agregarInfoEno(p_d,value,'tbc');
}

function semGes(p_d){
  var value =$('#semanas-'+p_d).val();
  agregarInfoEno(p_d,value,'sem_emb'); 
}

$("#alergias").submit(function (e) { return false; });

$('input[id^=fecha]').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

$('.fecha-mes').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
});

$('.fecha').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
});

$('input[id^=fecha-afm]').on("dp.change", function (e) {
  var id = $(this).attr('id').substring(10);
  if ( id != 'new') 
    guardarAntecedenteFamiliarMuerte(id,false);
});

$('input[id^=control]').on("dp.change", function (e) {
  var id = $(this).attr('id').substring(7);
  actualizarFechaAlta(id);
});

function diagnosticoNoFrecuente(id){
  var check_no_frec = $(id).is(':checked');  
  return check_no_frec;
}

function agregarDiagnostico(diag_id){
  $.ajax({
    type: 'POST',
    url: '/agregar_diagnostico',
    data: {
      persona_id: persona_id,
      diagnostico_id: diag_id,
      atencion_salud_id: atencion_salud_id,
    },
    success: function(response) { $("#select_diagnostico").select2("val", ""); },
    error: function(xhr, status, error){ alert("No se pudo agregar el diagnóstico del paciente."); }
  });

}

function eliminarDiagnostico(pers_diag_aten_sal) {
  
  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { persona_diagnostico_atencion_salud_id: pers_diag_aten_sal, atencion_salud_id: at_salud_id },
    success: function(response) {
      $("#modal-container-diag-"+pers_diag_aten_sal).modal('hide');
      $("#pd"+pers_diag_aten_sal).remove();
      $(".diag-med-"+pers_diag_aten_sal).remove();
      $("[id^=div-diagnosticos-]").each(function( ) {
        var med = $(this).attr('id').substring(17);
        if ($('#div-diagnosticos-'+med+' div').length == 0 )
          $('#div-diagnosticos'+med).append('<p id="no-med-'+med+'">No hay diagnósticos seleccionados.</p>');     
      });
          
    },
    error: function(xhr, status, error){ alert("No se pudo eliminar el diagnóstico del paciente.");   }
  });
   
}

function eliminarMedicamento(pers_med) {

  $.ajax({
    type: 'POST',
    url: '/eliminar_medicamento',
    data: { persona_medicamento_id: pers_med},
    success: function(response) { 
      $("#modal-container-med-"+pers_med).modal('hide');
      $("#pm"+pers_med).remove();
      $("#tr-med-"+pers_med).remove();
      if ($('#lista-medicamentos tr').length == 0 )
        $('#med').removeClass('active-ant');      
    },
    error: function(xhr, status, error){ alert("No se pudo eliminar el medicamento del paciente.");   }
  });
   
}

function actualizarDiagnostico(diag,pers_diag){

  $( "#modal-container-diag-ant"+pers_diag).modal('hide');
  agregarDiagnostico(diag);
  $( "#modal-container-diag-"+pers_diag).modal('show');
}

function guardarDiagnostico(pers_diag_aten_sal,cerrar) {

  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  var f_i = $('.datepicker[name=f_i_'+pers_diag_aten_sal+']').datepicker("getDate");
  var f_t = $('.datepicker[name=f_t_'+pers_diag_aten_sal+']').datepicker("getDate");
  var e_d = $('#e_d_'+pers_diag_aten_sal).find('input[name=radios-estado-'+pers_diag_aten_sal+']:checked').val();
  var enf_cro = $('#enf_cro_'+pers_diag_aten_sal).find('input[name=checkboxes]').is(':checked');
  var trat = $('#trat_'+pers_diag_aten_sal).find('input[name=checkboxes]').is(':checked');
  var comentario = $('#comentario_'+pers_diag_aten_sal).val();

  $('.datepicker[name=f_s_'+pers_diag_aten_sal+']').datepicker("setDate",f_i);
  $.ajax({
    type: 'POST',
    url: '/guardar_diagnostico',
    data: {
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: at_salud_id,
      fecha_inicio: f_i,
      fecha_termino: f_t,
      estado_diagnostico: e_d,
      comentario: comentario,
      enf_cro: enf_cro,
      trat: trat
     },
    success: function(response) { 
      if (cerrar)  
        $( "#modal-container-diag-"+pers_diag_aten_sal).modal('hide');
    },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente."); }
  });

}

function guardarMedicamento(pers_med, cerrar) {
  if (typeof atencion_salud_id !== 'undefined') { }
  else { atencion_salud_id = 'persona'; } 

  $.ajax({
    type: 'POST',
    url: '/guardar_medicamento',
    data: {
      atencion_salud_id: atencion_salud_id,
      persona_medicamento_id: pers_med,
      cantidad: $( "#cantidad-"+pers_med).val(),
      periodicidad: $( "#periodicidad-"+pers_med).val(),
      duracion: $( "#duracion-"+pers_med).val(),  
      total: $( "#total-"+pers_med).val(),        
      indicacion: $( "#indicacion-"+pers_med).val(),
      via_administracion: $("#select-via-administracion"+pers_med).val(),           
    },
    success: function(response) {
      if (cerrar) 
        $( "#modal-container-med-"+pers_med).modal('hide');
    },
    error: function(xhr, status, error){ alert("No se pudo guardar el medicamento del paciente.");   }
  });

}

function eliminarPrestacion(pers_pre) {

  $.ajax({
    type: 'POST',
    url: '/eliminar_prestacion',
    data: { 
      persona_prestacion_id: pers_pre 
    },
    success: function(response) { 
      $("#modal-container-pres-"+pers_pre).modal('hide');
      $("#pp"+pers_pre).remove();
      $("#tr-pre-"+pers_pre).remove();
      if ($('#lista-procedimientos tr').length == 0 )
        $('#ant_qui').removeClass('active-ant');
    },
    error: function(xhr, status, error){ alert("No se pudo eliminar el examen o procedimiento del paciente."); }
  });
   
}

function calcularTotalMedicamentos(pers_med) {
  var cantidad = $( "#cantidad-"+pers_med).val();
  var periodicidad = $( "#periodicidad-"+pers_med).val();
  var duracion = $( "#duracion-"+pers_med).val();
  if (duracion != '')  
    var total = cantidad*(24/periodicidad)*duracion;
  else
    var total = cantidad*(24/periodicidad);

  if (cantidad != "" && periodicidad != ""){
    $("#total-"+pers_med).val(total);
    $("#total-ml-"+pers_med).val(total/20);
  } else {
    $("#total-"+pers_med).val('');
    $("#total-ml-"+pers_med).val('');
  }
  if (duracion != ''){
    var myDate = new Date();
    myDate.setDate(myDate.getDate() + parseInt(duracion) );
    $('#fec-med-est-'+pers_med).html(formatDate(myDate));
  }
  else
    $('#fec-med-est-'+pers_med).html('');

  guardarMedicamento(pers_med,false);

}

function calcularIMC(pers_aten) {
  var peso = $( "#peso-"+pers_aten).val();
  var estatura = $( "#estatura-"+pers_aten).val()/100;
  var imc = peso/(estatura*estatura);
  if (isNumeric(peso) && isNumeric(estatura))
    $("#imc-" + pers_aten).val(Math.round(imc * 100) / 100 );
}

function calcularPAM(pers_aten) {
  var sis = $( "#presion-sis-"+pers_aten).val();
  var dias = $( "#presion-dias-"+pers_aten).val();
  var pam = parseFloat(dias) + (sis-dias)/3;
  if (isNumeric(sis) && isNumeric(dias))
    $("#presion-am-" + pers_aten).val(Math.round(pam * 100) / 100 );
}

function guardarMetricas(pers_aten) {
  var peso = $("#peso-"+pers_aten).val();
  var estatura = $("#estatura-"+pers_aten).val();
  var imc = $("#imc-"+pers_aten).val();
  if (isNumeric(peso) && isNumeric(estatura) && isNumeric(imc)){    
    $.ajax({
      type: 'POST',
      url: '/guardar_metricas',
      data: {
        atencion_salud_id: pers_aten,
        persona_id: persona_id,
        peso: peso,
        estatura: estatura,
        imc: imc,     
      },
      success: function(response) { /*$( "#modal-container-metricas").modal('hide');*/ },
      error: function(xhr, status, error){ alert("No se pudo guardar las métricas del paciente.");   }
    });
  } else
    alert("No se pudo guardar las métricas del paciente. Problema con el formato.");  
}

function guardarSignos(pers_aten) {
  var frec_car = $( "#frec_car-"+pers_aten).val();
  var frec_res = $( "#frec_res-"+pers_aten).val();
  var temp = $( "#temp-"+pers_aten).val();  
  var presion_am = $( "#presion-am-"+pers_aten).val();
  var presion_dias = $( "#presion-dias-"+pers_aten).val();
  var presion_sis = $( "#presion-sis-"+pers_aten).val();
  var sat = $( "#sat-"+pers_aten).val();
  if (isNumeric(frec_car) && isNumeric(frec_res) && isNumeric(temp) && isNumeric(presion_am) && isNumeric(presion_dias) && isNumeric(presion_sis) && isNumeric(sat)){  
    $.ajax({
      type: 'POST',
      url: '/guardar_signos',
      data: {
        atencion_salud_id: pers_aten,
        persona_id: persona_id,
        frec_car: frec_car,
        frec_res: frec_res,
        temp: temp,  
        presion_am: presion_am,
        presion_dias: presion_dias,
        presion_sis: presion_sis,
        sat: sat,
        car_frec_car: $( "#car_frec_car-"+pers_aten).val(),
        car_frec_res: $( "#car_frec_res-"+pers_aten).val(),
        car_temp: $( "#car_temp-"+pers_aten).val(),  
        car_presion_am: $( "#car_presion-am-"+pers_aten).val(),
        car_presion_sis: $( "#car_presion-sis-"+pers_aten).val(), 
        car_presion_dias: $( "#car_presion-dias-"+pers_aten).val(),   
        car_sat: $( "#car_sat-"+pers_aten).val(),      
      },
      success: function(response) { /*$( "#modal-container-signos").modal('hide');*/ },
      error: function(xhr, status, error){ alert("No se pudo guardar los signos vitales del paciente.");   }
    });
  } else
    alert("No se pudo guardar los signos del paciente. Problema con el formato.");  

}

function guardarTexto(tipo_texto) {
  switch (tipo_texto) {
    case 'motivo':      
      texto = $('#motivo_consulta').val();
      break;     
    case 'examen':
      texto = $('#examen_fisico').val();
      break;  
    case 'indicaciones':
      texto = $('#indicaciones_generales').val();
      break;
    case 'anamnesis':
      texto = $('#anamnesis').val();
      break;  
  }

  $.ajax({
    type: 'POST',
    url: '/guardar_texto',
    data: {
      atencion_salud_id: atencion_salud_id,
      tipo_texto: tipo_texto,
      texto: texto,    
  },
    success: function(response) { 
      $('#auto-' + tipo_texto ).show("hide");
      setTimeout(function(){ $('#auto-' + tipo_texto ).hide("hide");},2000); 
    },
    error: function(xhr, status, error){ alert('No se pudo guardar la información de la atención de salud.'); }
  });

}

function autoguardarComentario(pers_diag_aten_sal) {

  var comentario = $('#comentario_'+pers_diag_aten_sal).val();
  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  $.ajax({
    type: 'POST',
    url: '/autoguardar_comentario',
    data: {
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: at_salud_id,      
      comentario: comentario,      
     },
    success: function(response) {                                   
      $('#comentario-'+pers_diag_aten_sal).show("hide");
      setTimeout(function(){$('#comentario-'+pers_diag_aten_sal).hide("hide");},2000) ;
      pre_comentario = comentario;
    },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente.");   }
  });

}

function autoguardarComentarioInt(pers_diag_aten_sal) {
  var int_comentario = $('#int-comment-'+pers_diag_aten_sal).val();
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { tipo: 'comentario', valor: int_comentario, pers_diag: pers_diag_aten_sal},
    success: function(response){
      $('#auto-int-'+pers_diag_aten_sal).show("hide");
      setTimeout(function(){$('#auto-int-'+pers_diag_aten_sal).hide("hide");},2000) ;
      pre_int_comentario = int_comentario;
    },
    error: function(xhr, status, error){ alert("No se guardar el comentario."); }
  });  
}

function autoguardarPrestadorDestinoTexto(pers_diag_aten_sal) {
  var pres_des_tex = $('#int-pdt-'+pers_diag_aten_sal).val();
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { tipo: 'pres_des_tex', valor: pres_des_tex, pers_diag: pers_diag_aten_sal},
    success: function(response){ },
    error: function(xhr, status, error){ alert("No se guardar el comentario."); }
  });  
}


function sinCambios(pers_diag_aten_sal){ 

  $('#modal-container-diag-'+pers_diag_aten_sal).modal('hide');
  id_mod = pers_diag_aten_sal

  $('.datepicker[name=f_i_'+id_mod+']').datepicker("setDate",pre_f_i);
  $('.datepicker[name=f_t_'+id_mod+']').datepicker("setDate",pre_f_t);
  $('#e_d_'+id_mod).find('input[name=radios-estado-'+id_mod+']').val([pre_e_d]);
  $('#enf_cro_'+id_mod).find('input[name=checkboxes]').prop('checked', pre_enf_cro);
  $('#trat_'+id_mod).find('input[name=checkboxes]').prop('checked', pre_trat);
  $('#comentario_'+id_mod).val(pre_comentario); 

  $.ajax({
    type: 'POST',
    url: '/guardar_diagnostico',
    data: {
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: atencion_salud_id,
      fecha_inicio: pre_f_i,
      fecha_termino: pre_f_t,
      estado_diagnostico: pre_e_d,
      comentario: pre_comentario,
      enf_cro: pre_enf_cro,
      trat: pre_trat,
     },
    success: function(response) { },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente.");   }
  });

}

function cerrarDiagnostico(pers_diag_aten_sal){ 
  $('#modal-container-diag-'+pers_diag_aten_sal).modal('hide');  
}
function cerrarDiagnosticoAnterior(pers_diag_aten_sal){ 
  $('#modal-container-diag-ant'+pers_diag_aten_sal).modal('hide');  
}

function agregarInfoEno(pd,value,tipo){

  $.ajax({
    type: 'POST',
    url: '/agregar_info_eno',
    data: { 
      tipo: tipo,
      valor: value,
      pers_diag: pd
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("Se produjo un error al guardar la información."); }
  });   

}

function agregarInfoPrestacion(p_p,valor,param){
  if (typeof atencion_salud_id !== 'undefined') { }
  else { atencion_salud_id = 'persona'; } 
  $.ajax({
    type: 'POST',
    url: '/agregar_info_prestacion',
    data: { param: param, valor: valor, p_p: p_p, atencion_salud_id: atencion_salud_id },
    success: function(response){  },
    error: function(xhr, status, error){ alert("Se produjo un error al guardar la información."); }
  }); 
}

function guardarPrestacion(p_p){  
  var value =  $("#prestador-prestacion-"+p_p).val();
  agregarInfoPrestacion(p_p,value,'prestador');
  var value = $('input[name=f_p_'+p_p+']').val();
  agregarInfoPrestacion(p_p,value,'fecha');
  $( "#modal-container-pres-"+p_p).modal('hide');
}

// Mensajes al profesional. código adaptado
window.createGrowl = function(persistent,message) {
  var target = $('.qtip.jgrowl:visible:last');

  $('<div/>').qtip({
      content: { text: message,  title: { text: 'Mensaje!', button: true } },
      position: { target: [0,0], container: $('#qtip-growl-container') },
      show: {
        event: false,
        ready: true,
        effect: function() { $(this).stop(0, 1).animate({ height: 'toggle' }, 400, 'swing'); },
        delay: 0,
        persistent: persistent
      },
      hide: {
        event: false,
        effect: function(api) { $(this).stop(0, 1).animate({ height: 'toggle' }, 400, 'swing'); }
      },
      style: { width: 250, classes: 'jgrowl', tip: false },
      events: {
        render: function(event, api) {
          if(!api.options.show.persistent) {
              $(this).bind('mouseover mouseout', function(e) {
                var lifespan = 5000;
                clearTimeout(api.timer);
                if (e.type !== 'mouseover') { api.timer = setTimeout(function() { api.hide(e) }, lifespan); }
              })
              .triggerHandler('mouseout');
          }
        }
      }
  });
}

function act_med_diag(med,p_d){
  var value = $('#pd_med_'+p_d+'-'+med).is(':checked');
  $.ajax({
    type: 'POST',
    url: '/actualizar_diag_med',
    data: { med: med, p_d: p_d, valor: value},
    success: function(response){ },
    error: function(xhr, status, error){ alert("Se produjo un error al guardar la información."); }
  }); 
}

function formatDate(date){

  var dd = date.getDate();
  var mm = date.getMonth()+1; //January is 0!
  var yyyy = date.getFullYear();
  if(dd<10)
    dd='0'+dd
   
  if(mm<10)
      mm='0'+mm
   
  var format_date = yyyy+'-'+mm+'-'+dd;
  return format_date
}

function guardarAntecedenteFamiliarMuerte(id,cerrar){
  var diag = $("#select_diag-afm-"+id).val(); 
  var fecha = $('#fecha-afm-'+id).val();
  var parentesco = $('#par-afm-'+id).text();
  var at_salud_id;
  var tipo = 'guardar';
  var per_ant = id;

  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  if (id == 'new'){  
    tipo = 'agregar'  
    per_ant = $("#select_afm option:selected").val();
    var texto = $("#select_afm  option:selected").text();
    var pos_final = texto.indexOf("-");
    parentesco = texto.substring(0,pos_final-1);  
  }

  if ((diag != null && per_ant !='') || tipo == 'guardar' ){
    $.ajax({
      type: 'POST',
      url: '/guardar_antecedente_familiar_muerte',
      data: { diag: diag, fecha: fecha, persona_ant: per_ant, atencion_salud_id: at_salud_id, parentesco: parentesco, tipo: tipo },
      success: function(response){ 
        if ($('#body-ant-muertes tr').length > 0 || $('#body-ant-cronicas tr').length > 0)
          $('#ant_fam').addClass('active-ant');

        if (cerrar)
          cerrarModalAntFamMue(id);
      },
      error: function(xhr, status, error){ alert("No se pudo editar el antecedente."); }
    });
  } else {
    alert('Selecciona un familiar y un diagnóstico');
  }  
}

$('#agregar-ant-fam-cro-new').click(function() {
  guardarAntecedenteFamiliarCronica('new',true);
})


function guardarAntecedenteFamiliarCronica(id,cerrar){

  var at_salud_id;
  var tipo = 'guardar';
  var per_ant;
  var diag = $('#select_diag-cro-'+id).val();
  var enf_cro = $('#check-enf-cron-'+id).is(':checked'); 
  var fecha_ini = $('#fecha-afc-ini-'+id).val();
  var fecha_fin = $('#fecha-afc-ter-'+id).val();
  var parentesco = $('#par-cro-'+id).text();
  var e_d = $('#e_d_cro-'+id).find('input[name='+id+'-radios-estado-cro]:checked').val();
  var comentario = $('#comentario_'+id+'_cro').val();

  if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';

  if (id == 'new'){ 
    tipo = 'agregar'  
    per_ant = $("#select_cro option:selected").val();
    var texto = $("#select_cro option:selected").text();
    var pos_final = texto.indexOf("-");
    parentesco = texto.substring(0,pos_final-1); 
  }
  if ((diag != null && per_ant !='') || tipo == 'guardar' ){
    $.ajax({
      type: 'POST',
      url: '/guardar_antecedente_familiar_cronica',
      data: { diag: diag, fecha_ini: fecha_ini, fecha_fin: fecha_fin, persona_ant: per_ant, atencion_salud_id: at_salud_id, parentesco: parentesco, tipo: tipo, enf_cro: enf_cro, e_d: e_d, comentario: comentario,id_pre: id },
      success: function(response){ 
        if (cerrar)
          cerrarModalAntFamCro(id);
      },
      error: function(xhr, status, error){ alert("No se pudo editar el antecedente."); }
    });
  } else {
    alert('Selecciona un familiar y un diagnóstico');
  }
}

$('#finalizar').click(function() {
  var diagnosticos = $('#diagnostico-div').children('a').length;
  if (diagnosticos == 0)
    alert('Ingresa al menos un diagnóstico.')
  else
    guardarAtencion("finalizar");
});

$('#guardar').click(function() {
  guardarAtencion("guardar");
});

function guardarAtencion(action){
    
  motivo = $('#motivo_consulta').val();
  examen = $('#examen_fisico').val();
  indicaciones = $('#indicaciones_generales').val();
  
  $.ajax({
    type: 'POST',
    url: '/guardar_atencion',
    data: { id: atencion_salud_id, finalizar: action, motivo: motivo, examen: examen, indicaciones: indicaciones },
    success: function(response) { window.location = '/' },
    error: function(xhr, status, error) { alert('No se pudo guardar la atención de salud.'); }
  });

}

$('input[type=radio][name^=tipo_reposo]').change(function() {
  var cert = $(this).attr('name').substring(11);
  var value = $('input[name=tipo_reposo'+cert+']:checked').val();
  agregarInfoCertificado('tipo_reposo',value,cert);  
});

$('.dias-rep').keyup( function(e) {
  var cert = $(this).attr('id').substring(11);
  var value =$('#dias_reposo'+cert).val();
  agregarInfoCertificado('dias_reposo',value,cert);  
})

$('input[id^=alta]').on("dp.change", function(e) {
    var cert = $(this).attr('id').substring(4);
    var value =$('#alta'+cert).val();
    agregarInfoCertificado('alta',value,cert);
});

$('input[id^=control]').on("dp.change", function(e) {
  var cert = $(this).attr('id').substring(7);
  var value =$('#control'+cert).val();
  agregarInfoCertificado('control',value,cert);
});

$('input[type=checkbox][name^=cert_prop]').change(function() {
  var cert = $(this).attr('name').substring(9);
  var value = $(this).is(':checked');
  agregarInfoCertificado($(this).attr('id'),value,cert);  
});

function agregarInfoCertificado(param,value,certificado){
  $.ajax({
    type: 'POST',
    url: '/agregar_info_certificado',
    data: { 
      param: param,
      valor: value,
      cert: certificado
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("No se pudo guardar la información del certificado."); }
  });
}

function act_cert_diag(p_d,cert){
  var value = $('#pd_cert_'+p_d+'-'+cert).is(':checked');
  $.ajax({
    type: 'POST',
    url: '/actualizar_diag_certificado',
    data: { p_d: p_d, cert: cert, valor: value},
    success: function(response){ },
    error: function(xhr, status, error){ alert("No se pudo guardar la información del certificado."); }
  }); 
}

function act_pres_diag(p_d,p_p){
  var value = $('#pd_pres_'+p_d+'-'+p_p).is(':checked');
  $.ajax({
    type: 'POST',
    url: '/actualizar_diag_prestacion',
    data: { p_d: p_d, p_p: p_p, valor: value},
    success: function(response){ },
    error: function(xhr, status, error){ alert("No se pudo guardar la información de la prestación."); }
  }); 
}

function act_pres_int(p_p,p_d){
  var value = $('#pr-in-'+p_p+'-'+p_d).is(':checked');
  $.ajax({
    type: 'POST',
    url: '/actualizar_diag_prestacion_int',
    data: { p_d: p_d, p_p: p_p, valor: value},
    success: function(response){ },
    error: function(xhr, status, error){ alert("No se pudo guardar la información de la interconsulta"); }
  }); 
}

function isNumeric(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function actualizarFechaAlta(certificado_id){
  var dias_reposo = $('#dias_reposo'+certificado_id).val();
  var fecha_control = $('#control'+certificado_id).val();
  var d = new moment(fecha_control);
  d.add(dias_reposo,"days");
  if (dias_reposo != '' && fecha_control != '')
     $('#alta'+certificado_id).data("DateTimePicker").date(d); 
}