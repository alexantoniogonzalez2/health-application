class AgAgendamientos < ActiveRecord::Base
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :administrativo, :class_name => 'PerPersonas'
	belongs_to :agendamiento_estado, :class_name => 'AgAgendamientoEstados'
  has_one :atencion_salud, :class_name => 'FiAtencionesSalud', :foreign_key => 'agendamiento_id'

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

  def event(permiso)
    color = '#07157E'
    description= ''
    show=false
    if agendamiento_estado.nombre == 'Disponible'
        color = '#DED335'
        description<< "<u><b>Hora disponible</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
      
    elsif agendamiento_estado.nombre == 'No Disponible'
        color='#D86C64'
        description<< "<u><b>Hora cancelada</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: <s>#{range('estimado')}</s>"
        show=true
    elsif agendamiento_estado.nombre == 'Hora Reservada'
        description<< "<u><b>Hora reservada</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
      
    elsif agendamiento_estado.nombre == 'Cliente En Espera'
        #if permiso.split(':')[1]=='Paciente'
          description<< "<u><b>Hora reservada</b></u>"
        #else
          color='#21CAA8'
          description<< "<u><b>Paciente en espera a ser atendido</b></u>"
        #end
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Cliente Atendido'
        #if permiso.split(':')[1]=='Paciente'
          description<< "<u><b>Hora reservada</b></u>"
        #else
          color='#28DC52'
          description<< "<u><b>Paciente atendido</b></u>"
        #end
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




  def detalleHTML(permiso,user_persona_id)
    ret=''
    show=false
    if agendamiento_estado.nombre == 'Disponible'
      if permiso[1]=='1'
        ret<<"<h3>Hora Disponible</h3>"
        ret<<"<table>"
        if permiso[2]=='1'
          ret<<"<tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>"
        end
        if permiso[3]=='1'
          ret<<"<tr><td><h5>Recinto</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>"
        end
        if permiso[4]=='1'
          ret<<"<tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>"
        end
        if permiso[5]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>"
        end
        if permiso[6]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"
        end
        ret<<"</table>"
        if permiso[7]=='1' and user_persona_id != especialidad_prestador_profesional.profesional.id #el profesional no puede tomar una hora consigo mismo
          ret<<"<button class='btn btn-primary pedir-hora'>Pedir hora</button>"
        end
        if permiso[8]=='1'
          ret<<"<button class='btn btn-primary'>Pedir hora a otro</button>"# Agregar cosas para "pedir hora a otro"
        end
        if permiso[9]=='1'
          ret<<"<button class='btn btn-primary'>Cancelar hora</button>"# Agregar cosas para cancelar hora
        end
      end

    elsif agendamiento_estado.nombre == 'No Disponible'
      if permiso[1]=='1'
          ret<<"<h3>Hora Cancelada o No Disponible</h3>"
          ret<<"<table>"
        if permiso[2]=='1'
          ret<<"<tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>"
        end
        if permiso[3]=='1'
          ret<<"<tr><td><h5>Recinto</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>"
        end
        if permiso[4]=='1'
          ret<<"<tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>"
        end
        if permiso[5]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>"
        end
        if permiso[6]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"
        end
          ret<<"</table>"
        if permiso[7]=='1'
          ret<<"<button class='btn btn-primary'>Re-Abrir</button>"# Agregar botón para cancelar la cancelación...
        end
      end

    elsif agendamiento_estado.nombre == 'Hora Reservada'
      if permiso[1]=='1'
        ret<<"<h3>Hora Reservada</h3>"
        ret<<"<table>"
        if permiso[2]=='1'
          ret<<"<tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>"
        end
        if permiso[3]=='1'
          ret<<"<tr><td><h5>Recinto</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>"
        end
        if permiso[4]=='1'
          ret<<"<tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>"
        end
        if permiso[5]=='1'
          if permiso.split(':')[1] == 'Funcionario' or (permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id)
            ret<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>"
          end
        end
        if permiso[6]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>"
        end
        if permiso[7]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"
        end
        ret<<"</table>"
        if permiso[8]=='1'
          if permiso.split(':')[1] == 'Funcionario' or (permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id)
            ret<<"<button class='btn btn-primary'>Cancelar reserva</button>"# Agregar botón para cancelar hora
          end
        end
        if permiso[9]=='1'
          if permiso.split(':')[1] == 'Funcionario'
            ret<<"<button class='btn btn-primary'>Marcar llegada Paciente</button>"# Agregar botón para marcar llegada del paciente
          end
        end
        
      end

    elsif agendamiento_estado.nombre == 'Cliente En Espera'
      if permiso[1]=='1'
        if permiso.split(':')[1] == 'Funcionario'
          ret<<"<h3>Paciente en espera a ser atendido</h3>"
        elsif permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id
          ret<<"<h3>Hora Reservada (Check-in Realizado)</h3>"
        elsif permiso.split(':')[1] == 'Paciente'
          ret<<"<h3>Hora Reservada</h3>"
        end          
        ret<<"<table>"
        if permiso[2]=='1'
          ret<<"<tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>"
        end     
        if permiso[3]=='1'
          ret<<"<tr><td><h5>Recinto</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>"
        end     
        if permiso[4]=='1'
          ret<<"<tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>"
        end          
        if permiso[5]=='1'
          if permiso.split(':')[1] == 'Funcionario' or (permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id)
            ret<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>"
          end
        end          
        if permiso[6]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>"
        end          
        if permiso[7]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"
        end          
        if permiso[8]=='1'
          ret<<"<tr><td><h5>Fecha y hora de llegada paciente</h5></td><td>: &lt;&lt;Aquí la hora&gt;&gt;</td></tr>"
        end          
        ret<<"</table>"
        if permiso[9]=='1'
          if permiso.split(':')[1] == 'Funcionario'
            ret<<"<button class='btn btn-primary'>Marcar-Llegada</button>"# Agregar botón para marcar llegada de paciente
          end
        end
      end

    elsif agendamiento_estado.nombre == 'Cliente Atendido'
      if permiso[1]=='1'
        if permiso.split(':')[1] == 'Funcionario'
          ret<<"<h3>Paciente atendido</h3>"
        elsif permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id
          ret<<"<h3>Hora Reservada (Atención realizada)</h3>"
        elsif permiso.split(':')[1] == 'Paciente'
          ret<<"<h3>Hora Reservada</h3>"
        end 
        ret<<"<table>"
        if permiso[2]=='1'
          ret<<"<tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>"
        end 
        if permiso[3]=='1'
          ret<<"<tr><td><h5>Recinto</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>"
        end
        if permiso[4]=='1'
          ret<<"<tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>"
        end 
        if permiso[5]=='1'
          if permiso.split(':')[1] == 'Funcionario' or (permiso.split(':')[1] == 'Paciente' and user_persona_id == persona.id)
            ret<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>"
          end
        end 
        if permiso[6]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio reservada</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>"
        end 
        if permiso[7]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término reservada</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"
        end 
        if permiso[8]=='1'
          ret<<"<tr><td><h5>Fecha y hora de llegada paciente</h5></td><td>: &lt;&lt;Aquí la hora&gt;&gt;</td></tr>"
        end 
        if permiso[9]=='1'
          ret<<"<tr><td><h5>Fecha y hora de inicio atención</h5></td><td>: #{dateTimeFormat(fecha_comienzo_real,'extendido')}</td></tr>"
        end 
        if permiso[10]=='1'
          ret<<"<tr><td><h5>Fecha y hora de término atención</h5></td><td>: #{dateTimeFormat(fecha_final_real,'extendido')}</td></tr>"
        end 
        ret<<"</table>"
      end
    end
    ret
  end

  private
  def app_params
    params.require(:list).permit(:administrativo,
                  :atencion_medica,
                  :agendamiento_estado,
                  :fecha_comienzo, 
                  :fecha_comienzo_real, 
                  :fecha_final, 
                  :fecha_final_real, 
                  :id,
                  :persona)
  end

end
