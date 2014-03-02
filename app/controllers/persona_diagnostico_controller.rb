class PersonaDiagnosticoController < ApplicationController

	def agregarDiagnostico		

		@persona_examen = FiPersonaExamenes.new
		@persona_examen.persona_id = params[:persona_id]
		@persona_examen.examen_id = params[:examen_id]
		@persona_examen.atencion_salud_id = params[:atencion_salud_id]
		@persona_examen.save
		
	  render :nothing => true    	
  	
	end
end
