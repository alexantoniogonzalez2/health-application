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

$('input[type=radio][name^=radios-estado-]').change(function() {
  var pers_diag = $(this).attr('name').substring(14);  
  var e_d = $('input[name=radios-estado-'+pers_diag+']:checked').val();
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

  guardarDiagnostico(pers_diag);

});

$('input[type=radio][name^=radios-int-]').change(function() {
  var pers_diag = $(this).attr('name').substring(11);
  var value = $('input[name=radios-int-'+pers_diag+']:checked').val();
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
});

$('input[type=checkbox][id^=checkboxes-trat-]').change(function() {
  var pers_diag = $(this).attr('id').substring(16);
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  
  estado_trat = (trat == 1) ? 2 : 1;
  $('input[name=radios-ges-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  $('input[name=radios-int-'+pers_diag+'][value=' + estado_trat + ']').prop('checked', true);
  guardarDiagnostico(pers_diag);

});

$('input[type=checkbox][id^=checkboxes-cron-]').change(function() {
  var pers_diag = $(this).attr('id').substring(16);
  guardarDiagnostico(pers_diag);
});

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

$('.comentario').keyup( function(e) { 
  if (typeof contador_com === 'undefined') { } 
  else { clearTimeout(contador_com);}
  id = this.id; 
  contador_com = setTimeout(function(){ autoguardarComentario(id.substring(11)) },500);
})

$('.int-comment').keyup( function(e) { 
  if (typeof contador_int_com === 'undefined') { } 
  else { clearTimeout(contador_int_com);}
  id = this.id.substring(12);
  contador_int_com = setTimeout(function(){ autoguardarComentarioInt(id) },2000);
})

$('.auto-int-pdt').keyup( function(e) { 
  if (typeof contador_int_pdt === 'undefined') { } 
  else { clearTimeout(contador_int_pdt);}
  id = this.id.substring(8);
  contador_int_pdt = setTimeout(function(){ autoguardarPrestadorDestinoTexto(id) },2000);
})

$('select.select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
$('select.select_prestadores').select2({ width: '80%', placeholder: 'Seleccione un establecimiento', allowClear: true });
$('select.select-conf-diag').select2({ width: '80%', placeholder: 'Seleccione un tipo de diagnóstico', allowClear: true });
$('select.select-pais-contagio').select2({ width: '80%', placeholder: 'Seleccione un país de contagio', allowClear: true });
$('select.select-confirmacion').select2({ width: '80%', placeholder: 'Seleccione una opción', allowClear: true });

$('#select_diagnostico').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Seleccione un diagnóstico",

  ajax: {
    url: '/cargar_diagnosticos',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) {
      return { q: term, diag_no_frec: diagnosticoNoFrecuente('#diag-no-frec') };
    },
    results: function (data, page) { return { results: data }; }
  }
});

$('.select_diag').select2({
  allowClear: true,
  width: '380px',
  minimumInputLength: 3,
  ajax: {
    url: '/cargar_diagnosticos',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) {
      return { q: term, diag_no_frec: diagnosticoNoFrecuente('#diag-no-frec-' + $(this).attr('id').substring(12)) };
    },
    results: function (data, page) { return { results: data }; }
  }
});

$('#select_examen').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Seleccione un examen",
  ajax: {
    url: '/cargar_prestaciones',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term, tipo: 'examen' }; },
    results: function (data, page) { return { results: data }; }
  }
});

$('#select_procedimiento').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Seleccione un procedimiento",
  ajax: {
    url: '/cargar_prestaciones',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term, tipo: 'procedimiento'}; },
    results: function (data, page) { return { results: data }; }
  }
});

$('#select_medicamento').select2({
  width: '380px',
  minimumInputLength: 3,
  placeholder: "Seleccione un medicamento",
  ajax: {
    url: '/cargar_medicamentos',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term }; },
    results: function (data, page) { return { results: data }; }
  }
});

$("#select_diagnostico").on("change", function(e) { 
  var value = $("#select_diagnostico").select2('data').id; 
  agregarDiagnostico(value);
})

$('.select_diag').on("change", function(e) { 
  var id = $(this).attr('id').substring(16);
  var tipo = $(this).attr('id').substring(12,15);
  if (id != 'new' && tipo != 'cro') 
    guardarAntecedenteFamiliarMuerte(id,false);  
})

$('.cambiar_antecedente').click(function() {
  var id = $(this).attr('id').substring(20); 
  guardarAntecedenteFamiliarMuerte(id,true);  
});

$('.cambiar_antecedente_cro').click(function() {
  var id = $(this).attr('id').substring(20); 
  guardarAntecedenteFamiliarCronica(id,true);  
});

$(".select_notificacion").on("change", function(e) { 

  var pd = $(this).attr('id').substring(11);   
  var value = $(this).val() != null ? $(this).val() : null;        
  $.ajax({
    type: 'POST',
    url: '/agregar_persona_notificacion',
    data: { 
      persona_id: value,
      pers_diag: pd
    },
    success: function(response){
      $("#not_nombre_"+pd).html( response.nombre );
      $("#not_rut_"+pd).html( response.rut );
      $("#not_correo_"+pd).html( response.correo );
      $("#not_celular_"+pd).html( response.celular );
      $("#not_telefono_"+pd).html( response.telefono ); 
    },
    error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
  });    
  
})

$(".select-relacion").on("change", function(e) { 

  var id = $(this).attr('id').substring(15);   
  value = $(this).val();
  (value == '5') ? $("#otro-div"+id).show() : $("#otro-div"+id).hide();    
  
})

$(".select_interconsulta").on("change", function(e) { 

  var pd = $(this).attr('id').substring(11);
  value = $(this).val() != null ? $(this).val() : null;       
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'persona',
      valor: value,
      pers_diag: pd,
    },
    success: function(response){
      $("#int_nombre_"+pd).html( response.nombre );
      $("#int_rut_"+pd).html( response.rut );
      $("#int_correo_"+pd).html( response.correo );
      $("#int_celular_"+pd).html( response.celular ); 
      $("#int_telefono_"+pd).html( response.telefono ); 
    },
    error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
  });    
  
})

$(".select_prestadores").on("change", function(e) { 
  var pd = $(this).attr('id').substring(22);   
  value = $("#select_prestadores_int"+pd).select2('data') != null ? $("#select_prestadores_int"+pd).select2('data').id : null;    
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

$(".select_especialidad").on("change", function(e) { 
  var pd = $(this).attr('id').substring(23);   
  value = $("#select_especialidad_int"+pd).select2('data') != null ? $("#select_especialidad_int"+pd).select2('data').id : null;    
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'especialidad',
      valor: value,
      pers_diag: pd,
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("No se pudo agregar la especialidad."); }
  });   
})

$("#select_examen").on("change", function(e) { 

  var value = $("#select_examen").select2('data').id;
  
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

})

$("#select_procedimiento").on("change", function(e) { 

  var value = $("#select_procedimiento").select2('data').id;
  var text = $("#select_procedimiento").select2('data').text;
  
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

})

$("#select_medicamento").on("change", function(e) { 

  var value = $("#select_medicamento").select2('data').id;
  var text = $("#select_medicamento").select2('data').text;
  
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

})

$(".select-pais-contagio").on("change", function(e) {
  var pd = $(this).attr('id').substring(20); 
  var value = $("#select-pais-contagio"+pd).select2('data').id;
  agregarInfoEno(pd,value,'pais');
})

$(".select-confirmacion").on("change", function(e) {
  var pd = $(this).attr('id').substring(19); 
  var value = $("#select-confirmacion"+pd).select2('data').id;
  agregarInfoEno(pd,value,'confirmacion');
})

$('input[type=radio][name^=radios-ant]').change(function() {
  var pd = $(this).attr('name').substring(10);
  var value = $('input[name=radios-ant'+pd+']:checked').val();
  agregarInfoEno(pd,value,'vacunacion');
});

$('input[type=radio][name^=radios-emb]').change(function() {
  var pd = $(this).attr('name').substring(10);
  var value = $('input[name=radios-emb'+pd+']:checked').val();
  agregarInfoEno(pd,value,'embarazo');
});

$('input[type=radio][name^=radios-tbc]').change(function() {
  var pd = $(this).attr('name').substring(10);
  var value = $('input[name=radios-tbc'+pd+']:checked').val();
  agregarInfoEno(pd,value,'tbc');
});

$('.sem-ges').keyup( function(e) {
  var pd = $(this).attr('id').substring(8);
  var value =$('#semanas-'+pd).val();
  agregarInfoEno(pd,value,'sem_emb'); 
})

$("#alergias").submit(function (e) { return false; });

$('input[id^=fecha]').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

$('input[id^=fecha-afm]').on("dp.change", function (e) {
  var id = $(this).attr('id').substring(10);
  if ( id != 'new') 
    guardarAntecedenteFamiliarMuerte(id,false);
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

function guardarDiagnostico(pers_diag_aten_sal) {

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
    success: function(response) { },
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
  $("#imc-" + pers_aten).val(imc);  
}

function guardarMetricas(pers_aten) {
  $.ajax({
    type: 'POST',
    url: '/guardar_metricas',
    data: {
      atencion_salud_id: pers_aten,
      persona_id: persona_id,
      peso: $( "#peso-"+pers_aten).val(),
      estatura: $( "#estatura-"+pers_aten).val(),
      imc: $( "#imc-"+pers_aten).val(),  
      presion: $( "#presion-"+pers_aten).val(),      
    },
    success: function(response) { $( "#modal-container-metricas").modal('hide'); },
    error: function(xhr, status, error){ alert("No se pudo guardar las métricas del paciente.");   }
  });
}

function guardarSignos(pers_aten) {
  $.ajax({
    type: 'POST',
    url: '/guardar_signos',
    data: {
      atencion_salud_id: pers_aten,
      persona_id: persona_id,
      frec_car: $( "#frec_car-"+pers_aten).val(),
      frec_res: $( "#frec_res-"+pers_aten).val(),
      temp: $( "#temp-"+pers_aten).val(),  
      presion: $( "#presion-"+pers_aten).val(),  
      sat: $( "#sat-"+pers_aten).val(),
      car_frec_car: $( "#car_frec_car-"+pers_aten).val(),
      car_frec_res: $( "#car_frec_res-"+pers_aten).val(),
      car_temp: $( "#car_temp-"+pers_aten).val(),  
      car_presion: $( "#car_presion-"+pers_aten).val(),  
      car_sat: $( "#car_sat-"+pers_aten).val(),      
    },
    success: function(response) { $( "#modal-container-signos").modal('hide'); },
    error: function(xhr, status, error){ alert("No se pudo guardar los signos vitales del paciente.");   }
  });
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
      setTimeout(function(){ $('#auto-' + tipo_texto ).hide("hide");},2000) 
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
    success: function(response){
      // $('#auto-int-'+pers_diag_aten_sal).show("hide");
      //setTimeout(function(){$('#auto-int-'+pers_diag_aten_sal).hide("hide");},2000) ;
      //pre_descomentario = pres_des_tex;
    },
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
  var value = $("#select_prestadores"+p_p).select2('data') != null ? $("#select_prestadores"+p_p).select2('data').id : null; 
  agregarInfoPrestacion(p_p,value,'prestador');
  var value = $('.datepicker[name=f_p_'+p_p+']').datepicker("getDate");
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

function act_med_diag(med){
  var diag = $('input[name=rad-med-'+med+']:checked').val();
  $.ajax({
    type: 'POST',
    url: '/actualizar_diag_med',
    data: { med: med, diag: diag},
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
  var diag = $("#select_diag-afm-"+id).select2('data') != null ? $("#select_diag-afm-"+id).select2('data').id : null; 
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
}

$('#agregar-ant-fam-cro-new').click(function() {
  guardarAntecedenteFamiliarCronica('new',true);
})


function guardarAntecedenteFamiliarCronica(id,cerrar){

  var at_salud_id;
  var tipo = 'guardar';
  var per_ant;
  var diag = $('#select_diag-cro-'+id).select2('data') != null ? $('#select_diag-cro-'+id).select2('data').id : null;
  var enf_cro = $('#check-enf-cron-'+id).is(':checked'); 
  var fecha_ini = $('#cro-fin-'+id).val();
  var fecha_fin = $('#cro-ini-'+id).val();
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
  if (diag != null && per_ant !=''){
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
    alert('Seleccione un familiar y un diagnóstico');
  }
}

$('#finalizar').click(function() {
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