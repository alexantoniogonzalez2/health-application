if ( $.fn.dataTable.isDataTable( '#lista_atenciones_para_pago' ) ) { }
else {
  $('#lista_atenciones_para_pago').DataTable({
    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
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
    }
  });
}

if ( $.fn.dataTable.isDataTable( '#lista_boletas' ) ) { }
else {
  $('#lista_boletas').DataTable({
    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],    
    "columnDefs":[ { "targets": [ 0 ], "visible": false }],
    "language": {
      "lengthMenu": "Mostrar _MENU_ boletas por página",
      "zeroRecords": "La búsqueda no arrojó resultados.",
      "info": "Mostrando _START_ a _END_ de un total de _TOTAL_ boletas",
      "infoEmpty": "No hay boletas que mostrar",
      "infoFiltered": "(filtrados de un total de _MAX_)",
      "search": "Búsqueda",
      "oPaginate": {
        "sPrevious": "Página anterior",
        "sNext": "Página siguiente"
      }
    }
  });
}

if ( $.fn.dataTable.isDataTable( '#lista_atenciones_para_pago_gen_bol' ) ) { }
else {
  $('#lista_atenciones_para_pago_gen_bol').DataTable({
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
      
      var count = api
              .column( 0 )
              .data()
              .length;

      if (count > 0){        
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
            '$ '+pageTotal.toLocaleString().replace(',','.') +' (de un total de $ '+ total.toLocaleString().replace(',','.') +')'
        );
      }
      
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

if ( $.fn.dataTable.isDataTable( '#lista_boletas_profesional' ) ) { }
else {
  $('#lista_boletas_profesional').DataTable({
    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],    
    "columnDefs":[ { "targets": [ 0 ], "visible": false }],
    "language": {
      "lengthMenu": "Mostrar _MENU_ boletas por página",
      "zeroRecords": "La búsqueda no arrojó resultados.",
      "info": "Mostrando _START_ a _END_ de un total de _TOTAL_ boletas",
      "infoEmpty": "No hay boletas que mostrar",
      "infoFiltered": "(filtrados de un total de _MAX_)",
      "search": "Búsqueda",
      "oPaginate": {
        "sPrevious": "Página anterior",
        "sNext": "Página siguiente"
      }
    }
  });
}

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
    ('#msg_boletas').html('');
    $.ajax({
      type: 'POST',
      url: '/cargar_atenciones_salud_para_pago',
      data: { todos_profesionales: todos_profesionales, profesionales: profesionales, fecha_inicio: fecha_inicio, fecha_final: fecha_final },
      success: function(response){ 
        var table = $('#lista_atenciones_para_pago_gen_bol').DataTable();
        table
          .clear()
          .rows.add(response)
          .draw();
      },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar las atenciones para pago."); }
    });

  } 
  else
    alert('Seleccione un parámetro de búsqueda.'); 
  
});

$('#generar-boletas').click(function() {

  var table = $('#lista_atenciones_para_pago_gen_bol').DataTable();
  var lista_atenciones = table.columns( 0, { search: 'applied'} ).data()[0];
  var fecha_inicio = $('#fecha_inicio_boleta').val();
  var fecha_final = $('#fecha_hasta_boleta').val();

  if ( lista_atenciones.length > 0){
    $.ajax({
      type: 'POST',
      url: '/generar_boletas',
      data: { lista_atenciones: lista_atenciones, fecha_inicio: fecha_inicio, fecha_final: fecha_final },
      success: function(response){ 
        table
          .rows( { search: 'applied'} )
          .remove()
          .draw();

        table.search('').draw();  

        var table_boletas = $('#lista_boletas').DataTable();
        table_boletas
          .rows.add(response)
          .draw();

        $('#msg_boletas').html('Boletas creadas: ' + response.length +' <a href="#ver_boletas" role="tab" data-toggle="tab">Ver boletas</a>'); 

      },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar los antecedentes."); }
    });
  } else {
    alert('No hay atenciones para procesar.');
  }                            

})

$('input[type=radio][name=radios-ver-boletas]').click(function() {
  
  var valor = $('input[name=radios-ver-boletas]:checked').val();
 
  if (valor == 2)  
    $('#algunos_profesionales_ver_boletas').modal('show');    
  else  
    $('#algunos_profesionales_ver_boletas').modal('hide');  

});

$(function () {
  $('#datetimepicker8').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'    
  });
  $('#datetimepicker9').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  });
  $("#datetimepicker8").on("dp.change", function (e) {
    $('#datetimepicker9').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker9").on("dp.change", function (e) {
    $('#datetimepicker8').data("DateTimePicker").maxDate(e.date);
  });
});

$('#filtrar-boletas').click(function() {
  var fecha_inicio = $('#fecha_inicio_ver_boleta').val();
  var fecha_final = $('#fecha_hasta_ver_boleta').val();
  var todos_profesionales = $('input[name=radios-ver-boletas]:checked').val();

  var profesionales = new Array();
  if (todos_profesionales == 2 ){
    var lista_profesionales = $('#checkbox_profesionales_boletas').find('.childCheckBox');
    lista_profesionales.each( 
      function() {
        if ( this.checked ) 
          profesionales.push(this.id.substring(23));
      }
    )
  }
  if (profesionales.length == 0 && todos_profesionales == 2)
    alert('Seleccione un profesional.');  
  else if ( fecha_inicio != '' || fecha_final != '' || todos_profesionales == 1 || (todos_profesionales == 2 && profesionales.length != 0 ) ) {
    $.ajax({
      type: 'POST',
      url: '/filtrar_boletas',
      data: { todos_profesionales: todos_profesionales, profesionales: profesionales, fecha_inicio: fecha_inicio, fecha_final: fecha_final },
      success: function(response){ 
        var table = $('#lista_boletas').DataTable();
        table
          .clear()
          .rows.add(response)
          .draw();
      },
      error: function(xhr, status, error){ alert("Se produjo un error al cargar las boletas."); }
    });

  } 
  else
    alert('Seleccione un parámetro de búsqueda.');  
});

function loadAtenciones(boleta){
  //$('.load_atenciones').click(function() {
  addSpinner('contenido-ver-atenciones-boleta');
  //var boleta = $(this).attr('id').substring(4);
  $.ajax({
    type: 'POST',
    url: '/cargar_atenciones_boleta',
    data: { boleta: boleta },
    success: function(response){ },
    error: function(xhr, status, error){ alert("Se produjo un error al cargar las atenciones."); }
  });
 // });
}

function anularBoleta(boleta_id){         
  $.ajax({
    type: 'POST',
    url: '/anular_boleta',
    data: { boleta: boleta_id },
    success: function(response){ 
        var table = $('#lista_boletas').DataTable();
        var cell = table.cell('#cell-'+boleta_id);
        cell.data('Anulada').draw();
    },
    error: function(xhr, status, error){ alert("Se produjo un error al anular la boleta."); }
  });
}