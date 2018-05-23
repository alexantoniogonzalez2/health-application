class AdministracionController < ApplicationController

	include ApplicationHelper
	include ActionView::Helpers::NumberHelper
	
	def generarBoletas

		@fecha_final = params[:fecha_final].blank? ? DateTime.current : params[:fecha_final]
		
		@responsable = PerPersonas.where('user_id = ?',current_user.id).first
		@boletas_creadas = []

		@lista_atenciones = PreAtencionesPagadas.joins(:agendamiento)
									.select('pre_atenciones_pagadas.*, ag_agendamientos.especialidad_prestador_profesional_id')	
									.where('pre_atenciones_pagadas.id in (?)',params[:lista_atenciones])
									.order('especialidad_prestador_profesional_id, fecha_comienzo ASC')

		@lista_atenciones.chunk { |l| l.agendamiento.especialidad_prestador_profesional.id }.each do |epp, atenciones|
		  ids = atenciones.map { |a| a.id }
		  montos = atenciones.map { |a| a.monto_pago_profesional }
		  @fecha_inicial = params[:fecha_inicio].blank? ? atenciones[0]['fecha_pago'] : params[:fecha_inicio]
		  ActiveRecord::Base.transaction do
		  	monto = montos.sum
		  	boleta = PreBoletas.new
		  	boleta.especialidad_prestador_profesional = PrePrestadorProfesionales.find(epp)
		  	boleta.responsable = @responsable
		  	boleta.monto = monto
		  	boleta.estado = "Generada"
		  	boleta.fecha = DateTime.current
		  	boleta.fecha_desde = @fecha_inicial
		  	boleta.fecha_hasta = @fecha_final
		  	boleta.save 
		  	ids.each do |id|
		  		boleta_atencion = PreBoletasAtencionesPagadas.new
		  		boleta_atencion.boleta = boleta
		  		boleta_atencion.atencion_pagada = PreAtencionesPagadas.find(id)
		  		boleta_atencion.save
		  	end
				@boletas_creadas << [	boleta.id,
															boleta.fecha.strftime("%Y-%m-%d"),															
															boleta.especialidad_prestador_profesional.profesional.showName('%n%p%m'),
															boleta.especialidad_prestador_profesional.profesional.showRut,
															boleta.especialidad_prestador_profesional.especialidad.nombre,
															boleta.fecha_desde.try(:strftime, "%Y-%m-%d"),
															boleta.fecha_hasta.try(:strftime, "%Y-%m-%d"),
															number_to_currency(boleta.monto, unit: "$ ", separator: '.'),
															number_to_currency(boleta.monto*0.1, unit: "$ ", separator: '.'),
															boleta.estado,
															"<a id='bol-" << boleta.id.to_s << "' href='#' data-toggle='modal' data-target='#ver_atenciones_boleta' onclick='loadAtenciones(" << boleta.id.to_s << ")'>Ver</a>",
															boleta.estado == 'Generada' ? ("<button id='anular-" << boleta.id.to_s << "' type='button' class='btn btn-xs btn-warning' onclick='anularBoleta(" << boleta.id.to_s << ")' >Anular</button>") : "<span>-</span>" ]


			end	#end transaction
		end	#end chunk

		render :json => @boletas_creadas

	end

	def filtrarBoletas
		@fecha_inicial = params[:fecha_inicio].blank? ? DateTime.new(2015, 01, 01, 20, 0, 0) : params[:fecha_inicio]
		@fecha_final = params[:fecha_final].blank? ? DateTime.current : params[:fecha_final].to_time + 1.days

		@query = PreBoletas.joins(:especialidad_prestador_profesional)
												 .select('pre_boletas.*,profesional_id')
												 .where('pre_prestador_profesionales.prestador_id = ? AND fecha BETWEEN ? AND ?',getIdPrestador('administrativo'),@fecha_inicial,@fecha_final)

		if params[:todos_profesionales] == '1'
			@boletas_generadas = @query
		else
			@boletas_generadas = @query.where('pre_prestador_profesionales.profesional_id IN (?)',params[:profesionales])
		end	 			

		@boletas = []

		@boletas_generadas.each do |bol_gen|
			@boletas << [	bol_gen.id,
										bol_gen.fecha.strftime("%Y-%m-%d %H:%M"),										
										bol_gen.especialidad_prestador_profesional.profesional.showName('%n%p%m'),
										bol_gen.especialidad_prestador_profesional.profesional.showRut,
										bol_gen.especialidad_prestador_profesional.especialidad.nombre,
										bol_gen.fecha_desde.try(:strftime, "%Y-%m-%d"),
										bol_gen.fecha_hasta.try(:strftime, "%Y-%m-%d"),
										number_to_currency(bol_gen.monto, unit: "$ ", separator: '.'),
										number_to_currency(bol_gen.monto*0.1, unit: "$ ", separator: '.'),
										bol_gen.estado,
										bol_gen.estado == 'Anulada' ? "<span>-</span>" : "<a id='bol-" << bol_gen.id.to_s << "' href='#' data-toggle='modal' data-target='#ver_atenciones_boleta' onclick='loadAtenciones(" << bol_gen.id.to_s << ")' >Ver</a>",
										bol_gen.estado == 'Generada' ? ("<button id='anular-" << bol_gen.id.to_s << "' type='button' class='btn btn-xs btn-warning' onclick='anularBoleta(" << bol_gen.id.to_s << ")' >Anular</button>") : "<span>-</span>" ]
		end	

		render :json => @boletas
	end	

	def cargarAtencionesBoleta
		@atenciones = PreBoletasAtencionesPagadas.where('boleta_id = ?',params[:boleta])
		respond_to do |format|     
    	format.js   {}
    end	
	end	

	def anularBoleta
		@atenciones = PreBoletasAtencionesPagadas.where('boleta_id = ?',x)
		@atenciones.each do |atencion|
			atencion.destroy
		end	
		@boleta = PreBoletas.find(params[:boleta])
		@boleta.estado = 'Anulada'
		@boleta.save
		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	

	end	

	def cargarPagos

		@pagos = FdPagos.where('presupuesto_id = ?', params[:pres])

		render :json => @pagos
	end

	def agregarPago

		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
	  @presupuesto = FdPresupuestos.where('id = ?',params[:presupuesto]).first

	  @pago = FdPagos.where('numero = ? AND presupuesto_id = ?',params[:numero_pago],@presupuesto.id).first
	  @pago.pagado = true
	  @pago.responsable = @usuario
	  @pago.fecha_pago = DateTime.current
	  @pago.save!

	  render :json => { :success => true }
	end


end
