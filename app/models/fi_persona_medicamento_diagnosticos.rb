class FiPersonaMedicamentoDiagnosticos < ActiveRecord::Base

	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'
	belongs_to :persona_medicamento, :class_name => 'FiPersonaMedicamentos'

  private
  def app_params
    params.require(:list).permit(:id,:persona_medicamento,:persona_diagnostico_atencion_salud)
  end
end
