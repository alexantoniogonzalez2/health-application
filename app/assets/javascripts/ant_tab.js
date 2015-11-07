$(".datepicker").attr("placeholder", "Selecciona una fecha").datepicker({
  showOtherMonths: true,
  selectOtherMonths: true,
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
  showButtonPanel: true,    
  yearRange: '1915:2017',
  onSelect: function(dateText) {
    calcularPaquetes($(this).attr('id').substring(4));
  }
});

$("input[id^=cigarros-dia-]").keyup(function() {
  var id;
  id = $(this).attr('id').substring(13);
  calcularPaquetes(id);
});