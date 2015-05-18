function guardarConsumoTabaco(id) {
	var tipo = $('#guardar-consumo-'+id).attr('name');
	var f_i = $('#f_i-'+id).datepicker("getDate");
	var f_f = $('#f_f-'+id).datepicker("getDate");
	var cigarrosDia = $("#cigarros-dia-"+id).val();
	var paquetesAgno = $("#paquetes-agno-"+id).val()
	if (cigarrosDia < 1)
		$("#alert-cigarros-dia-"+id).show();
  if (f_i == null) 
		$("#alert-fecha-inicio-"+id).show();
	if (f_f == null)
		$("#alert-fecha-final-"+id).show() 
	
	if (cigarrosDia < 1 || f_i == null || f_f == null )
	  valid =  false;
	else
		valid =  true;

	if (valid)
		guardarConsumo(f_i,f_f,cigarrosDia,paquetesAgno,tipo,id);
}
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

function alertMessage(id){
  $('#alert-fecha-' + id).show();
  $("#paquetes-agno-" + id).val('');
  $('#f_f-' + id).datepicker('setDate', null);
};

function hideMessage(id){
  $('#alert-fecha-' + id).hide();
  $('#alert-fecha-inicio-' + id).hide();
  $('#alert-fecha-final-' + id).hide();
  $('#alert-cigarros-dia-' + id).hide();
};

function calcularPaquetes(id){
  var cigarrosDia, f_f, f_i, paquetesAgno;
  hideMessage(id);
  cigarrosDia = $("#cigarros-dia-" + id).val();
  f_i = $('#f_i-' + id).datepicker("getDate");
  f_f = $('#f_f-' + id).datepicker("getDate");
  if (!(f_i === null || f_f === null)) {
    if (f_i > f_f) {
      alertMessage(id);
    } else {
      paquetesAgno = (cigarrosDia / 20 * (f_f - f_i) / (86400000 * 365)).toFixed(2);
      $("#paquetes-agno-" + id).val(paquetesAgno);
    }
  }
};

function guardarConsumo(f_i, f_f, cigarrosDia, paquetesAgno, tipo, id) {
  var at_salud_id;
  if (typeof atencion_salud_id !== 'undefined') {
    at_salud_id = atencion_salud_id;
  } else {
    at_salud_id = 'persona';
  }
  $.ajax('/habitos_tabaco', {
    type: 'POST',
    data: {
      atencion_salud_id: at_salud_id,
      f_i: f_i,
      f_f: f_f,
      cigarrosDia: cigarrosDia,
      paquetesAgno: paquetesAgno,
      tipo: tipo,
      id: id
    },
    error: function(jqXHR, textStatus, errorThrown) {},
    success: function(data, textStatus, jqXHR) {
    	$("#modal-container-hab-tab-"+id).modal('hide');
      $('#hab_tab').addClass('active-ant');
    }
  });
};
