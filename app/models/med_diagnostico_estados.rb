class MedDiagnosticoEstados < ActiveRecord::Base
	has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'estado_diagnostico_id'
  has_many :persona_diagnosticos_atencion_medica, :class_name => 'FiPersonaDiagnosticosAtencionesMedica', :foreign_key => 'estado_diagnostico_id'
  has_many :reabrir_estado_diagnostico, :class_name => 'FiReabrirEstadoDiagnostico', :foreign_key => 'estado_diagnostico_id'
  private
  def app_params
    params.require(:list).permit(:id,
  								:persona_diagnosticos,
  								:persona_diagnosticos_atencion_medica,
  							  :nombre,
                  :reabrir_estado_diagnostico)
  end
							  
  							  
end
