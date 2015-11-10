class HabitosAlcoholController < ApplicationController
	def index
		@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		@test_audit = FiHabitosAlcohol.where('persona_id = ?', @persona.id)
	end	
	def new 
	end
	def create

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		@test = FiHabitosAlcohol.new
		@test.audit_1 = params[:param_1]
		@test.audit_2 = params[:param_2]
		@test.audit_3 = params[:param_3]
		@test.audit_4 = params[:param_4]
		@test.audit_5 = params[:param_5]
		@test.audit_6 = params[:param_6]
		@test.audit_7 = params[:param_7]
		@test.audit_8 = params[:param_8] 
		@test.audit_9 = params[:param_9]
		@test.audit_10 = params[:param_10]
		@test.audit_puntaje = params[:param_1].to_i+params[:param_2].to_i+params[:param_3].to_i+params[:param_4].to_i+params[:param_5].to_i+params[:param_6].to_i+params[:param_7].to_i+params[:param_8].to_i+params[:param_9].to_i+params[:param_10].to_i
		@test.fecha_test_audit = DateTime.current
		@test.persona = @persona
		@test.save!

		respond_to do |format|
			format.js   {}
    	format.json { render :json => { :success => true } }
		end		
	end
	def guardarHabitoAlcoholResumen
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		@habito_alcohol_resumen = FiHabitosAlcoholResumen.where('persona_id = ?',@persona.id).first	
		@habito_alcohol_resumen = FiHabitosAlcoholResumen.new unless @habito_alcohol_resumen
		@habito_alcohol_resumen.persona = @persona

		case params[:campo]
		when 'fre' then @habito_alcohol_resumen.frecuencia = params[:valor]
		when 'tip' then @habito_alcohol_resumen.tipo = params[:valor]
		when 'can' then @habito_alcohol_resumen.cantidad = params[:valor]	
		end
		@habito_alcohol_resumen.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	
		
	end
=begin	
	def show
		@test_audit = FiHabitosAlcohol.find(params[:id])
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		unless @test_audit.persona.id == @usuario.id 
			render :text => 'No tiene permisos para ver esta página.'<<params[:id]
		end	
	end
=end		
end
