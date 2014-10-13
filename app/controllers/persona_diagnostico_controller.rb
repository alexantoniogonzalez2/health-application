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

	def agregarInfoEno

		fecha = ''
		confirmacion = ''
		vacunacion = ''
		pais = nil
		embarazo = ''
		sem_emb = ''
		tbc = ''

		@notificacion_eno = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:pers_diag]).first

		if @notificacion_eno.nil? 			
			@notificacion_eno = FiNotificacionesEno.new
			@notificacion_eno.persona_diagnostico_atencion_salud_id = params[:pers_diag]						
		end	

		case params[:tipo]
			when 'fecha'
				@notificacion_eno.fecha_primeros_sintomas = params[:valor] 
			when 'confirmacion'
				@notificacion_eno.confirmacion_diagnostica = params[:valor]  
			when 'vacunacion'
				@notificacion_eno.antecedentes_vacunacion = params[:valor] 
			when 'pais'
				@pais = TraPaises.find(params[:valor])
				@notificacion_eno.pais_contagio = @pais 
			when 'embarazo'
				@notificacion_eno.embarazo = params[:valor]
			when 'sem_emb'
				@notificacion_eno.semanas_gestacion = params[:valor]
			when 'tbc'
				@notificacion_eno.tbc = params[:valor]						
		end

		@notificacion_eno.save

		respond_to do |format|
			format.json { render :json => { :success => true }	}
		end
				
	end

	def agregarInfoInterconsulta

		@persona = nil
		nombre = ''
		correo = ''
		celular = ''
		rut = ''

		case params[:tipo]
			when 'persona'				
				unless params[:valor].blank? 
					@persona = PerPersonas.find(params[:valor])
					nombre = @persona.showName('%n%p%m')
					correo = @persona.user.email
					celular = @persona.getCelular
					rut = @persona.showRut
				end
			when 'prestador'
				@prestador = PrePrestadores.find(params[:valor])
			when 'especialidad'
				@especialidad = ProEspecialidades.find(params[:valor])
			when 'comentario'
			when 'proposito'			
		end

		@interconsulta = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is null ',params[:pers_diag]).first

		if @interconsulta
		else	#se info persona temporalmente, sin fecha			
			@interconsulta = FiInterconsultas.new
			@interconsulta.persona_diagnostico_atencion_salud_id = params[:pers_diag]						
		end	

		case params[:tipo]
			when 'persona'
				@interconsulta.persona_conocimiento = @persona 
			when 'prestador'
				@interconsulta.prestador_destino = @prestador 
			when 'especialidad'
				@interconsulta.especialidad = @especialidad
			when 'comentario'
				@interconsulta.comentario = params[:valor]
			when 'proposito'
				@interconsulta.proposito = params[:valor]			
		end

		@interconsulta.save

		respond_to do |format|
			format.json { render :json => { :success => true, :nombre => nombre, :correo => correo, :celular => celular, :rut => rut }	}
		end
				
	end

	def agregarPersonaInterconsultaPre

		@user = User.new
		@user.email = params[:correo]
		@user.password = "Random123"

		@persona = PerPersonas.new
		@persona.nombre = params[:nombre]
		@persona.apellido_paterno = params[:apep]
		@persona.apellido_materno = params[:apem]
		@persona.rut = params[:rut]
		@persona.digito_verificador = params[:dv]
		@telefono = TraTelefonos.new
		@telefono.codigo = 9 #celular
		@telefono.numero = params[:celular]
		@telefono.save
		@user.save!
		@persona.user = @user
		@persona.save
		@persona_telefono = PerPersonasTelefonos.new
		@persona_telefono.persona = @persona
		@persona_telefono.telefono = @telefono
		@persona_telefono.save!		

		@interconsulta = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is null ',params[:pd]).first

		if @interconsulta
			@interconsulta.persona_conocimiento = @persona 
		else	#se agrega persona temporalmente, sin fecha			
			@interconsulta = FiInterconsultas.new
			@interconsulta.persona_diagnostico_atencion_salud_id = params[:pd]
			@interconsulta.persona_conocimiento = @persona 
			@interconsulta.save
		end	

		respond_to do |format|
			format.json { render :json => { :success => true, :rut => @persona.showRut, :celular => @persona.getCelular}	}
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
		@persona.digito_verificador = params[:dv]
		@telefono = TraTelefonos.new
		@telefono.codigo = 9 #celular
		@telefono.numero = params[:celular]
		@telefono.save
		@user.save!
		@persona.user = @user
		@persona.save
		@persona_telefono = PerPersonasTelefonos.new
		@persona_telefono.persona = @persona
		@persona_telefono.telefono = @telefono
		@persona_telefono.save!		

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
			format.json { render :json => { :success => true, :rut => @persona.showRut, :celular => @persona.getCelular}	}
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

			@persona_diagnostico = FiPersonaDiagnosticos.where('diagnostico_id = ? AND persona_id = ?',params[:diagnostico_id],params[:persona_id]).first

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

	def descargarNotificacionObligatoria

		@notificacion_eno_pre = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:id]).first
		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@fecha = ''
		@confirmacion = ''
		@vacunacion = ''
		@pais = nil
		@embarazo = ''
		@sem_emb = ''
		@tbc = ''
		borrar = false

		if (!@notificacion_eno_pre)
			@notificacion_eno_pre = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_notificacion DESC').first
		else
			borrar = true	
		end	

		if @notificacion_eno_pre
			@fecha = @notificacion_eno_pre.fecha_primeros_sintomas
			@confirmacion = @notificacion_eno_pre.confirmacion_diagnostica
			@vacunacion = @notificacion_eno_pre.antecedentes_vacunacion
			@pais = @notificacion_eno_pre.pais_contagio
			@embarazo = @notificacion_eno_pre.embarazo
			@sem_emb = @notificacion_eno_pre.semanas_gestacion
			@tbc = @notificacion_eno_pre.tbc
			if borrar
				@notificacion_eno_pre.destroy
			end	
		end	

		@notificacion_eno = FiNotificacionesEno.new
		@notificacion_eno.persona_diagnostico_atencion_salud_id = params[:id]
		@notificacion_eno.fecha_notificacion = DateTime.current
		@notificacion_eno.fecha_primeros_sintomas = @fecha
		@notificacion_eno.confirmacion_diagnostica = @confirmacion
		@notificacion_eno.antecedentes_vacunacion = @vacunacion
		@notificacion_eno.pais_contagio = @pais
		@notificacion_eno.embarazo = @embarazo
		@notificacion_eno.semanas_gestacion = @sem_emb
		@notificacion_eno.tbc = @tbc

		@notificacion_eno.save		

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
                 :template => "persona_diagnostico/notificacion_obligatoria.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona } ,
                 :disposition => 'attachment',
                 :encoding => "utf8",
                 :show_as_html => params[:debug]                 
 					 end               
		end

	end	

	def descargarInterconsulta 

		@interconsulta_pre = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is null ',params[:id]).first
		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@persona = nil
		@proposito = nil
		@prestador_destino = nil
		@especialidad = nil
		@comentario = nil
		@proposito_otro = nil
		borrar = false

		if (!@interconsulta_pre)
			@interconsulta_pre = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_solicitud DESC').first
		else
			borrar = true	
		end	

		if @interconsulta_pre
			@persona = @interconsulta_pre.persona_conocimiento
			@proposito = @interconsulta_pre.proposito
			@prestador_destino = @interconsulta_pre.prestador_destino
			@especialidad = @interconsulta_pre.especialidad
			@comentario = @interconsulta_pre.comentario
			#@proposito_otro = @interconsulta_pre.proposito_otro
			if borrar
				@interconsulta_pre.destroy
			end	

		end	

		@interconsulta = FiInterconsultas.new
		@interconsulta.persona_diagnostico_atencion_salud_id = params[:id]
		@interconsulta.persona_conocimiento = @persona 
		@interconsulta.proposito = @proposito  
		@interconsulta.fecha_solicitud = DateTime.current
		@interconsulta.prestador_destino = @prestador_destino
		@interconsulta.especialidad = @especialidad
		@interconsulta.comentario = @comentario
		#@interconsulta.proposito_otro = @proposito_otro
		@interconsulta.save
	
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
                 :template => "persona_diagnostico/interconsulta.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona, :interconsulta => @interconsulta } ,
                 :disposition => 'attachment',
                 :encoding => "utf8",
                 :show_as_html => params[:debug]                 
 					 end               
		end

	end	

	def descargarConstanciaGes 

		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:id]).first
		
		@persona = nil
		borrar = false

		if (!@notificacion_ges)
			@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_notificacion DESC').first
		else
			borrar = true	
		end	


		if @notificacion_ges
			@persona = @notificacion_ges.persona_conocimiento
			if borrar
				@notificacion_ges.destroy
			end	
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
	def index
		@acceso = true
		@paciente = PerPersonas.find(current_user.id)		
		id_usuario = current_user.id
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona 
		end		
		@persona_diagnosticos = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																				JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																.select('fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,fi_persona_diagnosticos_atenciones_salud.fecha_inicio,fi_persona_diagnosticos_atenciones_salud.fecha_termino,md.nombre')
																																.where('fpd.persona_id = ?',id_usuario) if @acceso					
	end

end
