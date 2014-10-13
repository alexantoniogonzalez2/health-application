class PerPrevisionesSalud < ActiveRecord::Base

	self.table_name = "per_previsiones_salud"
	has_many :personas_previsiones_salud, :class_name => 'PerPersonasPrevisionesSalud', :foreign_key => 'prevision_salud_id'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:personas_previsiones_salud)
  end

end
