

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
        $.each($(this).parent().parent().parent().siblings().find('.input-append input'),function(a,b){
          $(b).refreshAutoCompleteSuggestion(b,settings.refreshURL,settings);
        });
        $(this).val('');
        $(this).refreshAutoCompleteSuggestion(this,settings.refreshURL,settings);
        $(this).unbind('keyup');
        $(this).autoCompleteFull($.extend(settings,{def:{value:"",data:""}}));
      }
      else{
        $.each($(this).parent().parent().parent().siblings().find('.input-append input'),function(a,b){
          $(b).refreshAutoCompleteSuggestion(b,settings.refreshURL,settings);
        });
        $(this).next().find('ul').first().html('')
        $(this).next().find('ul').first().append('<li><a data-id="-1">(Borrar)</a></li>');
        op={value:r.value.substring(0,r.value.length-1), data: "-1"}
        $(this).autoCompleteFull($.extend(settings,{def:op}));
        $(this).keyup({original: r.value},function(e){
            if($(this).val().length>e.data.original.length)
                $(this).val(e.data.original);
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
  identificadores: ["especialista","especialidad","prestador"]
}

});
