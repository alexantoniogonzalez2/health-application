class ProProfesionales < ActiveRecord::Base

	belongs_to :profesional, :class_name => 'PerPersonas'
	belongs_to :especialidad, :class_name => 'ProEspecialidades'
	belongs_to :institucion, :class_name => 'ProInstituciones'
	has_many :profesionales, :class_name => 'PreBoletas', :foreign_key => 'profesional_id'


	private
  def app_params
    params.require(:list).permit(:id, 
							  	:validado,
					        :profesional,
			  					:especialidad,
			  					:institucion,
			  					:profesionales)
  end
		  					
end
