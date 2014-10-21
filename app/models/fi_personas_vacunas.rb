class FiPersonasVacunas < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :vacuna, :class_name => 'MedVacunas'
	has_one :persona_medicamento, :class_name => 'FiPersonaMedicamentos' 
	
	private
  def app_params
    params.require(:list).permit(:id,:persona,:vacuna,:persona_medicamento)
  end
  
end
