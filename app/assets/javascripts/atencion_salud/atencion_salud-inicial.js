$("#select_diagnostico").chosen({
  no_results_text: 'No hubo coincidencias.',
  allow_single_deselect: false,
  width: "300px" 
}); 

$("#select_examen").chosen({
  no_results_text: 'No hubo coincidencias.',
  allow_single_deselect: false,
  width: "300px" 
}); 

$(document).ready(function(){

  cargarCalendario();

  $('#select').select2({
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
  $('#select2').select2({
    width: '100%',
    minimumInputLength: 3,
    ajax: {
      url: '/cargar_examenes',
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

$("#select").on("change", function(e) { 

  var value = $("#select").select2('data').id;
  var text = $("#select").select2('data').text;
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
        $('#diagnostico-div').append('<a href="#modal-container-'+pe_di+'" class="list-group-item" data-toggle="modal" id="pd'+pe_di+'"><p class="list-group-item-text">'+text+'<button id="bc'+pe_di+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarDiagnostico('+pe_di+')" >Eliminar</button></p></a>');
        $('#diag_modal-div').append('<div class="modal fade" id="modal-container-'+pe_di+'" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title" id="myModalLabel">'+text+'</h4></div><div class="modal-body"><p>Fecha inicio: <input name="f_i_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" value="'+response.fe_ini+'"></p><p>Fecha término: <input name="f_t_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" ></p><p>Estado de diagnóstico actual:<select id="e_d_'+pe_di+'" name="selectbasic" class="form-control" >'+option+'</select></p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> <button type="button"  onclick="guardarDiagnostico('+pe_di+')" class="btn btn-primary">Guardar</button></div></div></div></div>');
        
         cargarCalendario();

      }
    },
    error: function(xhr, status, error){ alert("No se pudieron los diagnósticos del paciente."); }
  });

}

function eliminarDiagnostico(pers_diag) {
  var div = document.getElementById("modal-container-"+pers_diag);
  div.parentNode.removeChild(div);
  
  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { persona_diagnostico_id: pers_diag, },

    success: function(response) { $( "#pd"+pers_diag).remove();$( "#bc"+pers_diag).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el diagnóstico del paciente.");   }
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

$("#select_examen").on("change", function(e) { 

  var value = $("#select_examen").val();
  var text = $('#select_examen option:selected').html();

  $.ajax({
    type: 'POST',
    url: '/agregar_examen',
    data: {
      persona_id: persona_id,
      examen_id: value,
      atencion_salud_id: atencion_salud_id,
    },
    success: function(response) {

      if (response.success){       

        pe_exa = response.per_exa;
        $('#examen-div').append('<a href="#modal-container-'+pe_exa+'" class="list-group-item" data-toggle="modal" id="pe'+pe_exa+'"><p class="list-group-item-text">'+text+'<button id="bce'+pe_exa+'" type="button" class="btn btn-xs btn-danger" onclick="eliminarExamen('+pe_exa+')" >Eliminar</button></p></a>');
        //$('#diag_modal-div').append('<div class="modal fade" id="modal-container-'+pe_di+'" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title" id="myModalLabel">'+text+'</h4></div><div class="modal-body"><p>Fecha inicio: <input name="f_i_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" value="'+response.fe_ini+'"></p><p>Fecha término: <input name="f_t_'+pe_di+'" class="datepicker" type="text" placeholder="Ej.: 2014-03-13" ></p><p>Estado de diagnóstico actual:<select id="e_d_'+pe_di+'" name="selectbasic" class="form-control" >'+option+'</select></p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> <button type="button"  onclick="guardarDiagnostico('+pe_di+')" class="btn btn-primary">Guardar</button></div></div></div></div>');
      
      }
    },
    error: function(xhr, status, error){ alert("No se pudieron los diagnósticos del paciente."); }
  });

})

function eliminarExamen(pers_exa) {
  //var div = document.getElementById("modal-container-"+pers_exa);
  //div.parentNode.removeChild(div);
  
  $.ajax({
    type: 'POST',
    url: '/eliminar_examen',
    data: { persona_examen_id: pers_exa },

    success: function(response) { $( "#pe"+pers_exa).remove();$( "#bce"+pers_exa).remove(); },
    error: function(xhr, status, error){ alert("No se pudo eliminar el examen del paciente.");   }
  });
   
}