class PersonaDiagnosticoController < ApplicationController

	 def cargarDiagnosticos		

		diag = []  	
		term = params[:q]

		if params[:diag_no_frec] == 'true'
			@diagnosticos = MedDiagnosticos.where("nodo_terminal = 1 AND (nombre LIKE ? OR codigo_cie10 LIKE ? )", "%#{term}%", "%#{term}%")
		else
			@diagnosticos = MedDiagnosticos.where("nodo_terminal = 1 AND frecuente = ? AND (nombre LIKE ? OR codigo_cie10 LIKE ?) ", true, "%#{term}%", "%#{term}%")
		end			
		
		@diagnosticos.each do |f|
			diag << f.formato_lista			
		end

		respond_to do |format|
			format.json { render json: diag}
		end
				
	end

	def cargarPersonas	

		per = []  	
		term = params[:q]

		@personas = PerPersonas.where("rut LIKE ? OR concat(nombre,' ',apellido_paterno,' ',apellido_materno) LIKE ? ","%#{term}%","%#{term}%")

		@personas.each do |p|
			per << p.formato_personas			
		end

		respond_to do |format|
			format.json { render json: per}
		end
				
	end

	def agregarPersonaNotificacion

		@persona = nil
		nombre = ''
		correo = ''
		celular = ''
		rut = ''

		unless params[:persona_id].blank? 
			@persona = PerPersonas.find(params[:persona_id])
			nombre = @persona.showName('%n%p%m')
			correo = @persona.user.email
			celular = @persona.getCelular
			rut = @persona.showRut
		end			

		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:pers_diag]).first

		if @notificacion_ges
			@notificacion_ges.persona_conocimiento = @persona 
			params[:persona_id].blank? ? @notificacion_ges.destroy : @notificacion_ges.save
		else	#se agrega persona temporalmente, sin fecha			
			@notificacion_ges = FiNotificacionesGes.new
			@notificacion_ges.persona_diagnostico_atencion_salud_id = params[:pers_diag]
			@notificacion_ges.persona_conocimiento = @persona 
			@notificacion_ges.save
		end	

		respond_to do |format|
			format.json { render :json => { :success => true, :nombre => nombre, :correo => correo, :celular => celular, :rut => rut }	}
		end
				
	end

	def agregarPersonaNotificacionPre

		@user = User.new
		@user.email = params[:correo]
		@user.password = "Random123"

		@persona = PerPersonas.new
		@persona.nombre = params[:nombre]
		@persona.apellido_paterno = params[:apep]
		@persona.apellido_materno = params[:apem]
		@persona.rut = params[:rut]
		
		@user.save!
		@persona.user = @user
		@persona.save
		

		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:pd]).first

		if @notificacion_ges
			@notificacion_ges.persona_conocimiento = @persona 
		else	#se agrega persona temporalmente, sin fecha			
			@notificacion_ges = FiNotificacionesGes.new
			@notificacion_ges.persona_diagnostico_atencion_salud_id = params[:pd]
			@notificacion_ges.persona_conocimiento = @persona 
			@notificacion_ges.save
		end	

		respond_to do |format|
			format.json { render :json => { :success => true, :nombre => @persona.nombre, :correo => @user.email, :celular => 'celular', :rut => @persona.rut}	}
		end
				
	end

	def agregarDiagnostico

		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @prestadores = PrePrestadores.all
	  @especialidades = ProEspecialidades.all
	  @paises = TraPaises.all	
	  @primer_diagnostico = 0	

		persona_diagnostico_atencion_actual = FiPersonaDiagnosticos
																						.joins(:persona_diagnosticos_atencion_salud)
																						.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ',
																						 params[:atencion_salud_id],
																						 params[:diagnostico_id]).first

		if persona_diagnostico_atencion_actual

			render :json => { :success => false }		

		else 

			@persona_diagnostico = FiPersonaDiagnosticos.where('diagnostico_id = ? ',params[:diagnostico_id]).first

			if !@persona_diagnostico

				@persona_diagnostico = FiPersonaDiagnosticos.new
				@persona_diagnostico.persona_id = params[:persona_id]
				@persona_diagnostico.diagnostico_id = params[:diagnostico_id]
				@persona_diagnostico.fecha_inicio = DateTime.current
				@persona_diagnostico.estado_diagnostico_id = 1
				@persona_diagnostico.es_cronica = 0		
				@persona_diagnostico.save!
				@primer_diagnostico = 1
				
			end	

			@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
			@persona_diagnostico_atencion.persona_diagnostico_id = @persona_diagnostico.id
			@persona_diagnostico_atencion.atencion_salud_id = params[:atencion_salud_id]
			@persona_diagnostico_atencion.estado_diagnostico_id = @persona_diagnostico.estado_diagnostico.id
			@persona_diagnostico_atencion.fecha_inicio = @persona_diagnostico.fecha_inicio
			@persona_diagnostico_atencion.fecha_termino = @persona_diagnostico.fecha_termino
			@persona_diagnostico_atencion.es_cronica = @persona_diagnostico.es_cronica
			@persona_diagnostico_atencion.en_tratamiento = params[:en_tratamiento]
			@persona_diagnostico_atencion.primer_diagnostico = @primer_diagnostico
			@persona_diagnostico_atencion.save

			@estados_diagnostico = MedDiagnosticoEstados.all

			@persona_diagnostico = FiPersonaDiagnosticos
		  	.joins(:persona_diagnosticos_atencion_salud)
		  	.select("fi_persona_diagnosticos_atenciones_salud.id,
		  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
		  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
		  					fi_persona_diagnosticos.diagnostico_id,
		  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
		  					fi_persona_diagnosticos_atenciones_salud.comentario,
		  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
		  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
		  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico")
		  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ' ,
		  	 params[:atencion_salud_id],
		  	 params[:diagnostico_id]).first

			respond_to do |format|     
      	format.js   {}
      	format.json { render :json => { :success => true, :pers_diag => @persona_diagnostico.id }	 }
      end		
		
		end  	
	end

	def eliminarDiagnostico	

  	@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where(" id = ? ",params[:persona_diagnostico_atencion_salud_id]).first
  	@persona_diagnostico_id = @persona_diagnostico_atencion.persona_diagnostico.id
  	@persona_diagnostico_atencion.destroy

  	#Si no hay otra, se elimina el diagnóstico
  	@persona_diagnostico_atencion_otro = FiPersonaDiagnosticosAtencionesSalud.where("persona_diagnostico_id = ?", @persona_diagnostico_id).order("updated_at DESC").first

  	if !@persona_diagnostico_atencion_otro 
  		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)
  		@persona_diagnostico.destroy 
  	else #Se actualiza diagnostico con información de última atención de salud 
  		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)
  		@persona_diagnostico.estado_diagnostico_id = @persona_diagnostico_atencion_otro.estado_diagnostico_id
  		@persona_diagnostico.es_cronica = @persona_diagnostico_atencion_otro.es_cronica
  		@persona_diagnostico.fecha_inicio = @persona_diagnostico_atencion_otro.fecha_inicio
  		@persona_diagnostico.fecha_termino = @persona_diagnostico_atencion_otro.fecha_termino
  		@persona_diagnostico.save
  	end	

  	render :json => { :success => true }	
	end

	def guardarDiagnostico	

		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:persona_diagnostico_atencion_salud_id]).first	
		@persona_diagnostico_id = @persona_diagnostico_atencion.persona_diagnostico_id
		@estado = MedDiagnosticoEstados.find(params[:estado_diagnostico])
		@persona_diagnostico_atencion.update( estado_diagnostico: @estado , comentario: params[:comentario], fecha_inicio: params[:fecha_inicio], fecha_termino: params[:fecha_termino], es_cronica: params[:enf_cro], en_tratamiento: params[:trat])	
		
		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)		
  	@persona_diagnostico.update( estado_diagnostico: @estado, fecha_inicio: params[:fecha_inicio], fecha_termino: params[:fecha_termino], es_cronica: params[:enf_cro] )

  	render :json => { :success => true, :pers_diag => @persona_diagnostico_id}	

	end

	def autoguardarComentario

		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:persona_diagnostico_atencion_salud_id]).first	
		@persona_diagnostico_atencion.update( comentario: params[:comentario] )	

		render :json => { :success => true}	

	end

	def descargarConstanciaGes 

		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:id]).first
		
		@persona = nil
		if @notificacion_ges
			@persona = @notificacion_ges.persona_conocimiento
			@notificacion_ges.destroy
		end	

		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@confirmacion_diagnostica = nil
		if @persona_diagnostico_atencion.estado_diagnostico.nombre == "Confirmado" 
			@confirmacion_diagnostica = @persona_diagnostico_atencion.en_tratamiento ? "tratamiento" : "confirmacion"
		end

		@notificacion_ges = FiNotificacionesGes.new
		@notificacion_ges.persona_diagnostico_atencion_salud_id = params[:id]
		@notificacion_ges.persona_conocimiento = @persona 
		@notificacion_ges.confirmacion_diagnostica = @confirmacion_diagnostica   
		@notificacion_ges.fecha_notificacion = DateTime.current
		@notificacion_ges.save

	  @agendamiento = AgAgendamientos.find(params[:ag])

		p_d = FiPersonaDiagnosticos
  	.joins(:persona_diagnosticos_atencion_salud)
  	.select("fi_persona_diagnosticos_atenciones_salud.id,
  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
  					fi_persona_diagnosticos.diagnostico_id,
  					fi_persona_diagnosticos.persona_id,
  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
  					fi_persona_diagnosticos_atenciones_salud.comentario,
  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
  	.where('fi_persona_diagnosticos_atenciones_salud.id' => params[:id]).first

	  @estados_diagnostico = MedDiagnosticoEstados.all

	  nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' ' << params[:id] << ' ' << p_d.persona.showRut << p_d.diagnostico.nombre 

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "persona_diagnostico/constancia_ges.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona } ,
                 :disposition => 'attachment',
                 :encoding => "utf8",
                 :show_as_html => params[:debug]                 
 					 end               
		end

	end	

end
