$(".datepicker").attr( 'readOnly' , 'true' );
$(".datepicker-disabled" ).attr( 'readOnly' , 'true' );

$( ".datepicker" ).attr("placeholder", "Seleccione una fecha").datepicker({
  showOtherMonths: true,
  selectOtherMonths: true,
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
  showButtonPanel: true, 
  onSelect: function(dateText) {
    var id = this.name.substring(4);
    var tipo = this.name.substring(0,4); 
    
    if (tipo === 'p_s_')
      agregarInfoEno(id,$("#p_s_"+id).datepicker("getDate"),'fecha');
    else if (tipo === 'f_p_'){
      fecha = ''
      if ($("#f_p_"+id))
        fecha = $(this).datepicker("getDate")
      agregarInfoPrestacion(id,fecha,'fecha');
    }
    else if (tipo === 'cron'){}
    else     
      guardarDiagnostico(id);
  }       
});

$( ".datepicker-disabled" ).datepicker({
  disabled: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
});

$.datepicker.regional['es'] = {
    closeText: 'Cerrar',
    prevText: '',
    nextText: '',
    currentText: 'Hoy',
    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
    monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
    dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
    weekHeader: 'Sm',
    dateFormat: 'yy-mm-dd',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
};
$.datepicker.setDefaults($.datepicker.regional['es']);

$('.fecha-mes').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
});

$('.fecha').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
});

$('select.select_especialidad_interconsulta').select2({ width: '80%', placeholder: 'Selecciona una especialidad', allowClear: true });
$('select.select_especialidad_interconsulta_ant').select2({ width: '80%', placeholder: 'Selecciona una especialidad', disabled: true });
$('select.select_persona').select2({ width: '60%', placeholder: 'Selecciona una persona', allowClear: true });
$('select.select-pais-contagio').select2({ width: '80%', placeholder: 'Seleccione un país de contagio', allowClear: true });
$('select.select-confirmacion').select2({ width: '80%', placeholder: 'Seleccione una opción', allowClear: true });
$(document).ready(function() {
  $('.icon-eno').qtip({ content: { text: 'Fecha de primeros síntomas o de primera consulta.' }})
  $('.icon-ges').qtip({ content: { text: 'Parentesco o relación con el paciente.' }})
  $('.icon-int').qtip({ content: { text: 'Parentesco o relación con el paciente.' }})
});