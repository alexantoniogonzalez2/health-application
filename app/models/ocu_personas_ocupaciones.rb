class OcuPersonasOcupaciones < ActiveRecord::Base
	include ActionView::Helpers::DateHelper

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :ocupacion, :class_name => 'OcuOcupaciones'

	def getTiempoTotal
		respuesta = '-'
		respuesta = distance_of_time_in_words(fecha_inicio,fecha_termino) unless fecha_termino.nil? or fecha_inicio.nil?	
		
		return respuesta 
	end	

	private
  def app_params
    params.require(:list).permit(:id,:fecha_inicio,:fecha_termino,:persona,:ocupacion,:es_actual)
  end
  
end
