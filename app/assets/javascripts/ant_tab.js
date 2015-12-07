$("input[id^=cigarros-dia-]").keyup(function() {
  var id;
  id = $(this).attr('id').substring(13);
  calcularPaquetes(id);
});

$('.agno').datetimepicker({
  locale: 'es',
  format: 'YYYY'
});

$("input[id^=fecha-inicio-tabaco-]").on("dp.change", function (e) {  
  id = $(this).attr('id').substring(20);
  $('#fecha-final-tabaco-'+id).data("DateTimePicker").minDate(e.date);
  calcularPaquetes(id);
});

$("input[id^=fecha-final-tabaco-]").on("dp.change", function (e) {
  id = $(this).attr('id').substring(19);
  $('#fecha-inicio-tabaco-'+id).data("DateTimePicker").maxDate(e.date);
  calcularPaquetes(id);
});
