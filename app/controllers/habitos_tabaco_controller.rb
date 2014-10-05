class HabitosTabacoController < ApplicationController
	def index
		@total_consumo = 0
		@consumo = FiHabitosTabaco.where('persona_id = ?', current_user.id)
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	
	end	
	def new 
	end
	def create
		case params[:tipo]
		when 'ingresar'
			@consumo = FiHabitosTabaco.new
			@consumo.persona_id = params[:atencion_salud_id].nil? ? current_user.id : 999 
			@consumo.fecha_inicio =  params[:f_i]
			@consumo.fecha_final = params[:f_f]
			@consumo.cigarros_por_dia = params[:cigarrosDia]
			@consumo.paquetes_agno = params[:paquetesAgno].to_f			
		when 'editar'
			@consumo = FiHabitosTabaco.find(params[:id])
			@consumo.fecha_inicio =  params[:f_i]
			@consumo.fecha_final = params[:f_f]
			@consumo.cigarros_por_dia = params[:cigarrosDia]
			@consumo.paquetes_agno = params[:paquetesAgno].to_f			
		end
		@consumo.save!
		respond_to do |format|
			format.json { render :json => { :success => true }	}
		end		
	end
	def edit
		@consumo = FiHabitosTabaco.find(params[:id])
		unless @consumo.persona.id == current_user.id 
			render :text => 'No tiene permisos para ver esta página.'<<params[:id]
		end	
	end	
end
