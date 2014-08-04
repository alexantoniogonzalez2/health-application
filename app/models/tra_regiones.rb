class TraRegiones < ActiveRecord::Base

	has_many :regiones_comunas, :class_name => 'TraRegionesComunas', :foreign_key => 'region_id'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:nombre,
    															:regiones_comunas)
  end

end
