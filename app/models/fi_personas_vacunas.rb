class FiPersonasVacunas < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :vacuna, :class_name => 'MedMedicamentos' 
	
	private
  def app_params
    params.require(:list).permit(:id,:persona,:vacuna)
  end
  
end
