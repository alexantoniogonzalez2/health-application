$(document).ready(function(){

  $("#e1").select2({
    allowClear: true
  });


  $("#e2").select2({
    allowClear: true
  });

  $("#e3").select2({
    allowClear: true
  });

/*$("#form_hora").validate();
var validator = $( "#form_hora" ).validate();
validator.form();*/

$( "#form_hora" ).validate({
  rules: {
    e1: { required: true },
    e2: { required: true },
    e3: { required: true }
  },
  messages: {
        e1: "No se ha seleccionado un recinto de salud.",
        e2: "No se ha seleccionado una especialidad.",
        e3: "No se ha seleccionado un especialista.",
  },
  submitHandler: function(form){
        window.location='/agendamiento/pedirHora'+"/"+$("#e2").select2("val")+"/"+$("#e1").select2("val")+"/"+$("#e3").select2("val");

      }

});
 

 });



/*validationErrorPlacement=function(error, element){
    show=true;
    message='Error: '+$(error).text();
    $.each($('.toast-container .toast-item p'),function(indx,value){
      if($(value).text()==message) show=false;
    });;
    /*if(show)
    $().toastmessage('showToast', {
           text     : message,
           stayTime : 4000,
           position : 'top-left',
           type     : 'error'
        });
  }


	$(function(){

   $.validator.addMethod("hasElection", function(value, element){

      return $(element).attr('data-id') != '-1'
   });

    $('#especialista,#especialidad,#prestador').autoCompleteFull({
      refreshURL: '/aux/buscarHoraFormActualizar'
    });
    // $('#especialidad').autoCompleteFull();
    // $('#prestador').autoCompleteFull();

    $('#formBuscarHora').validate({
      rules: {
        especialidad: {
          hasElection: true
        },
        prestador:{
          hasElection: true
        }
      },
      messages: {
        especialidad: "No se ha seleccionado una especialidad",
        prestador: "No se ha seleccionado un centro médico"
      },
      errorPlacement: validationErrorPlacement,
      submitHandler: function(form){
        window.location='/agendamiento/pedirHora'+"/"+$('#especialidad').attr('data-id')+"/"+$('#prestador').attr('data-id')+"/"+$('#especialista').attr('data-id');

      }
    })

  })

*/