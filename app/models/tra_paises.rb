class TraPaises < ActiveRecord::Base

	has_many :direcciones, :class_name => 'TraDirecciones', :foreign_key => 'pais_id'

	private
  def app_params
    params.require(:list).permit(
    															:id, 
    															:nombre,
    															:direcciones)
  end

end
