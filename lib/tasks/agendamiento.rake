namespace :agendamiento do
  desc "Crear Mes de Agendamiento"
  task crear_agendamientos: :environment do  	
		fecha_inicio = DateTime.current
		fecha_final = fecha_inicio + 1.month
		step = 30
		daysOfWeek = [true,true,true,true,true,true,true]
		hora_inicio = '10:00'
		hora_termino = '12:00'
		@especialidad_prestador_profesional = PrePrestadorProfesionales.find(1)
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Hora disponible").first

		days = []
		d_i = fecha_inicio
		d_f = fecha_final
		while d_i < d_f do
			tmp_i = d_i
			tmp_f = d_i+1.days
			if daysOfWeek[tmp_i.strftime("%w").to_i]
				days << tmp_i
			end
			d_i=tmp_f
		end

		ActiveRecord::Base.transaction do
			days.each do |d|
				tmp = d.strftime("%Y-%m-%d")+" "+hora_inicio
				d_i = DateTime.strptime(tmp,"%Y-%m-%d %H:%M")
				tmp = d.strftime("%Y-%m-%d")+" "+hora_termino
				d_f = DateTime.strptime(tmp,"%Y-%m-%d %H:%M")
				if d_f <= d_i
					d_f = d_f + 1.days
				end

				fecha_comienzo = d_i
				fecha_termino = d_f
				while fecha_comienzo < fecha_termino do
					tmp_i = fecha_comienzo
					tmp_f = fecha_comienzo + step.to_i.minutes
					#Aquí debiera existir un filtro que permita validar que se pueda colocar esta hora
					#o incluso fuera del paréntesis para que se rechacen todas las horas (de ser necesario)

					@Agendamiento = AgAgendamientos.new
					@Agendamiento.persona = PerPersonas.find(1) 
					@Agendamiento.fecha_comienzo = tmp_i
					@Agendamiento.fecha_final = tmp_f
					@Agendamiento.agendamiento_estado = @estadoAgendamiento
					@Agendamiento.especialidad_prestador_profesional = @especialidad_prestador_profesional
					@Agendamiento.save
					
					@agendamiento_log = AgAgendamientoLogEstados.new
					@agendamiento_log.responsable = PerPersonas.find(8) 
					@agendamiento_log.agendamiento_estado = @EstadoAgendamiento
					@agendamiento_log.agendamiento = @Agendamiento
					@agendamiento_log.fecha = DateTime.current
					@agendamiento_log.save

					fecha_comienzo=tmp_f
				end #while
			end #days.each
		end #transaction
  end

end
