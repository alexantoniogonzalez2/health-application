class PrePrestadorProfesionales < ActiveRecord::Base

	belongs_to :prestador, :class_name => 'PrePrestadores'
	belongs_to :profesional, :class_name => 'PerPersonas'
	belongs_to :especialidad, :class_name => 'ProEspecialidades'
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'especialidad_prestador_profesional_id'

	private
  def app_params
    params.require(:list).permit(:id,
								:prestador,
								:profesional,
								:especialidad)
  end

  								
end
