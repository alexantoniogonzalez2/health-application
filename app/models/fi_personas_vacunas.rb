class FiPersonasVacunas < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :vacuna, :class_name => 'MedVacunas'
	has_one :persona_medicamento, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_vacuna_id'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	
	private
  def app_params
    params.require(:list).permit(:id,:persona,:vacuna,:fecha,:numero_vacuna,:atencion_salud,:persona_medicamento)
  end
  
end
