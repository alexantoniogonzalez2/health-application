class PerPersonasPrevisionesSalud < ActiveRecord::Base

	self.table_name = "per_personas_previsiones_salud"

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :prevision_salud, :class_name => 'PerPrevisionesSalud'

	private
  def app_params
    params.require(:list).permit(:id,:fecha_inicio,:fecha_termino,:persona,:prevision_salud)
  end

end
