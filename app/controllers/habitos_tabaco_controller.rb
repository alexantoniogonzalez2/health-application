class HabitosTabacoController < ApplicationController
	def index
		@total_consumo = 0
		@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id)
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	
	end	
	def new 
	end
	def create
		@tipo_accion = params[:tipo]	
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		case @tipo_accion
		when 'ingresar'
			@cons = FiHabitosTabaco.new
			@cons.persona = @persona
			@cons.fecha_inicio = DateTime.new(params[:f_i].to_i , 1, 1)
			@cons.fecha_final = DateTime.new(params[:f_f].to_i , 1, 1)
			@cons.cigarros_por_dia = params[:cigarrosDia]
			@cons.paquetes_agno = params[:paquetesAgno].to_f			
		when 'editar'
			@cons = FiHabitosTabaco.find(params[:id])
			@cons.fecha_inicio = DateTime.new(params[:f_i].to_i , 1, 1)
			@cons.fecha_final = DateTime.new(params[:f_f].to_i , 1, 1)
			@cons.cigarros_por_dia = params[:cigarrosDia]
			@cons.paquetes_agno = params[:paquetesAgno].to_f			
		end
		@cons.save!

		#Tabaco
		@total_consumo = 0
		@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id)
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	

		respond_to do |format|
			format.js   {}
			format.json { render :json => { :success => true }	}
		end		
	end
	def edit
		@consumo = FiHabitosTabaco.find(params[:id])
	end	
end
