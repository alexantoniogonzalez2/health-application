class FiPersonaMedicamentos < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :medicamento, :class_name => 'MedMedicamentos'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  belongs_to :persona_vacuna, :class_name => 'FiPersonasVacunas'  
  has_many :persona_medicamento_diagnosticos, :class_name => 'FiPersonaMedicamentoDiagnosticos', :foreign_key => 'persona_medicamento_id'

  def getViaAdministracion
    respuesta = ''
    respuesta = 'Vía de administración: ' unless via_administracion.nil?
    case via_administracion
    when 1 then respuesta<<'Oral'
    when 2 then respuesta<<'Endovenoso'
    when 3 then respuesta<<'Rectal'
    when 4 then respuesta<<'Vaginal'
    when 5 then respuesta<<'Subcutánea'
    when 6 then respuesta<<'Tópico'
    end  

    return respuesta
  end  
  
  def getPosologia
    posologia = '-'
    if cantidad and periodicidad and duracion and [1,2,3,4].include? medicamento.medicamento_tipo.id 
      unidad = medicamento.medicamento_tipo.unidad.to_s
      posologia = cantidad.to_s<<' '<<unidad<<' cada '<<periodicidad.to_s<<' horas durante '<<duracion.to_s<<' día(s). Total: '<<total.to_s<<' '<<unidad
      if medicamento.medicamento_tipo.id == 4
        posologia<<' ('<<(total/20).to_s<<' ml)' 
      end
      posologia<<'. ' 
    end  
    return posologia
  end

  def editarEnReabrir
    respuesta = true
    fecha_comienzo = atencion_salud.agendamiento.fecha_comienzo_real
    fecha_final = atencion_salud.agendamiento.fecha_final_real
    respuesta = false if created_at > fecha_comienzo and created_at < fecha_final
    return respuesta
  end  

  def getDiagnosticos
    diagnosticos = []
    persona_medicamento_diagnosticos.each do |p_m_d|
      diagnosticos << p_m_d.persona_diagnostico_atencion_salud.persona_diagnostico.diagnostico.nombre
    end
    diagnosticos.any? ? diagnosticos.join(' | ') : '-'
  end  
  
  private
  def app_params
    params.require(:list).permit(:id,:persona,:medicamento,:persona_vacuna,:fecha_final,:fecha_inicio,:atencion_salud,:cantidad,:periodicidad,:duracion,:total,:es_antecedente,:indicacion,:via_administracion,:persona_medicamento_diagnosticos,:created_at)
  end
end
