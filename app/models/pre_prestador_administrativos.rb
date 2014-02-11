class PrePrestadorAdministrativos < ActiveRecord::Base

	belongs_to :prestador, :class_name => 'PrePrestadores'
	belongs_to :administrativo, :class_name => 'PerPersonas'
	belongs_to :rol_administrativo, :class_name => 'PreRolAdministrativos'

 	private
  def app_params
    params.require(:list).permit(:id,
			  					:prestador,
			  					:administrativo,
			  					:rol_administrativo)
  end
		  					
end
