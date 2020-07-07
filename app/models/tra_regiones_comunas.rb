class TraRegionesComunas < ActiveRecord::Base

	belongs_to :region, :class_name => 'TraRegiones'
	belongs_to :comuna, :class_name => 'TraComunas'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:region,
    															:comuna)
  end

end
