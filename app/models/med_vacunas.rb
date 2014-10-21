class MedVacunas < ActiveRecord::Base
	has_many :vacunas_medicamentos, :class_name => 'MedVacunasMedicamentos'
	has_many :personas_vacunas, :class_name => 'FiPersonasVacunas', :foreign_key => 'vacuna_id'
  has_many :calendario_vacunas, :class_name => 'FiCalendarioVacunas', :foreign_key => 'vacuna_id'
	private
  def app_params
    params.require(:list).permit(:id,:nombre,:protege_contra,:tipo,:vacunas_medicamentos,:personas_vacunas,:calendario_vacunas)
  end
end
