class AgAccionMasiva < ActiveRecord::Base

	self.table_name = "ag_accion_masiva"
	
	belongs_to :responsable, :class_name => 'PerPersonas'
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'accion_masiva_id'

	def getAgendamientosSinEliminar
		count_agendamientos_sin_eliminar = 0
		agendamientos.each do |agendamiento|
			count_agendamientos_sin_eliminar += 1 
		end	
		return count_agendamientos_sin_eliminar
	end
	
	def getAgendamientosSinCancelar	
	end	
	
	private
  def app_params
    params.require(:list).permit(:id,:estado,:responsable,:agendamientos,:total_agendamientos,:agendamientos_eliminados,:agendamientos_sin_eliminar,:especialidad_prestador_profesional)
  end

end
