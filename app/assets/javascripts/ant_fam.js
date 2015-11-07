$('input[id^=fecha]').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD',
    viewMode: 'years',
});

function getFrecuente(){
  var modal =  $("#search-modal").find(".in");
  var check = $('#no-frec-ant-fam-'+modal.attr('id').substring(24))
  return check.is(':checked');
}

$('.select_diag').select2({
  allowClear: true,
  width: '60%',
  minimumInputLength: 3,
  placeholder: "Selecciona un diagnóstico",
  ajax: {
    url: '/cargar_diagnosticos',
    dataType: 'json',
    type: 'POST',
    data: function (params) {  
      return { q: params.term, diag_no_frec: getFrecuente() };
    },
    processResults: function (data, page) { return { results: data }; }
  }
});

