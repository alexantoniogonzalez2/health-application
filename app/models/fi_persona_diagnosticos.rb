class FiPersonaDiagnosticos < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'
	belongs_to :estado_diagnostico, :class_name => 'MedDiagnosticoEstados'
	belongs_to :gesta, :class_name => 'FiGestas'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_diagnostico_id' 
	has_many :persona_diagnosticos_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud', :foreign_key => 'persona_diagnostico_id', dependent: :destroy 

  def getFechaInicio
    return fecha_inicio.strftime('%Y-%m-%d')
  end

  def getFechaTermino
    if fecha_termino
      return fecha_termino.strftime('%Y-%m-%d')
    else
      return ''
    end    
  end

  private
  def app_params
    params.require(:list).permit(:diagnostico,
                   :estado_diagnostico,
                   :fecha_inicio,
                   :fecha_termino,
                   :gesta,
                   :id,
                   :persona,
                   :persona_diagnosticos_atencion_salud,
                   :persona_medicamentos)
  end        

end
