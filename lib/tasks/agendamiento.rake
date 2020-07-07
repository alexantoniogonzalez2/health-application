namespace :agendamiento do
  
  desc "Crear mes de Agendamiento"
  task crear_agendamientos: :environment do
		crearAgendamientos('10:00','12:00',"Hora disponible",1)
		crearAgendamientos('11:00','13:00',"Hora disponible",2)
		crearAgendamientos('12:00','13:00',"Paciente en espera",1)
		crearAgendamientos('13:00','14:00',"Paciente en espera",2)
		crearAgendamientos('11:00','12:00',"Paciente atendido",1) 
		crearAgendamientos('11:00','12:00',"Paciente atendido",2)
		crearAgendamientos('10:00','12:00',"Hora disponible",6)
		crearAgendamientos('11:00','13:00',"Hora disponible",7)
		crearAgendamientos('12:00','13:00',"Paciente en espera",6)
		crearAgendamientos('13:00','14:00',"Paciente en espera",7)
		crearAgendamientos('11:00','12:00',"Paciente atendido",6) 
		crearAgendamientos('11:00','12:00',"Paciente atendido",7)
  end

  def crearAgendamientos (hora_inicio,hora_termino,estado,esp_pre_pro)

  	if estado == "Paciente atendido"
			fecha_final = DateTime.current
			fecha_inicio = fecha_final - 1.week
		else
			fecha_inicio = DateTime.current
			fecha_final = fecha_inicio + 2.month
		end
		
		step = 30
		daysOfWeek = [true,true,true,true,true,true,true]

		@especialidad_prestador_profesional = PrePrestadorProfesionales.find(esp_pre_pro)
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?",estado).first

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

					@agendamiento = AgAgendamientos.new
					@agendamiento.persona = PerPersonas.find(1) if (estado == "Paciente atendido" or estado == "Paciente en espera")
					@agendamiento.quien_pide_hora = PerPersonas.find(1) if (estado == "Paciente atendido" or estado == "Paciente en espera")
					@agendamiento.fecha_comienzo = tmp_i
					@agendamiento.fecha_final = tmp_f
					@agendamiento.estado = @estadoAgendamiento
					@agendamiento.especialidad_prestador_profesional = @especialidad_prestador_profesional					
					
					if (estado == "Paciente atendido" )
						@agendamiento.fecha_comienzo_real = tmp_i
						@agendamiento.fecha_final_real = tmp_f	
						@agendamiento.save
						@persona = @agendamiento.persona
						@atencion_salud = FiAtencionesSalud.new(:agendamiento_id => @agendamiento.id,:persona_id => @persona.id, :tipo_ficha_id => 1)				
					  @atencion_salud.save!									
					else
						@agendamiento.save!
					end	
					
					@agendamiento_log = AgAgendamientoLogEstados.new
					@agendamiento_log.responsable = PerPersonas.find(8) 
					@agendamiento_log.agendamiento_estado = @estadoAgendamiento
					@agendamiento_log.agendamiento = @agendamiento
					@agendamiento_log.fecha = DateTime.current
					@agendamiento_log.save!
					fecha_comienzo = tmp_f

					#Simulación de prestación I-Med
					if estado == "Paciente atendido"
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
					end
					# Fin Simulación de prestación I-Med


				end #while
			end #days.each
		end #transaction

  end	

end
