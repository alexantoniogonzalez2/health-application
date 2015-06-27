class FiPersonaDiagnosticos < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'
	belongs_to :estado_diagnostico, :class_name => 'MedDiagnosticoEstados'
	belongs_to :gesta, :class_name => 'FiGestas'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_diagnostico_id' , dependent: :destroy
	has_many :persona_diagnosticos_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud', :foreign_key => 'persona_diagnostico_id', dependent: :destroy 
  has_many :agendamientos_control, :class_name => 'AgAgendamientos', :foreign_key => 'persona_diagnostico_control_id'
  
  def getNotificacion (persona_diagnostico_id)
    notificacion = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is not null',persona_diagnostico_id).order('fecha_notificacion DESC').first;
    
    if notificacion.nil? 
      return nil
    else  
      return notificacion
    end  
  end

  def getInterconsulta (persona_diagnostico_id)
    interconsulta = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is not null',persona_diagnostico_id).order('fecha_solicitud DESC').first;
    if interconsulta.nil?
      return nil
    else 
      return interconsulta
    end  
  end

  def getNotificacionEno (persona_diagnostico_id)
    notificacion_eno = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is not null',persona_diagnostico_id).order('fecha_notificacion DESC').first;
    if notificacion_eno.nil?
      return nil
    else 
      return notificacion_eno
    end  
  end

  def getFechaInicio
    fecha_formato = ''
    if fecha_inicio
      fecha_formato = fecha_inicio.strftime('%Y-%m-%d')
    end
    return fecha_formato  
  end

  def getFechaTermino
    if fecha_termino
      return fecha_termino.strftime('%Y-%m-%d')
    else
      return ''
    end    
  end

  def paraPrestacion (p_p,p_d)
    persona_prestacion_diagnostico = FiPersonaPrestacionDiagnosticos.where('persona_prestacion_id = ? AND persona_diagnostico_atencion_salud_id = ?',p_p,p_d).first
    if persona_prestacion_diagnostico
      return true
    else 
      return false
    end  
  end  

  private
  def app_params
    params.require(:list).permit(:diagnostico,:estado_diagnostico,:fecha_inicio,:fecha_termino,:es_cronica,:gesta,:id,:persona,:persona_diagnosticos_atencion_salud,:persona_medicamentos,:agendamientos_control)
  end        

end
