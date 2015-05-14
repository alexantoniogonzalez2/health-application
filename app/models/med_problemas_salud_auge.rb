class MedProblemasSaludAuge < ActiveRecord::Base

	self.table_name = "med_problemas_salud_auge"	
	has_many :problemas_salud_auge_diagnosticos, :class_name => 'MedProblemasSaludAugeDiagnosticos', :foreign_key => 'problema_salud_auge_id'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:edad_desde,:edad_hasta,:fecha_inicio_auge,:problemas_salud_auge_diagnosticos)
  end
  
end
