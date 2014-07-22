class HomeController < ApplicationController

	include ApplicationHelper

	def actualizarAtenciones

		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true, :agendamientos => @agendamientos }	 }
    end


	end	

	def revisarActualizaciones
		lapso_tiempo = DateTime.current - 30.seconds
		especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		agendamientos= AgAgendamientos.where( "especialidad_prestdor_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )

=begin
actualizaciones = AgAgendamientos
			.joins('JOIN ag_agendamiento_log_estados ON 
								ag_agendamientos.id = ag_agendamiento_log_estados.agendamiento_id')
			.select("ag_agendamiento_log_estados.responsable_id,
							 ag_agendamiento_log_estados.agendamiento_estado_id,
							 ag_agendamiento_log_estados.agendamiento_id,
							 ag_agendamiento_log_estados.fecha,
							 ag_agendamientos.persona_id")
			.where( "fecha > ? AND especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ",
				lapso_tiempo, especialidad_prestador_profesional,Date.today, Date.tomorrow )

						#logger.debug "New post: #{@persona_diagnostico_anteriores}"	
	
=end

		actualizaciones = AgAgendamientos
			.joins(:agendamiento_log_estados)
			.where( "fecha > ? AND especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ",
				lapso_tiempo, especialidad_prestador_profesional,Date.today, Date.tomorrow )
			
  	#respuesta = actualizaciones.empty? ? true : false;
  	respuesta = false
  	actualizaciones.each do |act|
  		respuesta = true
  	end	
									
		respond_to do |format|     
    	format.json { render :json => { :success => true, :respuesta => respuesta}	 }
    end						

	end	

	def index

		if user_signed_in?
			if tieneRol('Generar agendamientos')
				render 'index_agendamiento'
		  elsif esProfesionalSalud 
				@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
				@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
  			@actualizaciones = AgAgendamientos
					.joins('JOIN ag_agendamiento_log_estados ON 
										ag_agendamientos.id = ag_agendamiento_log_estados.agendamiento_id')
					.select("ag_agendamiento_log_estados.responsable_id,
									 ag_agendamiento_log_estados.agendamiento_estado_id,
									 ag_agendamiento_log_estados.agendamiento_id,
									 ag_agendamiento_log_estados.fecha,
									 ag_agendamientos.persona_id")
					.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ",
						 @especialidad_prestador_profesional,Date.today, Date.tomorrow )
					.order("fecha DESC")
  			
  			render 'index_profesional'

		  else	
		  	render 'index_persona'
		  end 	
		else
			render 'index'
		end 	
		
	end
		


end
