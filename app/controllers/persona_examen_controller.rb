class PersonaExamenController < ApplicationController
	
	def agregarExamen		


		#@persona_examen = FiPersonaExamenes.new(params[:data])
		@persona_examen = FiPersonaExamenes.new
		@persona_examen.persona_id = params[:persona_id]
		@persona_examen.examen_id = params[:examen_id]
		@persona_examen.atencion_salud_id = params[:atencion_salud_id]
		@persona_examen.save
	  #if @persona_examen.save
	  #	redirect_to :action => "show", :id => @atencion_salud.id
	  #else
	  #	render 'new'
	  #end	

	  render :nothing => true
    	
  	
	end
end
