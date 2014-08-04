class PerPersonasTelefonos < ActiveRecord::Base

	belongs_to :telefono, :class_name => 'TraTelefonos'
	belongs_to :persona, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:persona,
    															:telefono)
  end

end
