class HomeController < ApplicationController

	include ApplicationHelper

	def actualizarAtenciones

		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
		@actualizaciones = AgAgendamientoLogEstados
			.joins(:agendamiento)
			.select("ag_agendamiento_log_estados.fecha,
							 ag_agendamiento_log_estados.agendamiento_estado_id,
							 ag_agendamiento_log_estados.responsable_id,
							 ag_agendamientos.persona_id")
			.where( "fecha > ? AND ag_agendamientos.especialidad_prestador_profesional_id = ? AND ag_agendamientos.fecha_comienzo BETWEEN ? AND ? ",
				 Date.today,@especialidad_prestador_profesional,Date.today, Date.tomorrow )
			.order(fecha: :desc)

		@hora_actual = DateTime.current
	

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true, :agendamientos => @agendamientos, :actualizaciones => @actualizaciones, :hora_actual => @hora_actual }	 }
    end
	end	

	def revisarActualizaciones

		llegadas = []
		lapso_tiempo = DateTime.current - 30.seconds
		especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		#agendamientos= AgAgendamientos.where( "especialidad_prestdor_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )

		actualizaciones = AgAgendamientos
			.joins(:agendamiento_log_estados)
			.where( "fecha > ? AND especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ",
				lapso_tiempo, especialidad_prestador_profesional,Date.today, Date.tomorrow )

	 	respuesta = false
  	actualizaciones.each do |act|
  		respuesta = true
  		if (act.agendamiento_estado.id == 5)
  			llegadas << act.format
  		end
  	end	
									
		respond_to do |format|     
    	format.json { render :json => { :success => true, :respuesta => respuesta, :llegadas => llegadas} }
    end						

	end	

	def index

		if user_signed_in?
			if tieneRol('Generar agendamientos')
				render 'index_agendamiento'
		  elsif esProfesionalSalud 
		  	@hora_actual = DateTime.current
				@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
				@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
  			@actualizaciones = AgAgendamientoLogEstados
					.joins(:agendamiento)
					.select("ag_agendamiento_log_estados.fecha,
									 ag_agendamiento_log_estados.agendamiento_estado_id,
									 ag_agendamiento_log_estados.responsable_id,
									 ag_agendamientos.persona_id")
					.where( "ag_agendamiento_log_estados.agendamiento_estado_id not in (1) AND fecha > ? AND ag_agendamientos.especialidad_prestador_profesional_id = ? AND ag_agendamientos.fecha_comienzo BETWEEN ? AND ?",
						 Date.today,@especialidad_prestador_profesional,Date.today, Date.tomorrow )
					.order(fecha: :desc)
  			render 'index_profesional'
		  else	
		  	render 'index_persona'
		  end 	
		else
			render 'index', :layout => false
		end 	
		
	end
end
