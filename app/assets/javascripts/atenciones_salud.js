function addSpinner(element_id){ $('#'+element_id).append("<div class='div-spinner'><i class='fa fa-cog fa-spin fa-5x'></i></div>"); }
//function removeSpinner(element_id){ $('#'+element_id).remove(); }

$(document).ready(function() {


  $("#lista_atenciones").dataTable().fnDestroy();

  $('#lista_atenciones').dataTable({
  	"sPaginationType": "bootstrap",
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