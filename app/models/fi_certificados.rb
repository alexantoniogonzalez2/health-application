class FiCertificados < ActiveRecord::Base
	
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  has_many :certificado_diagnosticos, :class_name => 'FiCertificadoDiagnosticos', :foreign_key => 'certificado_id'

  private
  def app_params
    params.require(:list).permit(:id,:tipo_reposo,:dias_reposo,:control,:alta,:atencion_salud,:para_trabajo,:para_colegio,:para_juzgado,:para_carabinero,:para_otros,:certificado_diagnosticos)
  end
								
end
