$("#select_diagnostico").chosen({
  no_results_text: 'No hubo coincidencias.',
  allow_single_deselect: false,
  width: "300px" 
}); 



$(document).ready(function(){

  cargarCalendario();

  $('#select_diag_no_frec').select2({
    width: '100%',
    minimumInputLength: 3,
    ajax: {
      url: '/cargar_no_frecuentes',
      dataType: 'json',
      type: 'POST',
      data: function (term, page) {
        return {
          q: term
        };
      },
      results: function (data, page) {
        return { results: data };
      }
    }
  });
  $('#select_examen').select2({
    width: '100%',
    minimumInputLength: 3,
    ajax: {
      url: '/cargar_prestaciones',
      dataType: 'json',
      type: 'POST',
      data: function (term, page) {
        return {
          q: term,
          tipo: 'examen'
        };
      },
      results: function (data, page) {
        return { results: data };
      }
    }
  });
  $('#select_procedimiento').select2({
    width: '100%',
    minimumInputLength: 3,
    ajax: {
      url: '/cargar_prestaciones',
      dataType: 'json',
      type: 'POST',
      data: function (term, page) {
        return {
          q: term,
          tipo: 'procedimiento'
        };
      },
      results: function (data, page) {
        return { results: data };
      }
    }
  });
  $('#select_medicamento').select2({
    width: '100%',
    minimumInputLength: 3,
    ajax: {
      url: '/cargar_medicamentos',
      dataType: 'json',
      type: 'POST',
      data: function (term, page) {
        return {
          q: term,          
        };
      },
      results: function (data, page) {
        return { results: data };
      }
    }
  });

});

function cargarCalendario(){

  $(function() {
      $( ".datepicker" ).datepicker({
        showOtherMonths: true,
        electOtherMonths: true,
        changeMonth: true,
        changeYear: true,
        dateFormat: 'yy-mm-dd',
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
      });
  });

  $(function($){
      $.datepicker.regional['es'] = {
          closeText: 'Cerrar',
          prevText: 'Anterior',
          nextText: 'Siguiente',
          currentText: 'Hoy',
          monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
          monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
          dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
          dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
          weekHeader: 'Sm',
          dateFormat: 'yy-mm-dd',
          firstDay: 1,
          isRTL: false,
          showMonthAfterYear: false,
          yearSuffix: ''
      };
      $.datepicker.setDefaults($.datepicker.regional['es']);
  });

}

$("#select_diagnostico").on("change", function(e) { 

  var value = $("#select_diagnostico").val();
  var text = $('#select_diagnostico option:selected').html();
  agregarDiagnostico(value,text);

})

$("#select_diag_no_frec").on("change", function(e) { 

  var value = $("#select_diag_no_frec").select2('data').id;
  var text = $("#select_diag_no_frec").select2('data').text;
  agregarDiagnostico(value,text);

})

function agregarDiagnostico(value,text){
 
 $.ajax({
    type: 'POST',
    url: '/agregar_diagnostico',
    data: {
      persona_id: persona_id,
      diagnostico_id: value,
      atencion_salud_id: atencion_salud_id,
    },
    success: function(response) {

      if (response.success){
        option = '';
        est = response.estados;
        for (i=0;i<est.length;i++)
          option += '<option value="'+est[i]['id']+'">'+est[i]['nombre']+'</option>';
        
        pe_di = response.per_diag;
        $('#diagnostico-div').append('<a href="#modal-container-diag-'+pe_di+'" class="list-group-item" data-toggle="modal" id="pd'+pe_di+'"><p class="list-group-item-text">'+text+'<button id="bc'+pe_di+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarDiagnostico('+pe_di+')" >Eliminar</button></p></a>');
        $('#diag_modal-div').append('<div class="modal fade" id="modal-container-diag-'+pe_di+'" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title" id="myModalLabel">'+text+'</h4></div><div class="modal-body"><p>Fecha inicio: <input name="f_i_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" value="'+response.fe_ini+'"></p><p>Fecha término: <input name="f_t_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" ></p><p>Estado de diagnóstico actual:<select id="e_d_'+pe_di+'" name="selectbasic" class="form-control" >'+option+'</select></p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> <button type="button"  onclick="guardarDiagnostico('+pe_di+')" class="btn btn-primary">Guardar</button></div></div></div></div>');
        
         cargarCalendario();

      }
    },
    error: function(xhr, status, error){ alert("No se pudieron los diagnósticos del paciente."); }
  });

}

$("#select_examen").on("change", function(e) { 

  var value = $("#select_examen").select2('data').id;
  var text = $("#select_examen").select2('data').text;
  
  $.ajax({
    type: 'POST',
    url: '/agregar_prestacion',
    data: {
      persona_id: persona_id,
      prestacion_id: value,
      atencion_salud_id: atencion_salud_id,
    },
    success: function(response) {

      if (response.success){
            
        pe_exa = response.per_pre;
        $('#examen-div').append('<a href="#" class="list-group-item" data-toggle="modal" id="pp'+pe_exa+'"><p class="list-group-item-text">'+text+'<button id="bcp'+pe_exa+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarPrestacion('+pe_exa+')" >Eliminar</button></p></a>');
        
      }
    },
    error: function(xhr, status, error){ alert("No se pudo agregar el examen o procedimiento del paciente."); }
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
    },
    success: function(response) {

      if (response.success){
            
        pe_pro = response.per_pre;
        $('#procedimiento-div').append('<a href="#" class="list-group-item" data-toggle="modal" id="pp'+pe_pro+'"><p class="list-group-item-text">'+text+'<button id="bcp'+pe_pro+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarPrestacion('+pe_pro+')" >Eliminar</button></p></a>');
        
      }
    },
    error: function(xhr, status, error){ alert("No se pudo agregar el examen o procedimiento del paciente."); }
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

      if (response.success){
            
        pe_med = response.per_med;
        $('#medicamento-div').append('<a href="#modal-container-med-'+pe_med+'" class="list-group-item" data-toggle="modal" id="pm'+pe_med+'"><p class="list-group-item-text">'+text+'<button id="bpm'+pe_med+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarMedicamento('+pe_med+')" >Eliminar</button></p></a>');
        $('#med_modal-div').append('<div class="modal fade" id="modal-container-med-'+pe_med+'" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title" id="myModalLabel">'+text+'</h4></div><div class="modal-body"></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> <button type="button"  onclick="guardarMedicamento('+pe_med+')" class="btn btn-primary">Guardar</button></div></div></div></div>');

      }
    },
    error: function(xhr, status, error){ alert("No se pudo agregar el medicamento del paciente."); }
  });  

})



function eliminarDiagnostico(pers_diag) {
  var div = document.getElementById("modal-container-diag-"+pers_diag);
  div.parentNode.removeChild(div);

  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { persona_diagnostico_id: pers_diag},

    success: function(response) { $( "#pd"+pers_diag).remove();$( "#bc"+pers_diag).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el diagnóstico del paciente.");   }
  });
   
}

function eliminarMedicamento(pers_med) {
  var div = document.getElementById("modal-container-"+pers_med);
  div.parentNode.removeChild(div);

  $.ajax({
    type: 'POST',
    url: '/eliminar_medicamento',
    data: { persona_medicamento_id: pers_med},

    success: function(response) { $( "#pm"+pers_med).remove();$( "#bpm"+pers_med).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el medicamento del paciente.");   }
  });
   
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
      comentario: comentario
     },
    success: function(response) { $( "#modal-container-"+pers_diag).modal('hide'); },
    error: function(xhr, status, error){ alert("No se pudo guardar el diagnóstico del paciente.");   }
  });

}

function guardarExamen(pers_exa) {

  alert('hola');

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