class FiCalendarioVacunas < ActiveRecord::Base

	belongs_to :vacuna, :class_name => 'MedMedicamentos' 
	
	private
  def app_params
    params.require(:list).permit(:id,:vacuna,:edad,:numero_vacuna,:grupo_objetivo,:agno,:protege_contra)
  end
end
