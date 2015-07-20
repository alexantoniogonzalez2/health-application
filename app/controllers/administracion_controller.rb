class AdministracionController < ApplicationController
	
	def generarBoletas

		@responsable = PerPersonas.where('user_id = ?',current_user.id).first

		@lista_atenciones = PreAtencionesPagadas.joins(:agendamiento)
									.select('pre_atenciones_pagadas.*, ag_agendamientos.especialidad_prestador_profesional_id')	
									.where('pre_atenciones_pagadas.id in (?)',params[:lista_atenciones])
									.order('especialidad_prestador_profesional_id')

		@lista_atenciones.chunk { |l| l.agendamiento.especialidad_prestador_profesional.id }.each do |epp, atenciones|
		  ids = atenciones.map { |a| a.id }
		  montos = atenciones.map { |a| a.monto_pago_profesional }
		  puts "#{ids.to_sentence} swear allegiance to House #{epp}."
		  ActiveRecord::Base.transaction do
		  	monto = montos.sum
		  	boleta = PreBoletas.new
		  	boleta.especialidad_prestador_profesional = PrePrestadorProfesionales.find(epp)
		  	boleta.responsable = @responsable
		  	boleta.monto = monto
		  	boleta.estado = "Generada"
		  	boleta.fecha = DateTime.current
		  	boleta.fecha_desde = params[:fecha_inicio] unless params[:fecha_inicio].blank?
		  	boleta.fecha_hasta = params[:fecha_final] unless params[:fecha_final].blank?
		  	boleta.save 
		  	ids.each do |id|
		  		boleta_atencion = PreBoletasAtencionesPagadas.new
		  		boleta_atencion.boleta = boleta
		  		boleta_atencion.atencion_pagada = PreAtencionesPagadas.find(id)
		  		boleta_atencion.save
		  	end
			end	#end transaction
		end	#end chunk

		respond_to do |format|     
    	format.js { }
    	format.json { render :json => { :success => true } }
    end	

	end
end
