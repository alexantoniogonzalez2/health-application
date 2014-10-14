class PersonaPrestacionController < ApplicationController
	
	def agregarPrestacion		

		persona_prestacion_actual = FiPersonaPrestaciones.where('atencion_salud_id = ? AND persona_id = ? AND prestacion_id = ? ', params[:atencion_salud_id], params[:persona_id], params[:prestacion_id]).first
		@prestadores = PrePrestadores.all
		
		if persona_prestacion_actual

			render :json => { :success => false }		

		else 
			
			@persona_prestacion = FiPersonaPrestaciones.new
			@persona_prestacion.persona_id = params[:persona_id]
			@persona_prestacion.atencion_salud_id = params[:atencion_salud_id]
			@persona_prestacion.prestacion_id = params[:prestacion_id]
			@persona_prestacion.save!

			if params[:tipo] == 'examen'
				respond_to do |format|     
	      	format.js   { render 'agregarExamen'}
	      	format.json { render :json => { :success => true } }
	      end	
	    else
	    	respond_to do |format|     
	      	format.js   { render 'agregarProcedimiento'}
	      	format.json { render :json => { :success => true } }
	      end    
	    end  

		end  	
	end

	def cargarPrestaciones		

		term= params[:q]
		pres=[]
		
		if params[:tipo] == 'examen'
			min  = 1
			max = 56
		else
			min = 57
			max = 250
		end		

		#se puede mejorar consulta para filtrar por grupos 3 y 4 en vez de filtrar por los subgrupos	
		@prestaciones = MedPrestaciones.joins(:subgrupo).where("med_prestaciones.nombre LIKE ? AND med_prestaciones_subgrupos.id BETWEEN ? and ? ", "%#{term}%",min,max)
		
		@prestaciones.each do |f|
			pres << f.formato_prestaciones			
		end

		respond_to do |format|
			format.json { render json: pres}
		end
				
	end

	def eliminarPrestacion		
		@persona_prestacion = FiPersonaPrestaciones.find(params[:persona_prestacion_id])
  	@persona_prestacion.destroy 

  	render :json => { :success => true }	
	end

end
