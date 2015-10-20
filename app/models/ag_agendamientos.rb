class AgAgendamientos < ActiveRecord::Base

  belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	belongs_to :persona, :class_name => 'PerPersonas'
  belongs_to :quien_pide_hora, :class_name => 'PerPersonas'
	belongs_to :estado, :class_name => 'AgAgendamientoEstados'
  belongs_to :persona_diagnostico_control, :class_name => 'FiPersonaDiagnosticos'
  belongs_to :capitulo_cie10_control, :class_name => 'MedDiagnosticosCapitulos'
  belongs_to :accion_masiva, :class_name => 'AgAccionMasiva'
  has_one :atencion_salud, :class_name => 'FiAtencionesSalud', :foreign_key => 'agendamiento_id'
  has_many :agendamiento_log_estados, :class_name => 'AgAgendamientoLogEstados', :foreign_key => 'agendamiento_id'
  has_many :acciones_masivas, :class_name => 'AgAccionMasiva', :foreign_key => 'agendamiento_id'
  has_one :atencion_pagada, :class_name => 'PreAtencionesPagadas', :foreign_key => 'agendamiento_id'
  
  def month(val)
    if val==1
      "Enero"
    elsif val==2
      "Febrero"
    elsif val==3
      "Marzo"
    elsif val==4
      "Abril"
    elsif val==5
      "Mayo"
    elsif val==6
      "Junio"
    elsif val==7
      "Julio"
    elsif val==8
      "Agosto"
    elsif val==9
      "Septiembre"
    elsif val==10
      "Octubre"
    elsif val==11
      "Noviembre"
    elsif val==12
      "Diciembre"
    end
  end

  def range(val)
    if val=='estimado'
      if fecha_comienzo.strftime('%m%d')==fecha_final.strftime('%m%d')
        "<b>#{fecha_comienzo.strftime('%d')} de #{month(fecha_comienzo.strftime('%m').to_i)}</b> de <b>#{fecha_comienzo.strftime('%H:%M')}</b> a <b>#{fecha_final.strftime('%H:%M')}</b>"
      elsif fecha_comienzo.strftime('%m')==fecha_final.strftime('%m')
        "de <b>#{fecha_comienzo.strftime('%d/%m %H:%M')}</b> a <b>#{fecha_final.strftime('%d/%m %H:%M')}</b>"
      end  
    elsif val=='real'
      if fecha_comienzo_real.strftime('%m%d')==fecha_final_real.strftime('%m%d')
        "El <b>#{fecha_comienzo_real.strftime('%d')} de #{month(fecha_comienzo_real.strftime('%m').to_i)}</b>, de <b>#{fecha_comienzo_real.strftime('%H:%M')}</b> A <b>#{fecha_final_real.strftime('%H:%M')}</b>"
      elsif fecha_comienzo_real.strftime('%m')==fecha_final_real.strftime('%m')
        "de <b>#{fecha_comienzo_real.strftime('%d/%m %H:%M')}</b> a <b>#{fecha_final_real.strftime('%d/%m %H:%M')}</b>"
      end  
    end
  end

  def format
  {
    'id' => id,
    'hora_comienzo' => fecha_comienzo.to_s(:time),
    'estado' => estado.id
  }
  end 

  def event(param_icon)
    description = ''
    custom = ''
    icon = ''
    show = false
    grupo_etareo = ''
    className = 'no_disponible'

    grupo_etareo = persona.getGrupoEtareo(fecha_comienzo) unless ['Hora disponible','Hora bloqueada'].include?(estado.nombre)
    className = 'disponible' if estado.nombre == 'Hora disponible'

    description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
    description<<"</br>Hora: #{range('estimado')}"
    custom<<"<b>"<<estado.nombre<<"</b>"

    if param_icon
      case grupo_etareo
      when 'Recién nacido'
        icon = "/assets/pacifier.png')";      
      when 'Lactante'
        icon = "/assets/bottle.png')";
      when 'Pediatria'
        icon = "/assets/soccer.png";
      when 'Adolescente'
        icon = "/assets/adolescente.png)";
      when 'Adulto'
        icon = "/assets/adulto.png";
      when 'Adulto mayor'
        icon = "/assets/sticky.png";
      end
    end    

    #Este parámetro (show) es para no mostrar algún estado de agendamiento. Hay que modificar la función para que devuelva 'null' en tal caso y para sea leida correctamente en el controlador.
    #Anteriormente se devolvía { } y fallaba.
    show=true 
    if show
      {
        'id'          => id,
        'title'       => '',
        'start'       => fecha_comienzo.strftime("%Y-%m-%d")+"T"+fecha_comienzo.strftime("%H:%M:%S")+".196Z",
        'end'         => fecha_final.strftime("%Y-%m-%d")+"T"+fecha_final.strftime("%H:%M:%S")+".196Z",
        'custom'      => custom,     
        'description' => description,
        'className'   => className,
        'icon'        => icon         
      }    
    end
  end

  def dateTimeFormat(dt,val)
    if val=='extendido' and dt
      dt.strftime('%H:%M del %d') + " de " + month(dt.strftime('%m').to_i) + " de " + dt.strftime('%Y')
    end
  end

  def esProfesionalSalud(usuario_id)
    @prestador_profesional = PrePrestadorProfesionales.find_by profesional_id: usuario_id
  
    if @prestador_profesional
      return true
    else
      return false
    end
  end  


  private
  def app_params
    params.require(:list).permit( :id,
                                  :persona,
                                  :quien_pide_hora,
                                  :fecha_comienzo,
                                  :fecha_final,
                                  :fecha_llegada_paciente,
                                  :fecha_comienzo_real,
                                  :fecha_final_real,                                  
                                  :estado,
                                  :especialidad_prestador_profesional,
                                  :motivo_consulta_nuevo,
                                  :persona_diagnostico_control,
                                  :capitulo_cie10_control,
                                  :atencion_salud,  
                                  :agendamiento_log_estados,
                                  :atenciones_pagadas,
                                  :accion_masiva)
  end

end
