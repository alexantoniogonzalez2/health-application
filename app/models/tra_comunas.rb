class TraComunas < ActiveRecord::Base

	has_many :direcciones, :class_name => 'TraDirecciones', :foreign_key => 'comuna_id'
	has_many :regiones_comunas, :class_name => 'TraRegionesComunas', :foreign_key => 'comuna_id'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:nombre,
    															:regiones_comunas)
  end

end
