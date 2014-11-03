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
  width: '50%',
  minimumInputLength: 3,
  placeholder: "Seleccione una ocupacion",
  allowClear: true,
  ajax: {
    url: '/cargar_ocupaciones',
    dataType: 'json',
    type: 'POST',
    data: function (term, page) { return { q: term }; },
    results: function (data, page) { return { results: data };}
  }
});

$('#agregar-ocupacion').click(function() {
  if ( validarFecha() )
  {
    var f_i = $('#f_i_ocu').datepicker("getDate");
    var f_f = $('#f_f_ocu').datepicker("getDate");
    var value = $("#select_ocupacion").select2('data') != null ? $("#select_ocupacion").select2('data').id : null;
    $.ajax({
      type: 'POST',
      url: '/ocupaciones',
      data: { f_i: f_i, f_f: f_f, value: value },
      success: function(response) { window.location.href = '/ocupaciones/index';  },
      error: function(xhr, status, error){ alert("No se pudo agregar el antecedente laboral."); }
    }); 
  } 
});

function validarFecha(){
  valido = true;
  $('#alert-ocu').hide();
  $('#alert-fecha-ocu').hide();
  $('#alert-fecha-inicio-ocu').hide();
  $('#alert-fecha-final-ocu').hide();
  var value = $("#select_ocupacion").select2('data');
  var f_i = $('#f_i_ocu').datepicker("getDate");
  var f_f = $('#f_f_ocu').datepicker("getDate");
  var ocu_act = $('#ocupacion-actual').is(':checked');
  if (value == null)
  {
    valido = false;
    $('#alert-ocu').show();
  }
  if(f_i != null && f_f != null )
    if (f_i > f_f ){
      valido = false;
      $('#alert-fecha-ocu').show();
    }
  if (f_i == null ){
    valido = false;
    $('#alert-fecha-inicio-ocu').show();
  } 
  if (f_f == null && !ocu_act ){
    valido = false;
    $('#alert-fecha-final-ocu').show();
  }     

  return valido;
}

$('#ocupacion-actual').change(function() {

  valor = $(this).is(':checked');
  if (valor){
    $('#div-fecha-final').hide();
    $('#f_f_ocu').datepicker("setDate","");
  }
  else {
    $('#div-fecha-final').show(); 
  }   

});
