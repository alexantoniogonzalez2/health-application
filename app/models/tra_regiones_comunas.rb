class TraRegionesComunas < ActiveRecord::Base

	belongs_to :region, :class_name => 'TraRegion'
	belongs_to :comuna, :class_name => 'TraComuna'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:region,
    															:comuna)
  end

end
