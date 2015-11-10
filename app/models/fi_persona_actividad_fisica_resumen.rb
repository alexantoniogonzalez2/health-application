class FiPersonaActividadFisicaResumen < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'

	def app_params
    params.require(:list).permit(:id,:persona,:frecuencia,:tiempo,:intensidad)
  end
end
