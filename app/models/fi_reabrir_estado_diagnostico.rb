class FiReabrirEstadoDiagnostico < ActiveRecord::Base

	self.table_name = "fi_reabrir_estado_diagnostico"
	belongs_to :estado_diagnostico, :class_name => 'MedDiagnosticoEstados'
	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'

	private
  def app_params
    params.require(:list).permit(:fecha_cambio,:estado_diagnostico,:persona_diagnostico_atencion_salud)
  end
end
