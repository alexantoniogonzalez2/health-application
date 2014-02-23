class AgAgendamientos < ActiveRecord::Base
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :admin_genera, :class_name => 'PerPersonas'
  belongs_to :admin_confirma, :class_name => 'PerPersonas'
  belongs_to :admin_recibe, :class_name => 'PerPersonas'
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
      
    elsif agendamiento_estado.nombre == 'Hora no disponible'
        color='#D86C64'
        description<< "<u><b>Hora no disponible</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: <s>#{range('estimado')}</s>"
        show=true
    elsif agendamiento_estado.nombre == 'Hora reservada' or agendamiento_estado.nombre == 'Hora confirmada' 
        description<< "<u><b>Hora reservada</b></u>"
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
      
    elsif agendamiento_estado.nombre == 'Paciente en espera'
        #if permiso.split(':')[1]=='Paciente'
          description<< "<u><b>Hora reservada</b></u>"
        #else
          color='#21CAA8'
          description<< "<u><b>Paciente en espera</b></u>"
        #end
        description<<"</br>Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Paciente atendido'
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




  def detalleHTML

    show=false
    detalle = ''
    detalle_comun = ''
    detalle_especifico = ''
    estado = agendamiento_estado.nombre

    detalle_comun<<"<h3>"<<estado<<"</h3>
                    <table>
                    <tr><td><h5>Recinto de salud</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>
                    <tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>
                    <tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>
                    <tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>
                    <tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"

    case estado
      when 'Hora disponible'
        detalle_especifico<<"</table><button class='btn btn-primary pedir-hora'>Tomar hora</button>"
      when 'Hora no disponible'        
        detalle_especifico<<"</table><button class='btn btn-primary'>Re-Abrir</button>Tomar hora</button>"
      when 'Hora reservada' 

        detalle_especifico<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr></table>
                             <button class='btn btn-primary'>Marcar llegada del paciente</button>
                             <button class='btn btn-primary'>Confirmar hora</button>
                             <button class='btn btn-primary'>Cancelar hora</button>" 
      when 'Hora confirmada' 
        detalle_especifico<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr></table>
                             <button class='btn btn-primary'>Marcar llegada del paciente</button>
                             <button class='btn btn-primary'>Cancelar hora</button>" 
      when 'Paciente en espera'  
        detalle_especifico<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>
                             <tr><td><h5>Fecha y hora de llegada paciente</h5></td><td>:</td></tr></table>"
      when 'Paciente atendido'  
        detalle_especifico<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>
                             <tr><td><h5>Fecha y hora de llegada paciente</h5></td><td>:</td></tr>
                             <tr><td><h5>Fecha y hora de inicio atención</h5></td><td>: #{dateTimeFormat(fecha_comienzo_real,'extendido')}</td></tr>
                             <tr><td><h5>Fecha y hora de término atención</h5></td><td>: #{dateTimeFormat(fecha_final_real,'extendido')}</td></tr></table>"    
    end                

    detalle<<detalle_comun<<detalle_especifico<<"<button class='btn btn-primary simplemodal-close'>Cerrar</button>"     
    
    detalle
  
  end

  private
  def app_params
    params.require(:list).permit( :admin_genera,
                                  :admin_confirma,
                                  :admin_recibe,
                                  :atencion_medica,
                                  :agendamiento_estado,
                                  :fecha_comienzo, 
                                  :fecha_comienzo_real, 
                                  :fecha_final, 
                                  :fecha_final_real, 
                                  :fecha_llegada_paciente,
                                  :id,
                                  :persona)
  end

end
