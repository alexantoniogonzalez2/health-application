class ProEspecialidades < ActiveRecord::Base

	has_many :profesionales, :class_name => 'ProProfesionales', :foreign_key => 'especialidad_id'
	has_many :prestadores, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'especialidad_id'

  private
  def app_params
    params.require(:list).permit(:id, 
  								:nombre,
  								:profesionales)
  end
									
end
