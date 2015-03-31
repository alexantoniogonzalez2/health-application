class HabitosAlcoholController < ApplicationController
	def index
		@test_audit = FiHabitosAlcohol.where('persona_id = ?', current_user.id)
	end	
	def new 
	end
	def create

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.find(current_user.id) 
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
	def show
		@test_audit = FiHabitosAlcohol.find(params[:id])
		unless @test_audit.persona.id == current_user.id 
			render :text => 'No tiene permisos para ver esta página.'<<params[:id]
		end	
	end	
end
