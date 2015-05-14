class MedProblemasSaludAugeDiagnosticos < ActiveRecord::Base

	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'
	belongs_to :problema_salud_auge, :class_name => 'MedProblemasSaludAuge'

	private
  def app_params
    params.require(:list).permit(:id,:problema_salud_auge,:diagnostico,:prioridad)
  end

end
