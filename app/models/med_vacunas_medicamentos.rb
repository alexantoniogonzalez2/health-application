class MedVacunasMedicamentos < ActiveRecord::Base
	belongs_to :vacuna, :class_name => 'MedVacunas'
	belongs_to :medicamento, :class_name => 'MedMedicamentos'
	private
  def app_params
    params.require(:list).permit(:id,:vacuna,:medicamento)
  end
end
