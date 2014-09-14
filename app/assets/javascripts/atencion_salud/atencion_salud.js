$('#icon-eno').qtip({ content: { text: 'Fecha de primeros síntomas o de primera consulta.'  } })

$('.ges-cancelar').click(function() {
  var pd = $(this).attr('id').substring(13);
  $("#per_not_"+pd).collapse('hide');
});

$('.panel-ges').on('shown.bs.collapse', function() { 

  var pd = $(this).attr('id').substring(8);
  $("#row_nombre_"+pd).hide();
  $("#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).prop('disabled', false);
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).val('');  
  $("#ges_div_"+pd).css( "display", "block !important");
  $("#ges_div_"+pd).show();

});

$('.panel-ges').on('hidden.bs.collapse', function() { 
  var pd = $(this).attr('id').substring(8);
  $("#ges_div_"+pd).hide();
  $("#row_nombre_"+pd).show();
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).val('');
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).prop('disabled', true);

});

$('input[type=radio][name^=radios-]').change(function() {
  var pers_diag = $(this).attr('name').substring(7);  
  var e_d = $('input[name=radios-'+pers_diag+']:checked').val();
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  (e_d == 1) ? $( '#checkboxes-trat-div-'+pers_diag).show() : $( '#checkboxes-trat-div-'+pers_diag).hide();
  
  if(e_d == 1) { 
    estado_ges = (trat == 1) ? 2 : 1; 
    $('input[name=radios-ges-'+pers_diag+'][value=' + estado_ges + ']').prop('checked', true);
  }
  else { $('input[name=radios-ges-'+pers_diag+']').prop('checked', false); }

  guardarDiagnostico(pers_diag);

});

$('input[type=checkbox][id^=checkboxes-trat-]').change(function() {
  var pers_diag = $(this).attr('id').substring(16);
  trat = $('#trat_'+pers_diag).find('input[name=checkboxes]').is(':checked');
  
  estado_ges = (trat == 1) ? 2 : 1;
    $('input[name=radios-ges-'+pers_diag+'][value=' + estado_ges + ']').prop('checked', true);
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

$('#select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad' });
$('#select_prestadores').select2({ width: '80%', placeholder: 'Seleccione un establecimiento' });
$('#select-conf-diag').select2({ width: '80%', placeholder: 'Seleccione un tipo de diagnóstico' });
$('#select-pais-contagio').select2({ width: '80%', placeholder: 'Seleccione un país de contagio' });

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
    results: function (data, page) {
      return { results: data };
    }
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
    data: function (term, page) {
      return { q: term };
    },
    results: function (data, page) {
      return { results: data };
    }
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
    data: function (term, page) {
      return { q: term, tipo: 'examen' };
    },
    results: function (data, page) {
      return { results: data };
    }
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
    data: function (term, page) {
      return { q: term, tipo: 'procedimiento'};
    },
    results: function (data, page) {
      return { results: data };
    }
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
    data: function (term, page) {
      return { q: term };
    },
    results: function (data, page) {
      return { results: data };
    }
  }
});

$("#select_diagnostico").on("change", function(e) { 

  var value = $("#select_diagnostico").select2('data').id;
 
  agregarDiagnostico(value);

})

$(".select_persona").on("change", function(e) { 

  var pd = $(this).attr('id').substring(15); 
  $("#ges_div_"+pd).hide();
  $("#per_not_"+pd).collapse('hide');
  $("#row_nombre_"+pd).show();
  value = $("#select_persona_"+pd).select2('data') != null ? $("#select_persona_"+pd).select2('data').id : null;
  $("#ges_nombre_"+pd+","+"#ges_rut_"+pd+","+"#ges_correo_"+pd+","+"#ges_celular_"+pd).prop('disabled', true)

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
    success: function(response) { /*$( "#modal-container-diag-"+pers_diag_aten_sal).modal('hide');*/ },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente.");   }
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
  var total = cantidad*periodicidad*duracion;
 
  $("#total-"+pers_med).val(total);
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

function cerrarDiagnostico(pers_diag_aten_sal){ 

  $('#modal-container-diag-'+pers_diag_aten_sal).modal('hide');
  id_mod = pers_diag_aten_sal

  $('.datepicker[name=f_i_'+id_mod+']').datepicker("setDate",pre_f_i);
  $('.datepicker[name=f_t_'+id_mod+']').datepicker("setDate",pre_f_t);
  $('#e_d_'+id_mod).find('input[name=radios-'+id_mod+']').val([pre_e_d]);
  $('#enf_cro_'+id_mod).find('input[name=checkboxes]').prop('checked', pre_enf_cro);
  $('#trat_'+id_mod).find('input[name=checkboxes]').prop('checked', pre_trat);
  $('#comentario_'+id_mod).val(pre_comentario);

  /*var estado = (pre_e_d == 1) ? true : false;  
  $('#checkboxes-conf-'+pers_diag_aten_sal).prop('checked', estado);*/

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
    success: function(response) { /*$( "#modal-container-diag-"+pers_diag_aten_sal).modal('hide'); */},
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente.");   }
  });

}