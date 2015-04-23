$('input[id^=fecha]').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

$('input[id^=ant-gin-]').change(function() {
  var id = $(this).attr('id').substring(8);
  var value = $(this).val();
  guardarAntecedentesGinecologicos(id, value);
});

$('input[id^=fecha-gin-]').on("dp.change", function (e) {
  var id = $(this).attr('id').substring(10);
  var value = $(this).val();
  guardarAntecedentesGinecologicos(id, value); 
});

function guardarAntecedentesGinecologicos(id, value){
   if (typeof atencion_salud_id !== 'undefined') 
    at_salud_id = atencion_salud_id;
  else
    at_salud_id = 'persona';
  
  $.ajax({
    type: 'POST',
    url: '/guardar_antecedentes_ginecologicos',
    data: { id: id, value: value, atencion_salud_id: at_salud_id },
    success: function(response) { },
    error: function(xhr, status, error){ alert("No se pudo actualizar el antecedente."); }
  });

}