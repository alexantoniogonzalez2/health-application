class AgAgendamientos < ActiveRecord::Base

	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :agendamiento_estado, :class_name => 'AgAgendamientoEstados'
  has_one :atencion_salud, :class_name => 'FiAtencionesSalud', :foreign_key => 'agendamiento_id'
  has_many :agendamiento_logs, :class_name => 'AgAgendamientoLogEstados', :foreign_key => 'agendamiento_id'


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
    description= ''
    custom=''
    show=false
    if agendamiento_estado.nombre == 'Hora disponible'
        className = 'disponible'
        custom<< "<b>Hora disponible</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
      
    elsif agendamiento_estado.nombre == 'Hora bloqueada'
        className = 'no_disponible'
        custom<< "<b>Hora no disponible</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: <s>#{range('estimado')}</s>"
        show=true
    elsif agendamiento_estado.nombre == 'Hora reservada'
        className = 'no_disponible'
        custom<< "<b>Hora reservada</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true  
    elsif agendamiento_estado.nombre == 'Hora confirmada' 
        className = 'no_disponible'
        custom<< "<b>Hora confirmada</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true         
    elsif agendamiento_estado.nombre == 'Paciente en espera'
        className = 'no_disponible'
        custom<< "<b>Paciente en espera</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true
    elsif agendamiento_estado.nombre == 'Paciente siendo atendido'
        className = 'no_disponible'
        custom<< "<b>Paciente siendo atendido</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
        description<<"</br>Hora: #{range('estimado')}"
        show=true    
    elsif agendamiento_estado.nombre == 'Paciente atendido'
        className = 'no_disponible'
        custom<< "<b>Paciente atendido</b>"
        description<<"Especialista: <b>#{especialidad_prestador_profesional.profesional.showName('%d%n%p')}</b>"
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
        'custom'       => custom,     
        'description' => description,
        'className'   => className
        
      }
    else
      {}
    end


  end

  def dateTimeFormat(dt,val)
    if val=='extendido' and dt
      dt.strftime('%H:%M del %d') + " de " + month(dt.strftime('%m').to_i) + " de " + dt.strftime('%Y')
    end
  end




  def detalleHTML(perm_admin_genera,perm_admin_confirma,perm_admin_recibe,perm_admin_bloquea,perm_paciente,perm_profesional) #los parámetros corresponden a permisos

    show=false
    detalle = ''
    detalle2 = ''
    tomar_hora =''
    reabrir =''
    bloquear = ''
    paciente = ''
    llegada_paciente =''
    confirmar =''
    cancelar =''
    hora_llegada =''
    hora_inicio_atencion =''
    hora_termino_atencion =''
    estado = agendamiento_estado.nombre

    detalle<<'<div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>' 

    detalle<<"<h4 class='modal-title' id='myModalLabel'>"<<estado<<"</h4> </div>
              <div class='modal-body'><table>
              <tr><td><h5>Recinto de salud</h5></td><td>: #{especialidad_prestador_profesional.prestador.nombre}</td></tr>
              <tr><td><h5>Especialidad</h5></td><td>: #{especialidad_prestador_profesional.especialidad.nombre}</td></tr>
              <tr><td><h5>Especialista</h5></td><td>: #{especialidad_prestador_profesional.profesional.showName('%d%n%p%m')}</td></tr>
              <tr><td><h5>Fecha y hora de inicio</h5></td><td>: #{dateTimeFormat(fecha_comienzo,'extendido')}</td></tr>
              <tr><td><h5>Fecha y hora de término</h5></td><td>: #{dateTimeFormat(fecha_final,'extendido')}</td></tr>"

    #los elementos se configuran si se cumplen los permisos                
    if perm_admin_bloquea or perm_profesional
      reabrir = "<button class='btn btn-primary desbloquear-hora'>Desbloquear Hora</button>"
    end  
    if (perm_admin_bloquea or perm_profesional) and (estado == 'Hora disponible')
      bloquear =  "<button class='btn btn-primary bloquear-hora'>Bloquear hora</button>"
    end  
    if !perm_admin_genera and !perm_admin_confirma and !perm_admin_recibe and !perm_profesional
       tomar_hora = "<button class='btn btn-primary pedir-hora'>Tomar hora</button>"
    end   
    if perm_admin_genera or perm_admin_confirma or perm_admin_recibe or perm_paciente  
      if estado != 'Hora disponible' and estado != 'Hora bloqueada'     
      paciente<<"<tr><td><h5>Paciente</h5></td><td>: #{persona.showName('%n%p%m')}</td></tr>"
      end
    end 
    if perm_admin_recibe 
      llegada_paciente<<"<button class='btn btn-primary marcar-llegada'>Marcar llegada del paciente</button>"  
    end                  
    if perm_admin_confirma or perm_paciente
      confirmar<<"<button class='btn btn-primary confirmar-hora'>Confirmar hora</button>"  
    end 
    if perm_admin_confirma or perm_paciente  
      cancelar<<"<button class='btn btn-primary cancelar-hora'>Cancelar hora</button>" 
    end
    if perm_admin_genera or perm_admin_confirma or perm_admin_recibe or perm_paciente or perm_profesional
      if estado == 'Paciente en espera' or estado == 'Paciente atendido'            
        hora_llegada = "<tr><td><h5>Fecha y hora de llegada paciente</h5></td><td>:  #{dateTimeFormat(fecha_llegada_paciente,'extendido')}</td></tr>"
      end         
    end
    if perm_admin_genera or perm_admin_confirma or perm_admin_recibe or perm_paciente or perm_profesional 
      if estado == 'Paciente atendido'         
        hora_inicio_atencion = "<tr><td><h5>Fecha y hora de inicio atención</h5></td><td>: #{dateTimeFormat(fecha_comienzo_real,'extendido')}</td></tr>"
        hora_termino_atencion = "<tr><td><h5>Fecha y hora de término atención</h5></td><td>: #{dateTimeFormat(fecha_final_real,'extendido')}</td></tr>" 
      end  
    end      
      
    case estado
      when 'Hora disponible'
        detalle<<'</table></div><div class="modal-footer">'<<tomar_hora<<bloquear
      when 'Hora bloqueada'        
        detalle<<'</table></div><div class="modal-footer">'<<reabrir
      when 'Hora reservada' 
        detalle<<paciente<<'</table></div><div class="modal-footer">'<<llegada_paciente<<confirmar<<cancelar
      when 'Hora confirmada' 
        detalle<<paciente<<'</table></div><div class="modal-footer">'<<llegada_paciente<<cancelar                             
      when 'Paciente en espera'  
        detalle<<paciente<<hora_llegada<<'</table></div><div class="modal-footer">'
      when 'Paciente atendido'  
        detalle<<paciente<<hora_llegada<<hora_inicio_atencion<<hora_termino_atencion<<'</table></div><div class="modal-footer">' 
       when 'Paciente siendo atendido'  
        detalle<<'</table></div><div class="modal-footer">'                                 
    end                

    detalle<<'<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar ventana</button></div>'           
    
    detalle
  
  end


  private
  def app_params
    params.require(:list).permit( :atencion_medica,
                                  :agendamiento_estado,
                                  :agendamiento_logs,
                                  :fecha_comienzo, 
                                  :fecha_comienzo_real, 
                                  :fecha_final, 
                                  :fecha_final_real, 
                                  :fecha_llegada_paciente,
                                  :id,
                                  :persona)
  end

end
