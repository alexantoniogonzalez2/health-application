class PersonaExamenController < ApplicationController
	
	def agregarExamen		

		persona_examen_actual = FiPersonaExamenes.where('atencion_salud_id = ? AND persona_id = ? AND examen_id = ? ', params[:atencion_salud_id], params[:persona_id], params[:examen_id]).first

		if persona_examen_actual

			render :json => { :success => false }		

		else 
			@persona_examen = FiPersonaExamenes.new
			@persona_examen.persona_id = params[:persona_id]
			@persona_examen.atencion_salud_id = params[:atencion_salud_id]
			@persona_examen.examen_id = params[:examen_id]
			@persona_examen.save!

			render :json => { :success => true, :per_exa => @persona_examen.id }	
		
		end  	
	end

	def eliminarExamen		
		@persona_examen = FiPersonaExamenes.find(params[:persona_examen_id])
  	@persona_examen.destroy 

  	render :json => { :success => true }	
	end

end
