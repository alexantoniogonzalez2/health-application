$(".datepicker").attr("placeholder", "Seleccione una fecha").datepicker({
  showOtherMonths: true,
  selectOtherMonths: true,
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
  showButtonPanel: true,
  onSelect: function(dateText) {
    calcularPaquetes($(this).attr('id').substring(4));
  }
});

$("input[id^=cigarros-dia-]").keyup(function() {
  var id;
  id = $(this).attr('id').substring(13);
  calcularPaquetes(id);
});