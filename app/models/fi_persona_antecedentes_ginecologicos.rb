class FiPersonaAntecedentesGinecologicos < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	def app_params
    params.require(:list).permit(:id,:persona,:fecha_menarquia,:fecha_menopausia,:duracion_menstruacion,:frecuencia_promedio,:fecha_ultimo_PAP,:fecha_ultima_mamografia,:numero_gestaciones,:numero_partos,:numero_abortos)
  end
end
