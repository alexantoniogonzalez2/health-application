$(function() {

    $('#tabpanel-peso').bind('click', function (e) {

        $.ajax({
          type: 'POST',
          url: '/cargar_datos_peso',
          data: {
            persona_id: $('#persona_id').val() ,
          },
          success: function(response) {   
            cargarGraficoPeso(response.datos,response.texto);
          },
          error: function(xhr, status, error){ alert("No se pudo cargar los datos de peso del paciente.");   }
      });
      
    });
});

function cargarGraficoPeso (data,text){
 
  $('#grafico_peso').highcharts({
      title: {
          text: 'Peso Histórico',
          x: -20 //center
      },
      subtitle: {
          text: 'Paciente:',
          x: -20
      },
      xAxis: {
          categories: text
      },
      yAxis: {
          title: {
              text: 'Peso (kilos)'
          },
          plotLines: [{
              value: 0,
              width: 1,
              color: '#808080'
          }]
      },
      tooltip: {
          valueSuffix: ' kg'
      },
      legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'middle',
          borderWidth: 0
      },
      series: [{
          name: 'Peso paciente',
          data: data
      }]
  });



}
    

  



