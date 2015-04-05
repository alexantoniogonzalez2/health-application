class VacunasController < ApplicationController
	def index
		@partial_seguimiento = ''
		@persona = PerPersonas.where('user_id = ?',current_user.id).first
		@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																				 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																				 .where('persona_id = ?',@persona.id)
		 
		@agno = FiCalendarioVacunas.maximum('agno')
		@calendario_vacunas_lactante = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
																		.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
																		.where('edad in ("Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
																		.order('fi_calendario_vacunas.id ASC')
		@calendario_vacunas_pediatricas = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
																.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
																.where('edad in ("1° básico","4° básico","8° básico") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
																.order('fi_calendario_vacunas.id ASC')
		@calendario_vacunas_adulto_mayor = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
														.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
														.where('edad in ("Adulto de 65 años") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
														.order('fi_calendario_vacunas.id ASC')
														
		@grupo_etareo = @persona.getGrupoEtareo(DateTime.current)												
		case @grupo_etareo
    when 'Recién nacido','Lactante'
    	@partial_seguimiento = 'lactante'
    when 'Pediatria' 
      @partial_seguimiento = 'pediatria'
    when 'Adolescente','Adulto' 
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
		@agno = FiCalendarioVacunas.maximum('agno')
		@calendario_vacuna = FiCalendarioVacunas.where('id = ? AND agno = ?',params[:vac],@agno).first
		@persona = PerPersonas.where('user_id = ?',current_user.id).first
		if params[:estado] == 'true'			
			@persona_vacuna_nueva = FiPersonasVacunas.new
			@persona_vacuna_nueva.persona = @persona
			@persona_vacuna_nueva.vacuna = MedVacunas.find(@calendario_vacuna.vacuna.id)
			@persona_vacuna_nueva.fecha = DateTime.current
			@persona_vacuna_nueva.numero_vacuna = @calendario_vacuna.numero_vacuna
			@persona_vacuna_nueva.save!

			@persona_vacuna = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																		 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																		 .where('fi_personas_vacunas.id = ?',@persona_vacuna_nueva.id).first

			respond_to do |format|     
      	format.js { }
      	format.json { render :json => { :success => true, :persona_vacuna => @persona_vacuna } }
      end	
		else
			@persona_vacuna_quitar = FiPersonasVacunas.where('persona_id = ? AND vacuna_id = ? AND (numero_vacuna = ? or numero_vacuna is null)',@persona.id, @calendario_vacuna.vacuna.id, @calendario_vacuna.numero_vacuna).first
			id_quitar = @persona_vacuna_quitar.id 
			@persona_vacuna_quitar.destroy
			respond_to do |format|
				format.json { render json: id_quitar}
			end
		end		
	end
end
