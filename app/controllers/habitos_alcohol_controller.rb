class HabitosAlcoholController < ApplicationController
	def new 
	end
	def create
		@test_audit = FiHabitosAlcohol.new
		@test_audit.audit_1 = params[:param_1]
		@test_audit.audit_2 = params[:param_2]
		@test_audit.audit_3 = params[:param_3]
		@test_audit.audit_4 = params[:param_4]
		@test_audit.audit_5 = params[:param_5]
		@test_audit.audit_6 = params[:param_6]
		@test_audit.audit_7 = params[:param_7]
		@test_audit.audit_8 = params[:param_8] 
		@test_audit.audit_9 = params[:param_9]
		@test_audit.audit_10 = params[:param_10]
		@test_audit.audit_puntaje = params[:param_1].to_i+params[:param_2].to_i+params[:param_3].to_i+params[:param_4].to_i+params[:param_5].to_i+params[:param_6].to_i+params[:param_7].to_i+params[:param_8].to_i+params[:param_9].to_i+params[:param_10].to_i
		@test_audit.fecha_test_audit = DateTime.current
		@test_audit.persona_id = params[:atencion_salud_id].nil? ? current_user.id : 999 
		@test_audit.save!

		respond_to do |format|
			format.json { render :json => { :success => true, :id => @test_audit.id }	}
		end		
	end
	def show
		@test_audit = FiHabitosAlcohol.find(params[:id])
		unless @test_audit.persona.id == current_user.id 
			render :text => 'No tiene permisos para ver esta página.'<<params[:id]
		end	
	end	
end
