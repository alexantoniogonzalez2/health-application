

$(function(){
$.fn.listClick=function(options){
  $(this).click(function(){
    $(this).parent().parent().parent().prev().val($(this).html());
    $(this).parent().parent().parent().prev().focus();
  });
}

$.fn.autoCompleteSuggestion= function(opt){
  tmp=[];
  $.each($(this).next().find('ul:first li a'),function(indx,val){
    v=$(val).html();
    d=$(val).attr(opt);
    tmp[tmp.length]={value: v, data: d}
  });
  return tmp;
}

$.fn.refreshAutoCompleteSuggestion=function(opt,url,settings){
  d={};
  for(ii=0;ii<settings.identificadores.length;ii++){
    val=settings.identificadores[ii]
    d[val]=$('#'+val).attr(settings.attrFindId);
  }

  if($(this).val()==""){
      $.ajax({
        type:   "POST",
        url:    url,
        data:$.extend({type:   $(opt).attr('id')},d),
        success: function(response){
          $(opt).next().find('ul').first().html(response);
          $(opt).autoCompleteFull($.extend(settings,{def:{value:"",data:""}}));
        }
      })
  }
}

$.fn.autoCompleteFull=function(options){
  
  var settings = $.extend( {}, $.fn.autoCompleteFull.defaults, options );

  $(this).next().find('ul li a').listClick();
  tmp=$(this).autoCompleteSuggestion(settings.attrFindId);
  $(this).autocomplete({
    lookup:tmp.concat(settings.def),
    onSelect: function(r){
      $(this).attr(settings.attrFindId,r.data)
      if(r.data=="-1"){
        $.each($(this).parent().parent().parent().siblings().find('.input-group input'),function(a,b){
          $(b).refreshAutoCompleteSuggestion(b,settings.refreshURL,settings);
        });
        $(this).val('');
        $(this).refreshAutoCompleteSuggestion(this,settings.refreshURL,settings);
        $(this).unbind('keyup');
        $(this).autoCompleteFull($.extend(settings,{def:{value:"",data:""}}));
      }
      else{
        diag = this.value
        diag_id = $(this).attr('data-id')
        $.each($(this).parent().parent().parent().siblings().find('.input-group input'),function(a,b){
          $(b).refreshAutoCompleteSuggestion(b,settings.refreshURL,settings);
        });
        $(this).keyup({original: r.value},function(e){
            if($(this).val().length>e.data.original.length)
                $(this).val(e.data.original);
        });

        // Re-cargamos el evento modificado
        $.ajax({
          type: 'POST',
          url: '/agregar_diagnostico',
          data: {
            persona_id: persona_id,
            diagnostico_id: diag_id,
            atencion_salud_id: atencion_salud_id,
           
          },
          success: function(response) {

            if (response.success)
              $('#diagnostico-div').append('<a href="#" class="list-group-item"><p class="list-group-item-text">'+diag+'</p></a>');
          },
          error: function(xhr, status, error){
            alert("No se pudieron cargar las horas de atención");
          }
        });

      }
      
    }
  });
  return this;
}

$.fn.autoCompleteFull.defaults={
  def: {value:"",data:""},
  refreshURL: "",
  attrFindId: "data-id",
  identificadores: ["diagnostico"]
}

});