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
    var ant = $(this).attr('id');
    $.ajax({
      type: 'POST',
      url: '/cargar_antecedentes',
      data: { ant: ant, persona_id: persona_id, at_sal: atencion_salud_id},
      success: function(response){  },
      error: function(xhr, status, error){ alert("Se produjo un error al leer los antecedentes."); }
    });
  });



});

