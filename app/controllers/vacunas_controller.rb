class VacunasController < ApplicationController
	def index
		@persona = PerPersonas.find(current_user.id)
		@personas_vacunas = FiPersonasVacunas.where('persona_id = ?',current_user.id)
		@grupo_etareo = @persona.getGrupoEtareo(DateTime.current) 
	end	
	def calendario
		@calendarios = {}
		@agnos = FiCalendarioVacunas.select('DISTINCT agno as agno')		
		@agnos.each do |agno|
			@calendarios[agno.agno] = {} 
			@calendario_vacunas = FiCalendarioVacunas.where('agno = ?',agno.agno)
			contador = -1
			@calendario_vacunas.each do |calendario_vacuna|
				contador = contador + 1
				@calendarios[agno.agno][contador] = {}				
				@calendarios[agno.agno][contador]['vacuna'] = calendario_vacuna.vacuna.nombre
				@calendarios[agno.agno][contador]['edad'] = calendario_vacuna.edad
			end	
		end		

	end
end
