  if ( $.fn.dataTable.isDataTable( '#lista_atenciones_para_pago' ) ) { }
  else {
    $('#lista_atenciones_para_pago').DataTable({
      "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
      "columnDefs":[ { "targets": [ 0 ], "visible": false }],
      "language": {
        "lengthMenu": "Mostrar _MENU_ atenciones por página",
        "zeroRecords": "La búsqueda no arrojó resultados.",
        "info": "Mostrando _START_ a _END_ de un total de _TOTAL_ atenciones de salud",
        "infoEmpty": "No hay atenciones que mostrar",
        "infoFiltered": "(filtrados de un total de _MAX_)",
        "search": "Búsqueda",
        "oPaginate": {
          "sPrevious": "Página anterior",
          "sNext": "Página siguiente"
        }
      },
      "footerCallback": function ( row, data, start, end, display ) {
        var api = this.api(), data;

        // Remove the formatting to get integer data for summation
        var intVal = function ( i ) {
            return typeof i === 'string' ?
                i.replace(/[\$.]/g, '')*1 :
                typeof i === 'number' ?
                    i : 0;
        };

        // Total over all pages
        total = api
            .column( 7 )
            .data()
            .reduce( function (a, b) {
                return intVal(a) + intVal(b);
            } );

        // Total over this page
        pageTotal = api
            .column( 7, { search: 'applied'} )
            .data()
            .reduce( function (a, b) {
                return intVal(a) + intVal(b);
            }, 0 );

        // Update footer
        $( api.column( 6 ).footer() ).html(
            '$ '+pageTotal.toLocaleString().replace(',','.') +' ( de un total de $ '+ total.toLocaleString().replace(',','.') +')'
        );
      }

    });
  }

$(function () {
  $('#datetimepicker6').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'    
  });
  $('#datetimepicker7').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  });
  $("#datetimepicker6").on("dp.change", function (e) {
    $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker7").on("dp.change", function (e) {
    $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
  });
});

$(document).ready(function() {
  if ( $("#datetimepicker7").length > 0 ) 
    $('#datetimepicker7').data("DateTimePicker").minDate(fecha_minima);
});

$('input[type=radio][name=radios-boletas]').click(function() {
  
  var valor = $('input[name=radios-boletas]:checked').val();
 
  if (valor == 2)  
    $('#algunos_profesionales').modal('show');    
  else  
    $('#algunos_profesionales').modal('hide');  

});

$('#filtrar-atenciones').click(function() {
  var fecha_inicio = $('#fecha_inicio_boleta').val();
  var fecha_final = $('#fecha_hasta_boleta').val();
  var todos_profesionales = $('input[name=radios-boletas]:checked').val();

  var profesionales = new Array();
  if (todos_profesionales == 2 ){
    var lista_profesionales = $('#checkbox_profesionales').find('.childCheckBox');
    lista_profesionales.each( 
      function() {
        if ( this.checked ) 
          profesionales.push(this.id.substring(12));
      }
    )
  }
  if (profesionales.length == 0 && todos_profesionales == 2)
    alert('Seleccione un profesional.');  
  else if ( fecha_inicio != '' || fecha_final != '') {
    $.ajax({
      type: 'POST',
      url: '/cargar_atenciones_salud_para_pago',
      data: { todos_profesionales: todos_profesionales, profesionales: profesionales, fecha_inicio: fecha_inicio, fecha_final: fecha_final },
      success: function(response){ 

        var table = $('#lista_atenciones_para_pago').DataTable();
        table
          .clear()
          .rows.add(response)
          .draw();
      },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar los antecedentes."); }
    });

  } 
  else
    alert('Selecciona un parámetro de búsqueda.'); 
  
});

$('#generar-boletas').click(function() {

  var table = $('#lista_atenciones_para_pago').DataTable();
  console.log(table.column( 0, {order:'current'} ).data());
                             

})
