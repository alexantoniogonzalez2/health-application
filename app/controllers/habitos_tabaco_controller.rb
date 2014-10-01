class HabitosTabacoController < ApplicationController
	def index
		@consumo = FiHabitosTabaco.where('persona_id = ?', current_user.id)
	end	
	def new 
	end
	def create
		@consumo = FiHabitosTabaco.new
		@consumo.persona_id = params[:atencion_salud_id].nil? ? current_user.id : 999 
		@consumo.fecha_inicio = DateTime.current
		@consumo.fecha_final = DateTime.current
		@consumo.cigarros_por_dia = 1000
		@consumo.paquetes_agno = 1000
		@consumo.save!

		respond_to do |format|
			format.json { render :json => { :success => true, :id => @consumo.id }	}
		end		
	end
	def show
		@consumo = FiHabitosTabaco.find(params[:id])
		unless @consumo.persona.id == current_user.id 
			render :text => 'No tiene permisos para ver esta página.'<<params[:id]
		end	
	end	
end
