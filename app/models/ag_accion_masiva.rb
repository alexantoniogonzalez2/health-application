class AgAccionMasiva < ActiveRecord::Base

	self.table_name = "ag_accion_masiva"
	
	belongs_to :responsable, :class_name => 'PerPersonas'
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'accion_masiva_id'
	
	private
  def app_params
    params.require(:list).permit(:id,:estado,:responsable,:agendamientos,:total_agendamientos,:agendamientos_cancelados,:agendamientos_sin_cancelar,:especialidad_prestador_profesional)
  end

end
