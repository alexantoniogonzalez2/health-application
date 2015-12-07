class VacunasController < ApplicationController
	def index
		@partial_seguimiento = ''
		@persona = PerPersonas.where('user_id = ?',current_user.id).first
		@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																				 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																				 .where('persona_id = ?',@persona.id)
		@personas_vacunas_otras = FiPersonasVacunas.joins('JOIN med_vacunas AS mv ON fi_personas_vacunas.vacuna_id = mv.id')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,mv.tipo as edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ? AND mv.tipo != ?',@persona.id,'pni')
														
		@grupo_etareo = @persona.getGrupoEtareo(DateTime.current)
		@agno = FiCalendarioVacunas.maximum('agno')
		@array_grupo = []																									
		case @grupo_etareo
    when 'Recién nacido','Lactante'
    	@partial_seguimiento = 'lactante'    	
			@array_grupo = ["Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses"]
    when 'Pediatria' 
      @partial_seguimiento = 'pediatria'
		  @array_grupo = ["1° básico","4° básico","8° básico"]
    when 'Adolescente','Adulto' 
    when 'Adulto mayor'
    	@partial_seguimiento = 'adulto_mayor'
    	@array_grupo = ["Adulto de 65 años"]
    end
    @calendario_vacunas_persona = FiCalendarioVacunas.where('edad in (?) AND agno = ? ',@array_grupo,@agno).order(id: :asc)
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
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		if params[:tipo] == 'calendario'
			@agno = FiCalendarioVacunas.maximum('agno')
			@calendario_vacuna = FiCalendarioVacunas.where('id = ? AND agno = ?',params[:vac],@agno).first
		end	

		@estado = params[:estado]

		if params[:estado] == 'true'			
			@persona_vacuna_nueva = FiPersonasVacunas.new
			@persona_vacuna_nueva.persona = @persona
			@persona_vacuna_nueva.fecha = DateTime.current
			@persona_vacuna_nueva.vacuna = MedVacunas.find(@calendario_vacuna.vacuna.id) if params[:tipo] == 'calendario'
			@persona_vacuna_nueva.vacuna = MedVacunas.find(params[:vac]) if params[:tipo] == 'otras'
			@persona_vacuna_nueva.numero_vacuna = @calendario_vacuna.numero_vacuna if params[:tipo] == 'calendario'
			@persona_vacuna_nueva.save! 

			if params[:tipo] == 'calendario'
				@persona_vacuna = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																		 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																		 .where('fi_personas_vacunas.id = ?',@persona_vacuna_nueva.id).first
			else
				@persona_vacuna = FiPersonasVacunas.joins('JOIN med_vacunas AS mv ON fi_personas_vacunas.vacuna_id = mv.id')
																		 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id, mv.tipo as edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																		 .where('fi_personas_vacunas.id = ?',@persona_vacuna_nueva.id).first
			end															 

			respond_to do |format|     
      	format.js { }
      	format.json { render :json => { :success => true } }
      end	
		else
			if params[:tipo] == 'calendario'
				@persona_vacuna_quitar = FiPersonasVacunas.where('persona_id = ? AND vacuna_id = ? AND (numero_vacuna = ? or numero_vacuna is null)',@persona.id, @calendario_vacuna.vacuna.id, @calendario_vacuna.numero_vacuna).first
			else
				@persona_vacuna_quitar = FiPersonasVacunas.where('persona_id = ? AND vacuna_id = ?',@persona.id, params[:vac]).first
			end	
			@id_quitar = @persona_vacuna_quitar.id 
			@persona_vacuna_quitar.destroy
			respond_to do |format|
				format.js { }
				format.json { render :json => { :success => true } }
			end
		end		
	end
end
