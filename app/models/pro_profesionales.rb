class ProProfesionales < ActiveRecord::Base

	belongs_to :profesional, :class_name => 'PerPersonas'
	belongs_to :especialidad, :class_name => 'ProEspecialidades'
	belongs_to :institucion, :class_name => 'ProInstituciones'

	private
  def app_params
    params.require(:list).permit(:id, 
							  	:validado,
					        :profesional,
			  					:especialidad,
			  					:institucion)
  end
		  					
end
