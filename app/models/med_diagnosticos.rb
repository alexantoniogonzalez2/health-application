class MedDiagnosticos < ActiveRecord::Base
	has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'diagnostico_id'
  

  private
  def app_params
    params.require(:list).permit(:codigo_cie10,
  							  :descripcion,
  							  :id,
  							  :nombre,
  							  :persona_diagnosticos )
  end
							  
end
