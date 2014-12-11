class FiPersonaActividadFisica < ActiveRecord::Base
	self.table_name = "fi_persona_actividad_fisica"
	belongs_to :persona, :class_name => 'PerPersonas'

	def app_params
    params.require(:list).permit(:id,:persona,:nivel_actividad,:P1,:P2,:P3,:P4,:P5,:P6,:P7,:P8,:P9,:P10,:P11,:P12,:P13,:P14,:P15)
  end
end
