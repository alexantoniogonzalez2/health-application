function guardarAntOcupacion(id) {
  var tipo = $('#guardar-ocupacion-'+id).attr('name');
  if( validarFecha(id) )
    guardarOcupacion(tipo,id);   
}


function guardarOcupacion(tipo,id){
  var f_i = $('#f_i_ocu-' + id ).datepicker("getDate");
  var f_f = $('#f_f_ocu-' + id ).datepicker("getDate");
  var value = $("#select_ocupacion-" + id ).select2('data').id;
  var ocu_act = $('#ocupacion-actual-' + id).is(':checked');
  if (typeof atencion_salud_id !== 'undefined') { }
  else { atencion_salud_id = 'persona'; } 
  $.ajax({
    type: 'POST',
    url: '/ocupaciones',
    data: { f_i: f_i, f_f: f_f, value: value, tipo: tipo, id: id , atencion_salud_id: atencion_salud_id, ocu_act: ocu_act },
    success: function(response) { $( "#modal-container-ocu-" + id ).modal('hide'); $('#ant_lab').addClass('active-ant'); },
    error: function(xhr, status, error){ alert("No se pudo agregar el antecedente laboral."); }
  }); 
}

function validarFecha(id){
  valido = true;
  $('#alert-ocu-' + id ).hide();
  $('#alert-fecha-ocu-' + id).hide();
  $('#alert-fecha-inicio-ocu-' + id).hide();
  $('#alert-fecha-final-ocu-' + id).hide();
  var value = $("#select_ocupacion-" + id ).select2('data') != null ? $("#select_ocupacion-" + id ).select2('data').id : null;
  var f_i = $('#f_i_ocu-' + id).datepicker("getDate");
  var f_f = $('#f_f_ocu-' + id).datepicker("getDate");
  var ocu_act = $('#ocupacion-actual-' + id).is(':checked');
  
  if (value == null)
  {
    valido = false;
    $('#alert-ocu-' + id).show();
  }
  if(f_i != null && f_f != null )
    if (f_i > f_f ){
      valido = false;
      $('#alert-fecha-ocu-' + id).show();
    }
  if (f_i == null ){
    valido = false;
    $('#alert-fecha-inicio-ocu-' + id).show();
  } 
  if (f_f == null && !ocu_act ){
    valido = false;
    $('#alert-fecha-final-ocu-' + id).show();
  }     

  return valido;
}

$('.ocupacion-actual').change(function() {

  var id = $(this).attr('id').substring(17);
  valor = $(this).is(':checked');
  if (valor){
    $('#div-fecha-final-' + id ).hide();
    $('#f_f_ocu-' + id ).datepicker("setDate","");
  }
  else {
    $('#div-fecha-final-' + id ).show(); 
  }   

});

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
    data: function (term, page) { return { q: term }; },
    results: function (data, page) { return { results: data };}
  },
  initSelection: function (element, callback) {
    var text = $(element).val();
    var id = $(element).attr('name');
    if (id !== "") {
      var data = { id: id, text: text };
      callback(data);       
    }
  }
});

