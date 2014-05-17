class PersonaPrestacionController < ApplicationController
	
	def agregarExamen		

		persona_examen_actual = FiPersonaPrestaciones.where('atencion_salud_id = ? AND persona_id = ? AND prestacion_id = ? ', params[:atencion_salud_id], params[:persona_id], params[:examen_id]).first

		if persona_examen_actual

			render :json => { :success => false }		

		else 
			@persona_examen = FiPersonaPrestaciones.new
			@persona_examen.persona_id = params[:persona_id]
			@persona_examen.atencion_salud_id = params[:atencion_salud_id]
			@persona_examen.examen_id = params[:examen_id]
			@persona_examen.save!

			render :json => { :success => true, :per_exa => @persona_examen.id }	
		
		end  	
	end

	def cargarExamenes		

		term= params[:q]
		exam=[]
		@examenes = MedPrestaciones.joins(:subgrupos).where("med_prestaciones.nombre LIKE ? ", "%#{term}%")
		
		@examenes.each do |f|
			exam << f.formato_examenes			
		end

		respond_to do |format|
			format.json { render json: exam}
		end
				
	end

	def eliminarExamen		
		@persona_examen = FiPersonaPrestaciones.find(params[:persona_examen_id])
  	@persona_examen.destroy 

  	render :json => { :success => true }	
	end

end
