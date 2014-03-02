class FiPersonaDiagnosticos < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'
	belongs_to :diagnostico_estado, :class_name => 'MedDiagnosticoEstados'
	belongs_to :gesta, :class_name => 'FiGestas'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_diagnostico_id' 
	has_many :persona_diagnosticos_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud', :foreign_key => 'persona_diagnostico_id' 
 
  private
  def app_params
    params.require(:list).permit(:diagnostico,
                   :diagnostico_estado,
                   :fecha_inicio,
                   :fecha_termino,
                   :gesta,
                   :id,
                   :persona,
                   :persona_diagnosticos_atencion_salud,
                   :persona_medicamentos)
  end        

end
