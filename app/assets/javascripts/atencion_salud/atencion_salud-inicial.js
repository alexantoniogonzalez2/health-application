

validationErrorPlacement=function(error, element){
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
        });*/
  }


	$(function(){

   $.validator.addMethod("hasElection", function(value, element){

      return $(element).attr('data-id') != '-1'
   });

    $('#diagnostico').autoCompleteFull({
      
    });

/*
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
    })*/

  })

function eliminarDiagnostico(pers_diag)
{
  //var element = document.getElementById('pd'+pers_diag);
 
  //element.parentNode.removeChild(element);
  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: {
      persona_diagnostico_id: pers_diag,
        
    },
    success: function(response) {

       $( "#pd"+pers_diag).remove();
    },
    error: function(xhr, status, error){

    }
  });

}

