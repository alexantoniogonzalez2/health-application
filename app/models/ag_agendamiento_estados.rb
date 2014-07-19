class AgAgendamientoEstados < ActiveRecord::Base
	
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'agendamiento_estado_id'
  has_many :agendamiento_log_estados, :class_name => 'AgAgendamientoLogEstados', :foreign_key => 'agendamiento_estado_id'

	private
  def app_params
    params.require(:list).permit(:id, :nombre,:agendamientos,:agendamiento_log_estados)
  end
 	
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
        "El <b>#{fecha_comienzo.strftime('%d')} de #{month(fecha_comienzo.strftime('%m').to_i)}</b>, De <b>#{fecha_comienzo.strftime('%H:%M')}</b> A <b>#{fecha_final.strftime('%H:%M')}</b>"
      elsif fecha_comienzo.strftime('%m')==fecha_final.strftime('%m')
        "De <b>#{fecha_comienzo.strftime('%d/%m %H:%M')}</b> A <b>#{fecha_final.strftime('%d/%m %H:%M')}</b>"
      end  
    elsif val=='real'
      if fecha_comienzo_real.strftime('%m%d')==fecha_final_real.strftime('%m%d')
        "El <b>#{fecha_comienzo_real.strftime('%d')} de #{month(fecha_comienzo_real.strftime('%m').to_i)}</b>, De <b>#{fecha_comienzo_real.strftime('%H:%M')}</b> A <b>#{fecha_final_real.strftime('%H:%M')}</b>"
      elsif fecha_comienzo_real.strftime('%m')==fecha_final_real.strftime('%m')
        "De <b>#{fecha_comienzo_real.strftime('%d/%m %H:%M')}</b> A <b>#{fecha_final_real.strftime('%d/%m %H:%M')}</b>"
      end  
    end
  end

  def event
    color = '#07157E'
    description= ''
    show=false
    if agendamiento_estado.nombre == 'Hora disponible'
        color = '#DED335'
        description<< "<u><b>Hora disponible</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Hora bloqueada'
        color='#D86C64'
        description<< "<u><b>Hora bloqueada</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: <s>#{range('estimado')}</s>"
        show=true
    elsif agendamiento_estado.nombre == 'Hora reservada'
        description<< "<u><b>Hora reservada</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Paciente en espera'
        color='#21CAA8'
        description<< "<u><b>Paciente en espera a ser atendido</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Cliente atendido'
        color='#28DC52'
        description<< "<u><b>Paciente atendido</b></u>"        
      	description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
      	description<<"</br>Hora: #{range('estimado')}"
        show=true
      
    end


    if show
      {
        'id'          => id,
        'title'       => '',
        'start'       => fecha_comienzo.strftime("%Y-%m-%d %H:%M")+":00.0",
        'end'         => fecha_final.strftime("%Y-%m-%d %H:%M")+":00.0",
        'allDay'      => false,
        'color'       => color,
        'textColor'   => '#FFFFFF',
        'description' => description,
      }
    else
      {}
    end


  end

  def dateTimeFormat(dt,val)
    if val=='extendido'
      dt.strftime('%H:%M del %d') + " de " + month(dt.strftime('%m').to_i) + " de " + dt.strftime('%Y')
    end
  end


end
