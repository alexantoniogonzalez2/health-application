class AgAgendamientoEstados < ActiveRecord::Base
	
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'agendamiento_estado_id'

	private
  def app_params
    params.require(:list).permit(:id,
	 									:nombre,:agendamientos)
  end
 					

end
