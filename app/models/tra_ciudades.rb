class TraCiudades < ActiveRecord::Base

	has_many :direcciones, :class_name => 'TraDirecciones', :foreign_key => 'ciudad_id'

	private
  def app_params
    params.require(:list).permit(
    															:id, 
																	:nombre,
																	:direcciones)
  end

end
