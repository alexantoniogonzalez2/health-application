$(document).ready(function() {

  $.ajax({
    type: 'POST',
    url: '/cargar_datos_peso',
    data: {
      persona_id: persona_id,
    },
    success: function(response) {   
      //alert (response.valor);
      //alert (response);

      /*$.getJSON(response, function(data) {
        options.series[0].data = data;
        
      });*/

      cargarGraficoPeso(response);
    },
    error: function(xhr, status, error){ alert("No se pudo cargar los datos de peso del paciente.");   }
  });
   
 });

function cargarGraficoPeso (data){

 // alert(data);

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
          categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
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
    

