class FiCertificadoDiagnosticos < ActiveRecord::Base

	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'
	belongs_to :certificado, :class_name => 'FiCertificados'

  private
  def app_params
    params.require(:list).permit(:id,:certificado,:persona_diagnostico_atencion_salud)
  end
end
