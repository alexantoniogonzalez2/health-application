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
			if params[:especialidad] == ""
				PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales)").order('nombre,apellido_paterno,apellido_materno').each do |p|
				resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";	
				end 
			else			
				PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales where especialidad_id= ? )",params[:especialidad]).order('nombre,apellido_paterno,apellido_materno').each do |p|
				resp<<"<option value=\"#{p.id}\">#{p.showName('%n%p%m')}</option>";
				end 
			end		
		end	

		render :text =>resp	
	end

	def buscarHoras
		
		events=[]

		if params[:centros] != ''
			if params[:especialidad] != '' and params[:especialista] != ''
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.profesional_id = ? ",params[:especialidad],params[:especialista])
			elsif params[:especialidad] != ''
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ?",params[:especialidad] )
			elsif params[:especialista] != '' 	
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ?",params[:especialista] )
			end
		else	
			if params[:especialidad] != '' and params[:especialista] != ''
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.profesional_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) ",params[:especialidad],params[:especialista],params[:centros] )
			elsif params[:especialidad] != ''
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) ",params[:especialidad],params[:centros] )
			elsif params[:especialista] != '' 	
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ? AND pre_prestador_profesionales.prestador_id IN  ( ? ) ",params[:especialista],params[:centros] )
			end
		end

		@Fechas.each do |f|
			events << f.event				
		end

		respond_to do |f|
			f.json {render json:events}
		end	
		
	end

	def buscarHorasProfesional
		
		events=[]
		@profesional = PerPersonas.where('user_id = ?',current_user.id).first
		@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.profesional_id = ?",@profesional.id)
		
		@Fechas.each do |f|
			events << f.event				
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
		
		if params[:evento_id]
			@Agendamiento=AgAgendamientos.where("id = ?",params[:evento_id]).first
			events=[]

			events << @Agendamiento.event
			respond_to do |f|
				f.json {render json:events}
			end

		else
			if params[:prestador_id] != "-1" and params[:especialidad_id] != "-1"
				events=[]
				@Fechas=AgAgendamientos.joins(:especialidad_prestador_profesional).where("pre_prestador_profesionales.especialidad_id = ? AND pre_prestador_profesionales.prestador_id = ? AND pre_prestador_profesionales.profesional_id = ?  ",params[:especialidad_id],params[:prestador_id],params[:profesional_id])
				#Filtrar por fechas si no quiere mostrarse todo (Puede ser algo como un año hacia adelante y un año hacia atrás)

				@Fechas.each do |f|
					events << f.event				
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

		#Posible problema por transacciones
		@antecedente = params[:antecedente]
		respuesta="0"
		if params[:persona_hora].blank?
			@persona = params[:paciente].blank? ? PerPersonas.where('user_id = ?',current_user.id).first : PerPersonas.find(params[:paciente])
		else
			if params[:persona_hora] == "Para mi"
				@persona = PerPersonas.where('user_id = ?',current_user.id).first				
			else
				@antecedente = ''
				@persona = PerPersonas.find(params[:persona_hora])
			end	
		end

		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		@Agendamiento=AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora reservada").first
		@Agendamiento.transaction do
			if @Agendamiento.agendamiento_estado.nombre=='Hora disponible'
				respuesta="1"
				@Agendamiento.persona= @persona
				@Agendamiento.agendamiento_estado= @EstadoAgendamiento
				@Agendamiento.motivo_consulta_nuevo = params[:motivo]		
				@Agendamiento.persona_diagnostico_control = FiPersonaDiagnosticos.find(@antecedente) unless @antecedente.blank?
				@Agendamiento.capitulo_cie10_control = MedDiagnosticosCapitulos.find(params[:capitulo_cie_10]) unless params[:capitulo_cie_10].blank?
				@Agendamiento.save

				@agendamiento_log = AgAgendamientoLogEstados.new
				@agendamiento_log.responsable = @responsable
				@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
				@agendamiento_log.agendamiento = @Agendamiento
				@agendamiento_log.fecha = DateTime.current
				@agendamiento_log.save
			else
				respuesta="2"
			end
		end
		
		render :text=> respuesta
	end

	def cancelarHora

		#Posible problema por transacciones
		perm_paciente = false
		respuesta="0"
		@Agendamiento=AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamientoLog=AgAgendamientoEstados.where("nombre = ?","Hora cancelada").first
		@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora bloqueada").first
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first

		#Si fue cancelada por el mismo paciente queda inmediatamente disponible
		if (@Agendamiento.persona)
			perm_paciente = (@usuario.id == @Agendamiento.persona.id)? true : false 	
		end 		
		if perm_paciente
			@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora disponible").first
		end	

		@Agendamiento.transaction do
			respuesta="1"
			@Agendamiento.persona=nil
			@Agendamiento.agendamiento_estado=@EstadoAgendamiento
			@Agendamiento.save			
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @usuario
		@agendamiento_log.agendamiento_estado = @EstadoAgendamientoLog
		@agendamiento_log.agendamiento = @Agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save
		
		render :text=> respuesta
	end

	def confirmarHora
		#Posible problema por transacciones
		respuesta="0"
		@Agendamiento=AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora confirmada").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		
		@Agendamiento.transaction do
			respuesta="1"
			@Agendamiento.agendamiento_estado=@EstadoAgendamiento
			@Agendamiento.save			
		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @responsable 
		@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
		@agendamiento_log.agendamiento = @Agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save
		
		render :text=> respuesta
	end

	def marcarLlegada
		#Posible problema por transacciones
		respuesta = "0"
		@agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente en espera").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@agendamiento.transaction do
			respuesta = "1"
			@agendamiento.fecha_llegada_paciente = DateTime.current 
			@agendamiento.agendamiento_estado = @EstadoAgendamiento
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
		@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
		@agendamiento_log.agendamiento = @Agendamiento
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
		respuesta="0"
		@Agendamiento=AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora bloqueada").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@Agendamiento.transaction do
			respuesta="1"
			@Agendamiento.agendamiento_estado=@EstadoAgendamiento
			@Agendamiento.save	

		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = @responsable 
		@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
		@agendamiento_log.agendamiento = @Agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save

		render :text=> respuesta
	end
		
	def desbloquearHora
		#validar que tiene los permisos para bloquear una hora
		respuesta="0"
		@Agendamiento=AgAgendamientos.where("id= ?",params[:agendamiento_id]).first
		@EstadoAgendamiento=AgAgendamientoEstados.where("nombre = ?","Hora disponible").first
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@Agendamiento.transaction do
			respuesta="1"
			@Agendamiento.agendamiento_estado=@EstadoAgendamiento
			@Agendamiento.save	

		end

		@agendamiento_log = AgAgendamientoLogEstados.new
		@agendamiento_log.responsable = PerPersonas.find(@responsable) 
		@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
		@agendamiento_log.agendamiento = @Agendamiento
		@agendamiento_log.fecha = DateTime.current
		@agendamiento_log.save

		render :text=> respuesta
	end

	def detalleEvento
		
		tmp = '';
		perm_paciente = false
		perm_profesional = false
		perm_admin_genera = tieneRol('Generar agendamientos')
		perm_admin_confirma = tieneRol('Confirmar agendamientos')
		perm_admin_recibe = tieneRol('Recibir pacientes')
		perm_admin_bloquea = tieneRol('Bloquear horas')
		perm_tomar_horas = tieneRol('Tomar horas')
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		
		@Agendamiento = AgAgendamientos.where("id= ?",params[:agendamiento_id]).first	

		if (@Agendamiento.persona)
			perm_paciente = (@usuario.id == @Agendamiento.persona.id) || (@usuario.id == @Agendamiento.agendamiento_log_estados.where(agendamiento_estado: 3 ).first.responsable_id ) ? true : false 	
		end 
		if (@Agendamiento.especialidad_prestador_profesional)
			perm_profesional = (@usuario.id == @Agendamiento.especialidad_prestador_profesional.profesional_id)? true : false 	
		end 
			
		tmp<<@Agendamiento.detalleHTML(perm_admin_genera,perm_admin_confirma,perm_admin_recibe,perm_admin_bloquea,perm_tomar_horas,perm_paciente,perm_profesional,@usuario.id)
		
		if tmp.length >0 
			render :text=> tmp
		else
			flash[:tipo]="Agendamiento#detalleEvento"
		
			respond_to do |format|
				format.html {render "application/errors",layout:false}
			
			end
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
		@accion_masiva.agendamientos_cancelados = 0
		@accion_masiva.agendamientos_sin_cancelar = 0
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
					@agendamiento.agendamiento_estado = @estadoAgendamiento
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

					events << @agendamiento.event
					fecha_comienzo = tmp_f
				end 
			end 

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
						@agendamiento.agendamiento_estado = @estadoAgendamiento
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

						events << @agendamiento.event
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
		agendamientos_cancelados = 0
		agendamientos_sin_cancelar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])
		@accion_masiva.agendamientos.each do |agendamiento|
			agendamiento.agendamiento_estado.nombre == 'Hora disponible' ? agendamientos_cancelados += 1 : agendamientos_sin_cancelar += 1
		end	
		@accion_masiva.agendamientos_cancelados = agendamientos_cancelados
		@accion_masiva.agendamientos_sin_cancelar = agendamientos_sin_cancelar
		@accion_masiva.save

		respond_to do |format|     
    	format.js   {}
    end	
	end	

	def cargarVistaSinCancelar
		agendamientos_cancelados = 0
		agendamientos_sin_cancelar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])
		@accion_masiva.agendamientos.each do |agendamiento|
			agendamiento.agendamiento_estado.nombre == 'Hora disponible' ? agendamientos_cancelados += 1 : agendamientos_sin_cancelar += 1
		end	
		@accion_masiva.agendamientos_cancelados = agendamientos_cancelados
		@accion_masiva.agendamientos_sin_cancelar = agendamientos_sin_cancelar
		@accion_masiva.save

		respond_to do |format|     
    	format.js   {}
    end	
	end	

	def cancelarAccionMasiva
		agendamientos_cancelados = 0
		agendamientos_sin_cancelar = 0
		@accion_masiva = AgAccionMasiva.find(params[:accion_masiva])
		@accion_masiva.agendamientos.each do |agendamiento|
			if agendamiento.agendamiento_estado.nombre == 'Hora disponible'
				agendamientos_cancelados += 1
				agendamiento.destroy
			else
				agendamientos_sin_cancelar += 1
			end 
		end
		@accion_masiva.estado = agendamientos_sin_cancelar == 0 ? 'cancelada completa' : 'cancelada incompleta'
		@accion_masiva.save

		respond_to do |format|     
    	format.js   {}    	
    	format.json { render :json => { :success => true} }
    end		

	end	

end