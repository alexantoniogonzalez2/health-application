class AntecedentesController < ApplicationController
	def index
		
		@acceso = true
		@paciente = PerPersonas.find(current_user.id)		
		id_usuario = current_user.id
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso_ant_med = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona 
		end
		#Antecedentes médicos		
		@persona_diagnosticos = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																				JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																.select('fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,fi_persona_diagnosticos_atenciones_salud.fecha_inicio,fi_persona_diagnosticos_atenciones_salud.fecha_termino,md.nombre')
																																.where('fpd.persona_id = ?',id_usuario) if @acceso
		#Antecedentes quirúrgicos													
		min = 57
		max = 250	
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',id_usuario,min,max) if @acceso

		#Medicamentos	
		@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? ',id_usuario) if @acceso

		#Alergias
		@alergias = MedAlergias.all

	end
end
