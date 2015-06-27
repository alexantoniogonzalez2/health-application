$(function() {

  $('.panel_interconsulta').bind('click', function (e) {
    
    var id = $(this).attr('id');      
    p_d = id.substring(9);

    $('#int_diag'+p_d).empty();
    $.ajax({
      type: 'POST',
      url: '/agregar_pres_int',
      data: { p_d: p_d },
      success: function(response) { },
      error: function(xhr, status, error){ }
    });
    
  });
});