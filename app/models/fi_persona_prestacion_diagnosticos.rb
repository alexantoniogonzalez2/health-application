class FiPersonaPrestacionDiagnosticos < ActiveRecord::Base

	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'
	belongs_to :persona_prestacion, :class_name => 'FiPersonaPrestaciones'

  private
  def app_params
    params.require(:list).permit(:id,:persona_prestacion,:persona_diagnostico_atencion_salud,:para_interconsulta)
  end
end
