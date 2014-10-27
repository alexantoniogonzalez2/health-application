class VacunasController < ApplicationController
	def index
		@partial_seguimiento = ''
		@persona = PerPersonas.find(current_user.id)
		@personas_vacunas = FiPersonasVacunas.where('persona_id = ?',current_user.id)
		@grupo_etareo = @persona.getGrupoEtareo(DateTime.current) 
		@agno = FiCalendarioVacunas.maximum('agno')
		@calendario_vacunas_lactante = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas as fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna')
																		.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
																		.where('edad in ("Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,current_user.id)
		case @grupo_etareo
    when 'Recién nacido','Lactante'
    	@partial_seguimiento = 'lactante'
    when 'Pediatria' 
      @partial_seguimiento = 'pediatria'
    when 'Adolescente','Adulto' 
    	@partial_seguimiento = 'lactante'     
    when 'Adulto mayor'
    	@partial_seguimiento = 'adulto_mayor'
    end

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
				@calendarios[agno.agno][contador]['id'] = calendario_vacuna.id				
				@calendarios[agno.agno][contador]['nombre'] = calendario_vacuna.vacuna.nombre
				@calendarios[agno.agno][contador]['edad'] = calendario_vacuna.edad
				@calendarios[agno.agno][contador]['numero_vacuna'] = calendario_vacuna.numero_vacuna
				@calendarios[agno.agno][contador]['protege_contra'] = calendario_vacuna.vacuna.protege_contra
			end	
		end	
	end
	def otras_vacunas
		@otras_vacunas = MedVacunas.where('tipo != ?','pni')			
	end
	def actualizar
		respond_to do |format|
			format.json { render :json => { :success => true }	}
		end
	end
end
