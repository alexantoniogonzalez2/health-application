$( ".datepicker" ).attr("placeholder", "Seleccione una fecha").datepicker({
  showOtherMonths: true,
  selectOtherMonths: true,
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
  showButtonPanel: true, 
  onSelect: function(date) { }       
});

$('.select_ocupacion').select2({
  width: '100%',
  minimumInputLength: 3,
  placeholder: "Seleccione una ocupación",
  allowClear: true,
  ajax: {
    url: '/cargar_ocupaciones',
    dataType: 'json',
    type: 'POST',
    data: function (params) { return { q: params.term }; },
    processResults: function (data, page) { return { results: data };}
  },
  /*initSelection: function (element, callback) {
    var text = $(element).val();
    var id = $(element).attr('name');
    if (id !== "") {
      var data = { id: id, text: text };
      callback(data);       
    }
  }*/
});
