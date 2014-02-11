class PreRolAdministrativos < ActiveRecord::Base

	has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'rol_administrativo_id'

  private
  def app_params
    params.require(:list).permit(:id,
  								:nombre)
  end

end
