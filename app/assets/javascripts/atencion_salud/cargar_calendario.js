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
    prevText: 'Anterior',
    nextText: 'Siguiente',
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

