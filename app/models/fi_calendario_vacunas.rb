class FiCalendarioVacunas < ActiveRecord::Base

	belongs_to :vacuna, :class_name => 'MedVacunas' 
	
	private
  def app_params
    params.require(:list).permit(:id,:vacuna,:edad,:numero_vacuna,:agno)
  end
end
