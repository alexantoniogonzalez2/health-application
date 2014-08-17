class MedProblemasSaludAuge < ActiveRecord::Base

	self.table_name = "med_problemas_salud_auge"
	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:diagnostico,:edad_desde,:edad_hasta,:genero,:prioridad,:fecha_inicio_auge)
  end
  
end
