class ProInstituciones < ActiveRecord::Base

	has_many :profesionales, :class_name => 'ProProfesionales', :foreign_key => 'institucion_id'

	private
  def app_params
    params.require(:list).permit(:id, 
									:nombre,
									:profesionales)
  end
								
end
