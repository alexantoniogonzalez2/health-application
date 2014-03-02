class PersonaExamenController < ApplicationController
	
	def agregarExamen		

		persona_diagnostico_actual = FiPersonaDiagnosticos.joins(:persona_diagnosticos_atencion_salud).where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ' , params[:atencion_salud_id], params[:diagnostico_id]).first

		if persona_diagnostico_actual

			render :json => { :success => false }		

		else 
			@persona_diagnostico = FiPersonaDiagnosticos.new
			@persona_diagnostico.persona_id = params[:persona_id]
			@persona_diagnostico.diagnostico_id = params[:diagnostico_id]
			@persona_diagnostico.fecha_inicio = DateTime.current
			@persona_diagnostico.estado_diagnostico_id = 1
			@persona_diagnostico.save!

			@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
			@persona_diagnostico_atencion.persona_diagnostico_id = @persona_diagnostico.id
			@persona_diagnostico_atencion.atencion_salud_id = params[:atencion_salud_id]
			@persona_diagnostico_atencion.estado_diagnostico_id = 1
			@persona_diagnostico_atencion.save

			render :json => { :success => true }	
		
		end

	  
    	
  	
	end



end
