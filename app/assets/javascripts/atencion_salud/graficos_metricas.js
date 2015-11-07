$(function() {

    $('#tabpanel-peso, #tabpanel-estatura, #tabpanel-presion_am, #tabpanel-presion_sis,#tabpanel-presion_dias, #tabpanel-IMC, #tabpanel-frec_car,#tabpanel-frec_res,#tabpanel-temp,#tabpanel-sat').bind('click', function (e) {
      
      id = this.id;
      tipo = id.substring(9);

      $.ajax({
        type: 'POST',
        url: '/cargar_datos_metricas',
        data: {
          persona_id: $('#persona_id').val() ,
          tipo: tipo
        },
        success: function(response) { 
          cargarGrafico(response,tipo);
        },
        error: function(xhr, status, error){ alert("No se pudo actualizar los gráficos métricas o signos vitales del paciente.");   }
      });
      
    });
});

function cargarGrafico (data,tipo){
 
  $('#grafico_'+tipo).highcharts({
      title: {
        text: data.nombre_metrica +' Histórico',
        x: -20 //center
      },
      subtitle: {
        text: 'Nombre: '+data.paciente,
        x: -20
      },
      xAxis: {
        categories: data.texto
      },
      yAxis: {
        title: {
          text: data.unidad
        },
        plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
        }]
      },
      tooltip: {
        valueSuffix: ' '+data.unidad
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      },
      series: [{
        name: data.nombre_metrica,
        data: data.datos
      }],
      credits: {
        enabled: false
      },
      lang: {
        downloadPNG: "Descargar gráfico en formato PNG",
        downloadJPEG: "Descargar gráfico en formato JPEG",
        downloadSVG: "Descargar gráfico en formato SVG",
        downloadPDF: "Descargar gráfico en PDF",
        contextButtonTitle: "Opciones para descargar gráfico",
        decimalPoint: ',',
        noData: "No hay datos para mostrar",
        printChart: "Imprimir gráfico",
        thousandsSep: "." 
      } ,
      exporting: {
        buttons: {
            exportButton: {
                enabled: false,
            }
        },
        
    }



  });



}
    

  



