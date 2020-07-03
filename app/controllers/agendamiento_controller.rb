class AgendamientoController < ApplicationController
	
	include ApplicationHelper

	def buscadorHora
		@profesionales=PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales)").order('nombre,apellido_paterno,apellido_materno')
		@especialidades=ProEspecialidades.where("id in (select especialidad_id from pre_prestador_profesionales)").order('nombre')
		@prestadores=PrePrestadores.where("id in (select prestador_id from pre_prestador_profesionales)").order('nombre')		
	end

	def filtrarProfesionales
		resp="<option></option>"

		if tieneRol('Generar agendamientos') 
			@prestador_id = getIdPrestador('administrativo')
			if params[:especialidad] == ""
				PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales where prestador_id = ? )",@prestador_id).order('nombre,apellido_paterno,apellido_materno').each do |p|
				resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";	
				end 
			else			
				PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales where especialidad_id = ? AND prestador_id = ? )",params[:especialidad],@prestador_id).order('nombre,apellido_paterno,apellido_materno').each do |p|
				resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";
				end 
			end	
		else
			if params[:centros] != ''
				if params[:especialidad] == ''
					PerPersonas.where("id IN (select profesional_id from pre_prestador_profesionales WHERE prestador_id IN  ( ? ) ) ",params[:centros]).order('nombre,apellido_paterno,apellido_materno').each do |p|
					resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";	
					end 
				else			
					PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales WHERE especialidad_id = ? AND prestador_id IN  ( ? ))",params[:especialidad],params[:centros]).order('nombre,apellido_paterno,apellido_materno').each do |p|
					resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";
					end 
				end			
			end			
		end	

		render :text =>resp	
	end

	def filtrarEspecialidad
		resp = ""
		@prestador_id = getIdPrestador('administrativo')		
		@especialidad = PrePrestadorProfesionales.select('especialidad_id').where("profesional_id = ? AND prestador_id = ?",params[:especialista],@prestador_id)
	  resp = @especialidad.length > 1 ? 'multiples' : @especialidad.first.especialidad_id 
		render :text => resp	
	end

	def buscarHoras
		
		events=[]
		@limite = (esAdministrativo or esProfesionalSalud) ? 3.months.ago : Date.today
		
		if params[:centros] == '' or params[:centros].blank?
			if params[:especialidad] != '' and params[:especialista] != ''
				@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.profesional_id = ? AND fecha_comienzo > ? AND estado_id != 11",params[:especialidad],params[:especialista],@limite)
			elsif params[:especialidad] != ''
				@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND fecha_comienzo > ? AND estado_id != 11",params[:especialidad],@limite)
			elsif params[:especialista] != '' 	
				@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ? AND fecha_comienzo > ? AND estado_id != 11",params[:especialista],@limite)
			end
		else	
			if params[:especialidad] != '' and params[:especialista] != ''
				@Fechas =AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.profesional_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) AND fecha_comienzo > ? AND estado_id != 11",params[:especialidad],params[:especialista],params[:centros],@limite)
			elsif params[:especialidad] != ''
				@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) AND fecha_comienzo > ? AND estado_id != 11",params[:especialidad],params[:centros],@limite)
			elsif params[:especialista] != '' 	
				@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) AND fecha_comienzo > ? AND estado_id != 11",params[:especialista],params[:centros],@limite)
			end
		end

		icon = (esAdministrativo or esProfesionalSalud) ? true : false
		if @Fechas 
			@Fechas.each do |f|
				events << f.event(icon)			
			end
		end	

		respond_to do |f|
			f.json {render json:events}
		end	
		
	end

	def buscarHorasProfesional
		
		events = []
		@profesional = PerPersonas.where('user_id = ?',current_user.id).first
		@Fechas = AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ? and estado_id != 11",@profesional.id)
		
		@Fechas.each do |f|
			events << f.event(true)				
		end

		respond_to do |f|
			f.json {render json:events}
		end	
		
	end

	def showFormBusqueda

		if tieneRol('Generar agendamientos') 
			@profesionales = PerPersonas.where("id IN (SELECT profesional_id FROM pre_prestador_profesionales WHERE prestador_id = ? )",getIdPrestador('administrativo'))
   		@especialidades= ProEspecialidades.where("id IN (SELECT especialidad_id FROM pre_prestador_profesionales WHERE prestador_id= ? )",getIdPrestador('administrativo'))
    else
			@profesionales=PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales)").order('nombre,apellido_paterno,apellido_materno')
			@especialidades=ProEspecialidades.where("id in (select especialidad_id from pre_prestador_profesionales)").order('nombre')
			@prestadores=PrePrestadores.where("id in (select prestador_id from pre_prestador_profesionales)").order('nombre')
		end	
	end

	def showFormBusquedaActualizar
		resp=""
		if params[:type].eql? "especialista"
			PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales where (('-1' <> ? AND especialidad_id= ?) OR ? = '-1') AND (('-1' <> ? AND prestador_id= ?) OR ? = '-1'))",params[:especialidad],params[:especialidad],params[:especialidad],params[:prestador],params[:prestador],params[:prestador]).order('nombre,apellido_paterno,apellido_materno').each do |p|
				resp<<"<li><a data-id=\"#{p.id}\">#{p.showName('%n%p%m')}</a></li>";		
			end
		elsif params[:type] == "especialidad"
			ProEspecialidades.where("id in (select especialidad_id from pre_prestador_profesionales where (('-1' <> ? AND profesional_id= ?) OR ? = '-1') AND (('-1' <> ? AND prestador_id= ?) OR ? = '-1'))",params[:especialista],params[:especialista],params[:especialista],params[:prestador],params[:prestador],params[:prestador]).order('nombre').each do |p|
				resp<<"<li><a data-id=\"#{p.id}\">#{p.nombre}</a></li>";		
			end
		elsif params[:type] == "prestador"
			PrePrestadores.where("id in (select prestador_id from pre_prestador_profesionales where (('-1' <> ? AND profesional_id= ?) OR ? = '-1') AND (('-1' <> ? AND especialidad_id= ?) OR ? = '-1'))",params[:especialista],params[:especialista],params[:especialista],params[:especialidad],params[:especialidad],params[:especialidad]).order('nombre').each do |p|
				resp<<"<li><a data-id=\"#{p.id}\">#{p.nombre}</a></li>";		
			end
		end
		render :text =>resp
	end


	def mostrarEventos
		icon = (esAdministrativo or esProfesionalSalud) ? true : false

		if params[:evento_id]
			@Agendamiento=AgAgendamientos.where("id = ?",params[:evento_id]).first
			events=[]

			events << @Agendamiento.event(icon)
			respond_to do |f|
				f.json {render json:events}
			end

		else
			if params[:prestador_id] != "-1" and params[:especialidad_id] != "-1"
				events=[]
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.prestador_id = ? AND pre_prestador_profesionales.profesional_id = ?  ",params[:especialidad_id],params[:prestador_id],params[:profesional_id])
				#Filtrar por fechas si no quiere mostrarse todo (Puede ser algo como un año hacia adelante y un año hacia atrás)

				@Fechas.each do |f|
					events << f.event(icon)				
				end

				respond_to do |f|
					f.json {render json:events}
				end

			else
			
			end
		end

	end

	def generarHora
		
		@breadcrumbs=[]
		if params[:especialidad_id] != "-1" or params[:profesional_id] != "-1" or params[:prestador_id] != "-1"
			@breadcrumbs_title= "Usted ha seleccionado"
			e=ProEspecialidades.where("id = ?",params[:especialidad_id]).first
			pre=PrePrestadores.where("id = ?",params[:prestador_id]).first
			pro=PerPersonas.where("id = ?",params[:profesional_id]).first
			if e
				@breadcrumbs << " #{e.nombre}"
			end
			if pre
				@breadcrumbs << " #{pre.nombre}"
			end
			if pro 
				@breadcrumbs << " #{pro.showName("%d%n%p")}"
			end

		else
			@breadcrumbs_title= "Usted no ha seleccionado ningún filtro"
		end

		@permisoParaAgregar=false
		if tieneRol('Generar agendamientos')
			@permisoParaAgregar=true 
		end	

	end

	def pedirHoraEvento
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		@antecedente = params[:antecedente]
		respuesta="0"
		if params[:persona_hora].blank?
			@persona = PerPersonas.find(params[:paciente])
			if params[:quien_pide_hora] == "El mismo paciente"
				@quien_pide_hora= PerPersonas.find(params[:paciente])				
			else
				@quien_pide_hora = PerPersonas.find(params[:quien_pide_hora])
			end	
		else
			@quien_pide_hora = @responsable
			if params[:persona_hora] == "Para mi"
				@persona = PerPersonas.where('user_id = ?',current_user.id).first				
			else
				@antecedente = ''
				@persona = PerPersonas.find(params[:persona_hora])
			end	
		end

		motivo = params[:motivo].blank? ? params[:motivo_dental] : params[:motivo]
		
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora reservada").first
		@agendamiento.transaction do
			if @agendamiento.fecha_comienzo.to_date.past?
				respuesta = "3"
			elsif @agendamiento.estado.nombre=='Hora disponible'
				respuesta="1"
				@agendamiento.persona = @persona
				@agendamiento.quien_pide_hora = @quien_pide_hora 
				@agendamiento.estado = @estadoAgendamiento
				@agendamiento.motivo_consulta = motivo
				@agendamiento.comentario_motivo = params[:c_dental] unless params[:c_dental].blank?
				@agendamiento.persona_diagnostico_control = FiPersonaDiagnosticos.find(@antecedente) unless @antecedente.blank?
				@agendamiento.capitulo_cie10_control = MedDiagnosticosCapitulos.find(params[:capitulo_cie_10]) unless params[:capitulo_cie_10].blank?
				@agendamiento.save

				@agendamiento_log = AgAgendamientoLogEstados.new
				@agendamiento_log.responsable = @responsable
				@agendamiento_log.agendamiento_estado = @estadoAgendamiento
				@agendamiento_log.agendamiento = @agendamiento
				@agendamiento_log.fecha = DateTime.current
				@agendamiento_log.save
			else
				respuesta="2"
			end
		end
		
		render :text=> respuesta
	end

	def cancelarHora

		perm_paciente = false
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamientoLog = AgAgendamientoEstados.where("nombre = ?","Hora cancelada").first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora bloqueada").first
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first

		#Si fue cancelada por el mismo paciente queda inmediatamente disponible
		if (@agendamiento.persona)
			perm_paciente = (@usuario.id == @agendamiento.quien_pide_hora.id)? true : false 	
		end 		
		if perm_paciente
			@estadoAgendamiento=  AgAgendamientoEstados.where("nombre = ?","Hora disponible").first
		end	

		@agendamiento.transaction do
			respuesta = "1"
			@agendamiento.persona = nil
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save			
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @usuario
		@agendamiento_log.agendamiento_estado = @estadoAgendamientoLog
		@agendamiento_log.agendamiento = @agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save
		
		render :text=> respuesta
	end

	def eliminarHora

		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento=  AgAgendamientoEstados.where("nombre = ?","Hora eliminada").first
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first

		if ['Hora disponible','Hora cancelada'].include?(@agendamiento.estado.nombre)
			respuesta = "1"
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save

			@agendamiento_log = AgAgendamientoLogEstados.new
			@agendamiento_log.responsable = @usuario
			@agendamiento_log.agendamiento_estado = @estadoAgendamiento
			@agendamiento_log.agendamiento = @agendamiento
			@agendamiento_log.fecha = DateTime.current
			@agendamiento_log.save
		end
		
		render :text=> respuesta
	end

	def confirmarHora
		#Posible problema por transacciones
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora confirmada").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		
		@agendamiento.transaction do
			respuesta="1"
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save			
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @responsable 
		@agendamiento_log.agendamiento_estado = @estadoAgendamiento
		@agendamiento_log.agendamiento = @agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save
		
		render :text=> respuesta
	end

	def marcarLlegada
		#Posible problema por transacciones
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente en espera").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@agendamiento.transaction do
			respuesta = "1"
			@agendamiento.fecha_llegada_paciente = DateTime.current 
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save			
		end

		#Simulación de prestación I-Med
		@valor = 20000
		@prestacion = @agendamiento.especialidad_prestador_profesional.especialidad.prestacion
		@pre_atencion_pagada = PreAtencionesPagadas.new
		@pre_atencion_pagada.agendamiento = @agendamiento
		@pre_atencion_pagada.prestacion = @prestacion 
		@pre_atencion_pagada.valor = @valor
		@pre_atencion_pagada.monto_pago_profesional = @agendamiento.especialidad_prestador_profesional.getMontoPagoProfesional(@valor,DateTime.current)
		@pre_atencion_pagada.fecha_pago = DateTime.current
		@pre_atencion_pagada.prevision_salud = @agendamiento.persona.getPrevisionSalud
		@pre_atencion_pagada.save!
		# Fin Simulación de prestación I-Med

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @responsable
		@agendamiento_log.agendamiento_estado = @estadoAgendamiento
		@agendamiento_log.agendamiento = @agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save
		
		render :text => respuesta
	end	

	def prepararIngreso
		@agendamiento = AgAgendamientos.find(params[:agendamiento_id])

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
		
	end	

	def bloquearHora
		#validar que tiene los permisos para bloquear una hora
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora bloqueada").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@agendamiento.transaction do
			respuesta = "1"
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save	
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @responsable 
		@agendamiento_log.agendamiento_estado = @estadoAgendamiento
		@agendamiento_log.agendamiento = @agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save

		render :text => respuesta
	end
		
	def desbloquearHora
		#validar que tiene los permisos para bloquear una hora
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora disponible").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@agendamiento.transaction do
			respuesta = "1"
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.save
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = PerPersonas.find(@responsable) 
		@agendamiento_log.agendamiento_estado = @estadoAgendamiento
		@agendamiento_log.agendamiento = @agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save

		render :text=> respuesta
	end

	def detalleEvento
		
		@content = params[:content].blank? ? 'modal-content-2' : params[:content]
		perm_paciente = false
		perm_profesional = false
		perm_admin_genera = tieneRol('Generar agendamientos')
		perm_admin_confirma = tieneRol('Confirmar agendamientos')
		perm_admin_recibe = tieneRol('Recibir pacientes')
		perm_admin_bloquea = tieneRol('Bloquear horas')
		perm_tomar_horas = tieneRol('Tomar horas')
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first		
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		estado = @agendamiento.estado.nombre	
		if @agendamiento.persona
			perm_paciente = (@usuario.id == @agendamiento.persona.id) || (@usuario.id == @agendamiento.quien_pide_hora.id ) ? true : false 	
		end 
		if @agendamiento.especialidad_prestador_profesional
			perm_profesional = (@usuario.id == @agendamiento.especialidad_prestador_profesional.profesional_id)? true : false 	
		end

		@permisos = Hash.new
		@permisos['tomar_hora_paciente'] = (estado == 'Hora disponible' and !esAdministrativo and !esProfesionalSalud) ? true : false
		@permisos['tomar_hora_admin'] = (perm_tomar_horas and estado == 'Hora disponible') ? true : false
		@permisos['admin_bloquea'] =  ((['Hora disponible','Hora bloqueada' ].include?(estado)) and (perm_admin_bloquea)) ? true : false 
		@permisos['info_paciente'] = ((!['Hora disponible','Hora bloqueada' ].include?(estado)) and (perm_paciente or perm_profesional)) ? true : false 
		@permisos['info_paciente_vista_admin'] =  ( (!['Hora disponible','Hora bloqueada' ].include?(estado)) and (perm_admin_confirma or perm_admin_recibe or perm_tomar_horas) ) ? true : false 
		@permisos['profesional'] = perm_profesional
		@permisos['admin_genera'] = perm_admin_genera

		respond_to do |format|     
    	format.js   {}    	
    	format.json { render :json => { :success => true} }
    end	
	end

	def modificarEvento

		fecha_comienzo = DateTime.strptime(params[:start],'%Y-%m-%d %H:%M:%S')
		fecha_final = DateTime.strptime(params[:end],'%Y-%m-%d %H:%M:%S')

		@agendamiento = AgAgendamientos.find(params[:agendamiento_id])
		@agendamiento.fecha_comienzo = fecha_comienzo
		@agendamiento.fecha_final = fecha_final
		@agendamiento.save


		respond_to do |format|   
    	format.json { render :json => { :success => true} }
    end	
	end


	def agregarNuevaHora 	
		
    @especialidad_prestador_profesional = PrePrestadorProfesionales.where(" prestador_id = ? AND profesional_id = ? AND especialidad_id = ?",params[:prestador_id],params[:profesional_id],params[:especialidad_id]).first
    events = []
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora disponible").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		@accion_masiva = AgAccionMasiva.new
		@accion_masiva.responsable = @responsable
		@accion_masiva.especialidad_prestador_profesional = @especialidad_prestador_profesional					
		@accion_masiva.estado = 'creada'
		@accion_masiva.agendamientos_eliminados = 0
		@accion_masiva.agendamientos_sin_eliminar = 0
		@accion_masiva.save
		contador = 0 

		if params[:tipo]=='diario'			
			fecha_comienzo = DateTime.strptime(params[:date_i],'%Y-%m-%d %H:%M:%S.%L')
			fecha_termino = DateTime.strptime(params[:date_f],'%Y-%m-%d %H:%M:%S.%L')
			step = params[:step]
			ActiveRecord::Base.transaction do
				while fecha_comienzo < fecha_termino do
					tmp_i = fecha_comienzo
					tmp_f = fecha_comienzo + step.to_i.minutes
					#Agregar filtro que permita validar que se pueda colocar esta hora o incluso fuera del paréntesis para que se rechacen todas las horas (de ser necesario)

					@agendamiento = AgAgendamientos.new
					@agendamiento.fecha_comienzo = tmp_i
					@agendamiento.fecha_final = tmp_f
					@agendamiento.estado = @estadoAgendamiento
					@agendamiento.especialidad_prestador_profesional = @especialidad_prestador_profesional
					@agendamiento.accion_masiva = @accion_masiva
					@agendamiento.save
					contador += 1

					@agendamiento_log = AgAgendamientoLogEstados.new
					@agendamiento_log.responsable = @responsable 
					@agendamiento_log.agendamiento_estado = @estadoAgendamiento
					@agendamiento_log.agendamiento = @agendamiento
					@agendamiento_log.fecha = DateTime.current
					@agendamiento_log.save

					events << @agendamiento.event(true)
					fecha_comienzo = tmp_f
				end 
			end 
		elsif params[:tipo]=='directo'			
			fecha_comienzo = DateTime.strptime(params[:start],'%Y-%m-%d %H:%M:%S')
			fecha_termino = DateTime.strptime(params[:end],'%Y-%m-%d %H:%M:%S')

			@agendamiento = AgAgendamientos.new
			@agendamiento.fecha_comienzo = fecha_comienzo
			@agendamiento.fecha_final = fecha_termino
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.especialidad_prestador_profesional = @especialidad_prestador_profesional
			@agendamiento.accion_masiva = @accion_masiva
			@agendamiento.save

			@agendamiento_log = AgAgendamientoLogEstados.new
			@agendamiento_log.responsable = @responsable 
			@agendamiento_log.agendamiento_estado = @estadoAgendamiento
			@agendamiento_log.agendamiento = @agendamiento
			@agendamiento_log.fecha = DateTime.current
			@agendamiento_log.save

			contador += 1

			events << @agendamiento.event(true)

		elsif params[:tipo]=='comportamiento'

			fecha_inicio = DateTime.strptime(params[:date_i],'%Y-%m-%d %H:%M:%S.%L')
			fecha_final = DateTime.strptime(params[:date_f],'%Y-%m-%d %H:%M:%S.%L')
			step = params[:step]
			daysOfWeek = JSON.parse(params[:days])
			hora_inicio = params[:hora_i]
			hora_termino = params[:hora_t]			

			days = []
			d_i = fecha_inicio
			d_f = fecha_final
			while d_i < d_f do
				tmp_i = d_i
				tmp_f = d_i+1.days
				days << tmp_i if daysOfWeek[tmp_i.strftime("%w").to_i]
				d_i = tmp_f
			end

			ActiveRecord::Base.transaction do
				days.each do |d|
					tmp = d.strftime("%Y-%m-%d")+" "+hora_inicio
					d_i = DateTime.strptime(tmp,"%Y-%m-%d %H:%M")
					tmp = d.strftime("%Y-%m-%d")+" "+hora_termino
					d_f = DateTime.strptime(tmp,"%Y-%m-%d %H:%M")
					d_f = d_f + 1.days if d_f <= d_i						
					fecha_comienzo = d_i
					fecha_termino = d_f
					
					while fecha_comienzo < fecha_termino do
						tmp_i = fecha_comienzo
						tmp_f = fecha_comienzo + step.to_i.minutes
						#Agregar filtro que permita validar que se pueda colocar esta hora o incluso fuera del paréntesis para que se rechacen todas las horas (de ser necesario)

						@agendamiento = AgAgendamientos.new
						@agendamiento.fecha_comienzo = tmp_i
						@agendamiento.fecha_final = tmp_f
						@agendamiento.estado = @estadoAgendamiento
						@agendamiento.especialidad_prestador_profesional = @especialidad_prestador_profesional
						@agendamiento.accion_masiva = @accion_masiva
						@agendamiento.save
						contador += 1
						
						@agendamiento_log = AgAgendamientoLogEstados.new
						@agendamiento_log.responsable = @responsable
						@agendamiento_log.agendamiento_estado = @estadoAgendamiento
						@agendamiento_log.agendamiento = @agendamiento
						@agendamiento_log.fecha = DateTime.current
						@agendamiento_log.save

						events << @agendamiento.event(true)
						fecha_comienzo = tmp_f
					end 
				end 
			end			

		end

		@accion_masiva.total_agendamientos = contador
		@accion_masiva.save

		respond_to do |format|
			format.json { render json: events }
		end
	
	end 

	def cargarCancelarAccion
		agendamientos_eliminados = 0
		agendamientos_sin_eliminar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])
		@accion_masiva.agendamientos.each do |agendamiento|
			agendamiento.estado.nombre == 'Hora disponible' ? agendamientos_eliminados += 1 : agendamientos_sin_eliminar += 1
		end	
		@accion_masiva.agendamientos_eliminados = agendamientos_eliminados
		@accion_masiva.agendamientos_sin_eliminar = agendamientos_sin_eliminar
		@accion_masiva.save

		respond_to do |format|     
    	format.js   {}
    end	
	end	

	def cargarVistaSinCancelar
		agendamientos_eliminados = 0
		agendamientos_sin_eliminar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])
		@accion_masiva.agendamientos.each do |agendamiento|
			agendamiento.estado.nombre == 'Hora disponible' ? agendamientos_eliminados += 1 : agendamientos_sin_eliminar += 1
		end	
		@accion_masiva.agendamientos_eliminados = agendamientos_eliminados if @accion_masiva.estado == 'creada'
		@accion_masiva.agendamientos_sin_eliminar = agendamientos_sin_eliminar
		@accion_masiva.save

		respond_to do |format|     
    	format.js   {}
    end	
	end	

	def cancelarAccionMasiva
		@estadoAgendamiento=  AgAgendamientoEstados.where("nombre = ?","Hora eliminada").first
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		agendamientos_eliminados = 0
		agendamientos_sin_eliminar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])

		@accion_masiva.agendamientos.each do |agendamiento|
			if ['Hora disponible','Hora cancelada'].include?(agendamiento.estado.nombre)
				agendamientos_eliminados += 1
				
				agendamiento.estado = @estadoAgendamiento
				agendamiento.save

				@agendamiento_log = AgAgendamientoLogEstados.new
				@agendamiento_log.responsable = @usuario
				@agendamiento_log.agendamiento_estado = @estadoAgendamiento
				@agendamiento_log.agendamiento = @agendamiento
				@agendamiento_log.fecha = DateTime.current
				@agendamiento_log.save				

			else
				agendamientos_sin_eliminar += 1
			end 
		end
		@accion_masiva.estado = agendamientos_sin_eliminar == 0 ? 'cancelada completa' : 'cancelada incompleta'
		@accion_masiva.agendamientos_eliminados = agendamientos_eliminados
		@accion_masiva.agendamientos_sin_eliminar = agendamientos_sin_eliminar
		@accion_masiva.save!

		respond_to do |format|     
    	format.js   {}    	
    	format.json { render :json => { :success => true} }
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

	def cargarPacientes		

		per = []  	
		term = params[:q]

		@pacientes = PerPersonas.where("rut LIKE ? OR concat(nombre,' ',apellido_paterno,' ',apellido_materno) LIKE ? ","%#{term}%","%#{term}%")			
		
		@pacientes.each do |p|
			per<< p.formato_personas			
		end

		respond_to do |format|
			format.json { render json: per}
		end
				
	end

end