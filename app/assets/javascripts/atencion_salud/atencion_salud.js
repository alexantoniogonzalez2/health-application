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
    success: function(response) {
      if (response.success){}
    },
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
    success: function(response) {
      if (response.success){}
    },
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
    success: function(response) {

      if (response.success){  }
    },
    error: function(xhr, status, error){ alert("No se pudo agregar el medicamento del paciente."); }
  });  

})

function diagnosticoNoFrecuente(){

  var value = $("#diag-no-frec").is(':checked');  
  return value;

}

function agregarDiagnostico(value){
 
 $.ajax({
    type: 'POST',
    url: '/agregar_diagnostico',
    data: {
      persona_id: persona_id,
      diagnostico_id: value,
      atencion_salud_id: atencion_salud_id,
    },
    success: function(response) {  },
    error: function(xhr, status, error){ alert("No se pudo agregar el diagnóstico del paciente."); }
  });

}

function eliminarDiagnostico(pers_diag) {
  var div = document.getElementById("modal-container-diag-"+pers_diag);
  div.parentNode.removeChild(div);

  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { 
      persona_diagnostico_id: pers_diag,
      atencion_salud_id: atencion_salud_id
    },

    success: function(response) { $( "#pd"+pers_diag).remove();$( "#bc"+pers_diag).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el diagnóstico del paciente.");   }
  });
   
}

function eliminarMedicamento(pers_med) {
  var div = document.getElementById("modal-container-med-"+pers_med);
  div.parentNode.removeChild(div);

  $.ajax({
    type: 'POST',
    url: '/eliminar_medicamento',
    data: { persona_medicamento_id: pers_med},

    success: function(response) { $( "#pm"+pers_med).remove();$( "#bpm"+pers_med).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el medicamento del paciente.");   }
  });
   
}

function actualizarDiagnostico(diag){

  agregarDiagnostico(diag);
}

function guardarDiagnostico(pers_diag) {

  var f_i = $('.datepicker[name=f_i_'+pers_diag+']').datepicker("getDate");
  var f_t = $('.datepicker[name=f_t_'+pers_diag+']').datepicker("getDate");
  var e_d = $('#e_d_'+pers_diag).val();
  var comentario = $('#comentario_'+pers_diag).val();

  $.ajax({
    type: 'POST',
    url: '/guardar_diagnostico',
    data: {
      persona_diagnostico_id: pers_diag,
      fecha_inicio: f_i,
      fecha_termino: f_t,
      estado_diagnostico: e_d,
      comentario: comentario,
     },
    success: function(response) { $( "#modal-container-diag-"+pers_diag).modal('hide'); },
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
    data: { persona_prestacion_id: pers_pre },

    success: function(response) { $( "#pp"+pers_pre).remove();$( "#bcp"+pers_pre).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el examen o procedimiento del paciente.");   }
  });
   
}

function calcularTotalMedicamentos(pers_med) {
  var cantidad = $( "#cantidad-"+pers_med).val();
  var periodicidad = $( "#periodicidad-"+pers_med).val();
  var duracion = $( "#duracion-"+pers_med).val();  
  var total = cantidad*periodicidad*duracion;
 
  $( "#total-"+pers_med).val(total);
}

function calcularIMC(pers_aten) {

  var peso = $( "#peso-"+pers_aten).val();
  var estatura = $( "#estatura-"+pers_aten).val()/100;
  var imc = peso/(estatura*estatura);

  $( "#imc-"+pers_aten).val(imc);
  
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