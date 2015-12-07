function guardarConsumoTabaco(id) {
	var tipo = $('#guardar-consumo-'+id).attr('name');
	var f_i = $('#fecha-inicio-tabaco-'+id).val();
	var f_f = $('#fecha-final-tabaco-'+id).val();
	var cigarrosDia = $("#cigarros-dia-"+id).val();
	var paquetesAgno = $("#paquetes-agno-"+id).val()
	if (cigarrosDia < 1)
		$("#alert-cigarros-dia-"+id).show();
  if (f_i == '') 
		$("#alert-fecha-inicio-"+id).show();
	if (f_f == '')
		$("#alert-fecha-final-"+id).show() 
	
	if (cigarrosDia < 1 || f_i == '' || f_f == '')
	  valid =  false;
	else
		valid =  true;

	if (valid)
		guardarConsumo(f_i,f_f,cigarrosDia,paquetesAgno,tipo,id);
}

$("input[id^=cigarros-dia-]").keyup(function() {
  var id;
  id = $(this).attr('id').substring(13);
  calcularPaquetes(id);
});

function hideMessage(id){
  $('#alert-fecha-inicio-' + id).hide();
  $('#alert-fecha-final-' + id).hide();
  $('#alert-cigarros-dia-' + id).hide();
};

function calcularPaquetes(id){
  var cigarrosDia, f_f, f_i, paquetesAgno;
  hideMessage(id);
  cigarrosDia = $("#cigarros-dia-" + id).val();
  f_i = $("#fecha-inicio-tabaco-"+id).val();
  f_f = $("#fecha-final-tabaco-"+id).val();
  if (!(f_i == '' || f_f === '')) {    
    paquetesAgno = (cigarrosDia / 20 * (f_f - f_i +1) ).toFixed(2);
    $("#paquetes-agno-" + id).val(paquetesAgno);    
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
