class AgAgendamientoLogEstados < ActiveRecord::Base

	belongs_to :responsable, :class_name => 'PerPersonas'
	belongs_to :agendamiento_estado, :class_name => 'AgAgendamientoEstados'	
	belongs_to :agendamiento, :class_name => 'AgAgendamientos'

	private
  def app_params
    params.require(:list).permit(:id, :fecha, :responsable, :agendamiento_estado, :agendamiento)
  end
end
