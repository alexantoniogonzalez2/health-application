function addSpinner(element_id){ $('#'+element_id).append("<div class='div-spinner'><i class='fa fa-cog fa-spin fa-5x'></i></div>"); }

$(document).ready(function() {

  $('.icon-eno').qtip({ content: { text: 'Fecha de primeros síntomas o de primera consulta.' }})
  $('.icon-ges').qtip({ content: { text: 'Parentesco o relación con el paciente.' }})
  $('.icon-int').qtip({ content: { text: 'Parentesco o relación con el paciente.' }})
  $('#med').qtip({ content: { text: 'Medicamentos' }})
  $('#ale').qtip({ content: { text: 'Alergias' }})
  $('#vac').qtip({ content: { text: 'Vacunas' }})
  $('#act_fis').qtip({ content: { text: 'Actividad física' }})
  $('#hab_alc').qtip({ content: { text: 'Hábitos de alcohol' }})
  $('#hab_tab').qtip({ content: { text: 'Hábitos de tabaco' }})
  $('#ant_fam').qtip({ content: { text: 'Antecedentes familiares' }})
  $('#ant_soc').qtip({ content: { text: 'Antecedentes sociales' }})
  $('#ant_lab').qtip({ content: { text: 'Antecedentes laborales' }})
  $('#ant_qui').qtip({ content: { text: 'Antecedentes quirúrgicos' }})
  $('#ant_gin').qtip({ content: { text: 'Antecedentes ginecológicos' }})

  if ( $.fn.dataTable.isDataTable( '#lista_atenciones' ) ) { }
  else {
    $('#lista_atenciones').DataTable({
      "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
      "language": {
        "lengthMenu": "Mostrar _MENU_ atenciones por página",
        "zeroRecords": "La búsqueda no arrojó resultados.",
        "info": "Página _PAGE_ de _PAGES_",
        "infoEmpty": "No hay atenciones que mostrar",
        "infoFiltered": "(filtrados de un total de _MAX_ atenciones de salud)",
        "search": "Búsqueda",
        "oPaginate": {
          "sPrevious": "Página anterior",
          "sNext": "Página siguiente"
        }      
      }
    });
  }

  if ( $.fn.dataTable.isDataTable( '#lista_atenciones_buscar' ) ) { }
  else {
    var table = $('#lista_atenciones_buscar').DataTable({
                    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
                    "language": {
                      "lengthMenu": "Mostrar _MENU_ atenciones por página",
                      "zeroRecords": "La búsqueda no arrojó resultados.",
                      "info": "Página _PAGE_ de _PAGES_",
                      "infoEmpty": "No hay atenciones que mostrar",
                      "infoFiltered": "(filtrados de un total de _MAX_ atenciones de salud)",
                      "search": "Búsqueda",
                      "oPaginate": {
                        "sPrevious": "Página anterior",
                        "sNext": "Página siguiente"
                      }      
                    }
                  });
  }
   
  $('#div_atenciones').show();

  $('.load_ant').click(function() {
    addSpinner('contenido-ant');
    var ant = $(this).attr('id');
    $.ajax({
      type: 'POST',
      url: '/cargar_antecedentes',
      data: { ant: ant, persona_id: persona_id, at_sal: atencion_salud_id},
      success: function(response){ },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar los antecedentes."); }
    });
  });

});

function cerrarModalAntMed(modal_id){ $('#modal-container-med-' + modal_id ).modal('hide'); }
function cerrarModalAntPres(modal_id){ $('#modal-container-pres-' + modal_id ).modal('hide'); }
function cerrarModalHabAlc(modal_id){ $('#modal-container-hab-alc-' + modal_id ).modal('hide'); }
function cerrarModalHabTab(modal_id){ $('#modal-container-hab-tab-' + modal_id ).modal('hide'); }
function cerrarModalOcu(modal_id){ $('#modal-container-ocu-' + modal_id ).modal('hide'); }
function cerrarModalAgregarPersona(modal_id){ $('#modal-container-agregar-persona-' + modal_id ).modal('hide'); }
function cerrarModalAntFamMue(modal_id){ $('#modal-container-ant-fam-mue-' + modal_id ).modal('hide'); }
function cerrarModalAntFamCro(modal_id){ $('#modal-container-ant-fam-cro-' + modal_id ).modal('hide'); }
function cerrarModalDiag(modal_id){ $('#modal-container-diag-' + modal_id ).modal('hide'); }

$('select.select_buscar_paciente').select2({ width: '100%', placeholder: 'Selecciona un paciente', allowClear: true });

$('#date_fecha_inicio').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

$('#date_fecha_final').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

$('#buscar-atenciones').click(function() {
  var paciente = $('#select-paciente-buscar').val();
  var fecha_inicio = $('#date_fecha_inicio').val();
  var fecha_final = $('#date_fecha_final').val();

  if (paciente != '' || fecha_inicio != '' || fecha_final != '' ){
    $.ajax({
      type: 'POST',
      url: '/cargar_atenciones_salud',
      data: { paciente: paciente, fecha_inicio: fecha_inicio, fecha_final: fecha_final },
      success: function(response){ 

        if ( $.fn.dataTable.isDataTable( '#lista_atenciones_buscar' ) ) { var table = $('#lista_atenciones_buscar').DataTable(); table.destroy(); }
       
          var table = $('#lista_atenciones_buscar').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
                "language": {
                  "lengthMenu": "Mostrar _MENU_ atenciones por página",
                  "zeroRecords": "La búsqueda no arrojó resultados.",
                  "info": "Página _PAGE_ de _PAGES_",
                  "infoEmpty": "No hay atenciones que mostrar",
                  "infoFiltered": "(filtrados de un total de _MAX_ atenciones de salud)",
                  "search": "Búsqueda",
                  "oPaginate": {
                    "sPrevious": "Página anterior",
                    "sNext": "Página siguiente"
                  }      
                },                
                "data": response,
                 "columns": [
                      { "title": "Número" },
                      { "title": "Fecha" },
                      { "title": "Paciente" },
                      { "title": "Rut" },
                      { "title": "Ver atención" },
                  ]
              });

      },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar los antecedentes."); }
    });

  } 
  else
    alert('Selecciona un parámetro de búsqueda.'); 
});