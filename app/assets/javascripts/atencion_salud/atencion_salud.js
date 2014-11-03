$('#icon-eno').qtip({ content: { text: 'Fecha de primeros síntomas o de primera consulta.'  } })
$('#icon-ges').qtip({ content: { text: 'Parentesco o relación con el paciente.'  } })

$('.ges-cancelar').click(function() {
  var pd = $(this).attr('id').substring(13);
  $("#per_not_"+pd).collapse('hide');
});

$('.int-cancelar').click(function() {
  var pd = $(this).attr('id').substring(13);
  $("#per_int_"+pd).collapse('hide');
});

$('.ges-agregar').click(function() {
  var pd = $(this).attr('id').substring(12);
  if (validarNuevaPersona(pd) ){
    var nombre = $('#ges_nom_'+pd).val();
    var apep = $('#ges_apep_'+pd).val();
    var apem = $('#ges_apem_'+pd).val();
    var parent = $('#select_parent_'+pd).val();
    var rut = $('#ges_prut_'+pd).val();
    var dv = $('#ges_pdv_'+pd).val();
    var correo = $('#ges_pcorreo_'+pd).val();
    var celular = $('#ges_pcelular_'+pd).val();

    $.ajax({
      type: 'POST',
      url: '/agregar_persona_notificacion_pre',
      data: { 
        pers_diag: pd,
        nombre: nombre,
        apep: apep,
        apem: apem,
        parent: parent,
        rut: rut,
        dv: dv,
        correo: correo,
        celular: celular
      },
      success: function(response){
        $("#per_not_"+pd).collapse('hide');
        $('#ges_nombre_'+pd).val(nombre+' '+apep+' '+apem);
        $('#ges_rut_'+pd).val(response.rut);
        $('#ges_correo_'+pd).val(correo);
        $('#ges_celular_'+pd).val(celular);
        $('#select_persona_'+pd).select2('val', '');
      },
      error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
    }); 

  }
});

$('.int-agregar').click(function() {
  var pd = $(this).attr('id').substring(12);
  if (validarNuevaPersona(pd) ){
    var nombre = $('#int_nom_'+pd).val();
    var apep = $('#int_apep_'+pd).val();
    var apem = $('#ges_apem_'+pd).val();
    var parent = $('#select_parent_int_'+pd).val();
    var rut = $('#int_prut_'+pd).val();
    var dv = $('#int_pdv_'+pd).val();
    var correo = $('#int_pcorreo_'+pd).val();
    var celular = $('#int_pcelular_'+pd).val();

    $.ajax({
      type: 'POST',
      url: '/agregar_persona_interconsulta_pre',
      data: { 
        pers_diag: pd,
        nombre: nombre,
        apep: apep,
        apem: apem,
        parent: parent,
        rut: rut,
        dv: dv,
        correo: correo,
        celular: celular
      },
      success: function(response){
        $("#per_int_"+pd).collapse('hide');
        $('#int_nombre_'+pd).val(nombre+' '+apep+' '+apem);
        $('#int_rut_'+pd).val(response.rut);
        $('#int_correo_'+pd).val(correo);
        $('#int_celular_'+pd).val(celular);
        $('#select_persona_int'+pd).select2('val', '');
      },
      error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
    }); 

  }
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
  var e_d = $('input[name=radios-'+pers_diag+']:checked').val();
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
    error: function(xhr, status, error){ alert("No se pudo agregar el prestador."); }
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
  pre_e_d = $('#e_d_'+id_mod).find('input[name=radios-'+id_mod+']:checked').val();
  pre_enf_cro = $('#enf_cro_'+id_mod).find('input[name=checkboxes]').is(':checked');
  pre_trat = $('#trat_'+id_mod).find('input[name=checkboxes]').is(':checked');
  pre_comentario = $('#comentario_'+id_mod).val();
})


$('#atencion_salud_motivo_consulta').keyup( function(e) {
  if (typeof contador_mot === 'undefined') { } 
  else { clearTimeout(contador_mot);}
  contador_mot = setTimeout(function(){ guardarTexto('motivo') },2000);
})

$('#atencion_salud_examen_fisico').keyup( function(e) { 
  if (typeof contador_exa === 'undefined') { } 
  else { clearTimeout(contador_exa);}
  contador_exa = setTimeout(function(){ guardarTexto('examen') },2000);
})

$('#atencion_salud_indicaciones_generales').keyup( function(e) { 
  if (typeof contador_ind === 'undefined') { } 
  else { clearTimeout(contador_ind);}
  contador_ind = setTimeout(function(){ guardarTexto('indicaciones') },2000);
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

$('select.select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
$('select.select_prestadores').select2({ width: '80%', placeholder: 'Seleccione un establecimiento', allowClear: true });
$('select.select-conf-diag').select2({ width: '80%', placeholder: 'Seleccione un tipo de diagnóstico', allowClear: true });
$('select.select-pais-contagio').select2({ width: '80%', placeholder: 'Seleccione un país de contagio', allowClear: true });
$('select.select-confirmacion').select2({ width: '80%', placeholder: 'Seleccione una opción', allowClear: true });

$('#select_diagnostico').select2({
  width: '80%',
  minimumInputLength: 3,
  placeholder: "Seleccione un diagnóstico",
  ajax: {
    url: '/cargar_diagnosticos',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) {
      return { q: term, diag_no_frec: diagnosticoNoFrecuente };
    },
    results: function (data, page) { return { results: data }; }
  }
});

$('.select_persona').select2({
  width: '80%',
  minimumInputLength: 3,
  placeholder: "Seleccione una persona",
  allowClear: true,
  ajax: {
    url: '/cargar_personas',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term }; },
    results: function (data, page) { return { results: data };}
  }
});

$('.select_persona_int').select2({
  width: '80%',
  minimumInputLength: 3,
  placeholder: "Seleccione una persona",
  allowClear: true,
  ajax: {
    url: '/cargar_personas',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term }; },
    results: function (data, page) { return { results: data }; }
  }
});

$('#select_examen').select2({
  width: '82%',
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
  width: '61%',
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
  width: '75%',
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

$(".select_persona").on("change", function(e) { 

  var pd = $(this).attr('id').substring(15);   
  value = $("#select_persona_"+pd).select2('data') != null ? $("#select_persona_"+pd).select2('data').id : null;       
  $("#ges_div_"+pd).hide(); 
  $("#per_not_"+pd).is(":visible") ? $("#per_not_"+pd).collapse('hide') : /*nothing to do */true ;
  $("#row_nombre_"+pd+","+"#row_rut_"+pd+","+"#row_correo_"+pd+","+"#row_celular_"+pd).show();
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).prop('disabled', true);    

  $.ajax({
    type: 'POST',
    url: '/agregar_persona_notificacion',
    data: { 
      persona_id: value,
      pers_diag: pd
    },
    success: function(response){
      $("#ges_nombre_"+pd).val( response.nombre );
      $("#ges_rut_"+pd).val( response.rut );
      $("#ges_correo_"+pd).val( response.correo );
      $("#ges_celular_"+pd).val( response.celular ); 
    },
    error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
  });    
  
})

$(".select_persona_int").on("change", function(e) { 

  var pd = $(this).attr('id').substring(18);   
  value = $("#select_persona_int"+pd).select2('data') != null ? $("#select_persona_int"+pd).select2('data').id : null;       
  $("#int_div_"+pd).hide(); 
  $("#per_int_"+pd).is(":visible") ? $("#per_int_"+pd).collapse('hide') : //nothing to do  ;
  $("#row_int_nombre_"+pd+","+"#row_int_rut_"+pd+","+"#row_int_correo_"+pd+","+"#row_int_celular_"+pd).show();
  $("#int_nombre_"+pd+","+"#int_rut_"+pd+","+"#int_correo_"+pd+","+"#int_celular_"+pd).prop('disabled', true);    
  
  $.ajax({
    type: 'POST',
    url: '/agregar_info_interconsulta',
    data: { 
      tipo: 'persona',
      valor: value,
      pers_diag: pd,
    },
    success: function(response){
      $("#int_nombre_"+pd).val( response.nombre );
      $("#int_rut_"+pd).val( response.rut );
      $("#int_correo_"+pd).val( response.correo );
      $("#int_celular_"+pd).val( response.celular ); 
    },
    error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
  });    
  
})

$(".select_prestadores").on("change", function(e) { 
  var pd = $(this).attr('id').substring(18);   
  value = $("#select_prestadores"+pd).select2('data') != null ? $("#select_prestadores"+pd).select2('data').id : null;    
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
  var pd = $(this).attr('id').substring(19);   
  value = $("#select_especialidad"+pd).select2('data') != null ? $("#select_especialidad"+pd).select2('data').id : null;    
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
    success: function(response) {$("#select_procedimiento").select2("val", ""); },
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

function diagnosticoNoFrecuente(){
  var check_no_frec = $("#diag-no-frec").is(':checked');  
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
  var div = document.getElementById("modal-container-diag-"+pers_diag_aten_sal);

  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { 
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: atencion_salud_id
    },

    success: function(response) { $("#modal-container-diag-"+pers_diag_aten_sal).modal('hide'); $("#pd"+pers_diag_aten_sal).remove();  },
    error: function(xhr, status, error){ alert("No se pudo eliminar el diagnóstico del paciente.");   }
  });
   
}

function eliminarMedicamento(pers_med) {
  var div = document.getElementById("modal-container-med-"+pers_med);

  $.ajax({
    type: 'POST',
    url: '/eliminar_medicamento',
    data: { persona_medicamento_id: pers_med},

    success: function(response) { $("#modal-container-med-"+pers_med).modal('hide'); $("#pm"+pers_med).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el medicamento del paciente.");   }
  });
   
}

function actualizarDiagnostico(diag,pers_diag){

  $( "#modal-container-diag-ant"+pers_diag).modal('hide');
  agregarDiagnostico(diag);
  $( "#modal-container-diag-"+pers_diag).modal('show');
}

function guardarDiagnostico(pers_diag_aten_sal) {

  var f_i = $('.datepicker[name=f_i_'+pers_diag_aten_sal+']').datepicker("getDate");
  var f_t = $('.datepicker[name=f_t_'+pers_diag_aten_sal+']').datepicker("getDate");
  var e_d = $('#e_d_'+pers_diag_aten_sal).find('input[name=radios-'+pers_diag_aten_sal+']:checked').val();
  var enf_cro = $('#enf_cro_'+pers_diag_aten_sal).find('input[name=checkboxes]').is(':checked');
  var trat = $('#trat_'+pers_diag_aten_sal).find('input[name=checkboxes]').is(':checked');
  var comentario = $('#comentario_'+pers_diag_aten_sal).val();

  $('.datepicker[name=f_s_'+pers_diag_aten_sal+']').datepicker("setDate",f_i);
  $.ajax({
    type: 'POST',
    url: '/guardar_diagnostico',
    data: {
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: atencion_salud_id,
      fecha_inicio: f_i,
      fecha_termino: f_t,
      estado_diagnostico: e_d,
      comentario: comentario,
      enf_cro: enf_cro,
      trat: trat
     },
    success: function(response) {  },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente."); }
  });

}

function guardarMedicamento(pers_med) {

  $.ajax({
    type: 'POST',
    url: '/guardar_medicamento',
    data: {
      persona_medicamento_id: pers_med,
      cantidad: $( "#cantidad-"+pers_med).val(),
      periodicidad: $( "#periodicidad-"+pers_med).val(),
      duracion: $( "#duracion-"+pers_med).val(),  
      total: $( "#total-"+pers_med).val(),      
    },
    success: function(response) { $( "#modal-container-med-"+pers_med).modal('hide'); },
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
    success: function(response) { $("#modal-container-pres-"+pers_pre).modal('hide'); $("#pp"+pers_pre).remove();},
    error: function(xhr, status, error){ alert("No se pudo eliminar el examen o procedimiento del paciente."); }
  });
   
}

function calcularTotalMedicamentos(pers_med) {
  var cantidad = $( "#cantidad-"+pers_med).val();
  var periodicidad = $( "#periodicidad-"+pers_med).val();
  var duracion = $( "#duracion-"+pers_med).val();  
  var total = cantidad*(24/periodicidad)*duracion; 
  if (cantidad != "" && periodicidad != ""){
    $("#total-"+pers_med).val(total);
    $("#total-ml-"+pers_med).val(total/20);
  } else {
    $("#total-"+pers_med).val('');
    $("#total-ml-"+pers_med).val('');
  }
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

function guardarTexto(tipo_texto) {
  switch (tipo_texto) {
    case 'motivo':      
      texto = $('#atencion_salud_motivo_consulta').val();
      break;     
    case 'examen':
      texto = $('#atencion_salud_examen_fisico').val();
      break;  
    case 'indicaciones':
      texto = $('#atencion_salud_indicaciones_generales').val();
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

  $.ajax({
    type: 'POST',
    url: '/autoguardar_comentario',
    data: {
      persona_diagnostico_atencion_salud_id: pers_diag_aten_sal,
      atencion_salud_id: atencion_salud_id,      
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
    data: { 
      tipo: 'comentario',
      valor: int_comentario,
      pers_diag: pers_diag_aten_sal,
    },
    success: function(response){
      $('#auto-int-'+pers_diag_aten_sal).show("hide");
      setTimeout(function(){$('#auto-int-'+pers_diag_aten_sal).hide("hide");},2000) ;
      pre_int_comentario = int_comentario;
    },
    error: function(xhr, status, error){ alert("No se guardar el comentario."); }
  });    
  

}

function cerrarDiagnostico(pers_diag_aten_sal){ 

  $('#modal-container-diag-'+pers_diag_aten_sal).modal('hide');
  id_mod = pers_diag_aten_sal

  $('.datepicker[name=f_i_'+id_mod+']').datepicker("setDate",pre_f_i);
  $('.datepicker[name=f_t_'+id_mod+']').datepicker("setDate",pre_f_t);
  $('#e_d_'+id_mod).find('input[name=radios-'+id_mod+']').val([pre_e_d]);
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

function validarNuevaPersona(pd){
  return true;
}

function agregarInfoEno(pd,value,tipo){

  $.ajax({
    type: 'POST',
    url: '/agregar_info_eno',
    data: { 
      tipo: tipo,
      valor: value,
      pers_diag: pd,
    },
    success: function(response){  },
    error: function(xhr, status, error){ alert("Se produjo un error al guardar la información."); }
  });   

}

function agregarInfoPrestacion(p_p,valor,param){
  $.ajax({
    type: 'POST',
    url: '/agregar_info_prestacion',
    data: { param: param, valor: valor, p_p: p_p },
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