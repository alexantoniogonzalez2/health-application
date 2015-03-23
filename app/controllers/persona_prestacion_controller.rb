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

		def agregarPrestacionAntecedentes		

		@prestadores = PrePrestadores.all			
		@persona_prestacion = FiPersonaPrestaciones.new

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.find(current_user.id) 
		else
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
			@persona_prestacion.atencion_salud = @atencion_salud
		end	

		@persona_prestacion.persona = @persona
		@persona_prestacion.prestacion_id = params[:prestacion_id]
		@persona_prestacion.es_antecedente = true
		@persona_prestacion.save!

		#no está considerado examenes como antecedentes
		if params[:tipo] == 'examen'
			respond_to do |format|     
      	format.js   { render 'agregarExamenAntecedentes'}
      	format.json { render :json => { :success => true } }
      end	
    else
    	respond_to do |format|     
      	format.js   { render 'agregarProcedimientoAntecedentes'}
      	format.json { render :json => { :success => true } }
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

	def indexExamen
		min  = 1
		max = 56
		@acceso = true
		@paciente = PerPersonas.find(current_user.id)		
		id_usuario = current_user.id
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona 
		end					
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',id_usuario,min,max) if @acceso
		render 'index'					
	end

	def indexProc
		min = 57
		max = 250
		@acceso = true
		@paciente = PerPersonas.find(current_user.id)		
		id_usuario = current_user.id
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona 
		end
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',id_usuario,min,max) if @acceso
		render 'index'					
	end

	def agregarInfoPrestacion
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id]) if params[:atencion_salud_id] != 'persona'
		@persona_prestacion = FiPersonaPrestaciones.find(params[:p_p])
		case params[:param]
			when 'fecha'
				@persona_prestacion.fecha_prestacion = params[:valor] 
			when 'prestador'
				@persona_prestacion.prestador = PrePrestadores.find(params[:valor])  
		end
		@persona_prestacion.save!

  	if @persona_prestacion.es_antecedente
  		respond_to do |format|     
    		format.js   {}
    	end	  		
  	else  
  		render :json => { :success => true }	  		
  	end		

	end	


end
