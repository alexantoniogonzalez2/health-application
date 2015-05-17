class PersonaMetricasController < ApplicationController
	
	def guardarMetricas		

		fecha = DateTime.current 

  	@persona_estatura = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],1).first
  	if @persona_estatura 
  		@persona_estatura.update( valor: params[:estatura], fecha: fecha )
  	else 
  		@persona_estatura = FiPersonaMetricas.new( valor: params[:estatura], fecha: fecha , persona_id: params[:persona_id], metrica_id: 1, atencion_salud_id: params[:atencion_salud_id])
  		@persona_estatura.save
  	end	

  	@persona_peso = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],2).first
  	if @persona_peso 
  		@persona_peso.update( valor: params[:peso], fecha: fecha )
  	else 
  		@persona_peso = FiPersonaMetricas.new( valor: params[:peso], fecha: fecha , persona_id: params[:persona_id], metrica_id: 2, atencion_salud_id: params[:atencion_salud_id])
  		@persona_peso.save
  	end	

  	@persona_imc = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],4).first
  	if @persona_imc 
  		@persona_imc.update( valor: params[:imc], fecha: fecha )
  	else 
  		@persona_imc = FiPersonaMetricas.new( valor: params[:imc], fecha: fecha , persona_id: params[:persona_id], metrica_id: 4, atencion_salud_id: params[:atencion_salud_id])
  		@persona_imc.save
  	end	
  	
  	render :json => { :success => true }	
	
	end


  def guardarSignos   

    fecha = DateTime.current 

    @persona_frec_car = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],5).first
    if @persona_frec_car 
      @persona_frec_car.update( valor: params[:frec_car], fecha: fecha, caracteristica: params[:car_frec_car] )
    else 
      @persona_frec_car = FiPersonaMetricas.new( valor: params[:frec_car], fecha: fecha , persona_id: params[:persona_id], metrica_id: 5, atencion_salud_id: params[:atencion_salud_id], caracteristica: params[:car_frec_car] )
      @persona_frec_car.save
    end 

    @persona_frec_res = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],6).first
    if @persona_frec_res 
      @persona_frec_res.update( valor: params[:frec_res], fecha: fecha, caracteristica: params[:car_frec_res]  )
    else 
      @persona_frec_res = FiPersonaMetricas.new( valor: params[:frec_res], fecha: fecha , persona_id: params[:persona_id], metrica_id: 6, atencion_salud_id: params[:atencion_salud_id], caracteristica: params[:car_frec_res] )
      @persona_frec_res.save
    end 

    @persona_temp = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],7).first
    if @persona_temp 
      @persona_temp.update( valor: params[:temp], fecha: fecha, caracteristica: params[:car_temp] )
    else 
      @persona_temp = FiPersonaMetricas.new( valor: params[:temp], fecha: fecha , persona_id: params[:persona_id], metrica_id: 7, atencion_salud_id: params[:atencion_salud_id], caracteristica: params[:car_temp] )
      @persona_temp.save
    end 

    @persona_presion = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],3).first
    if @persona_presion 
      @persona_presion.update( valor: params[:presion], fecha: fecha, caracteristica: params[:car_presion]  )
    else 
      @persona_presion = FiPersonaMetricas.new( valor: params[:presion], fecha: fecha , persona_id: params[:persona_id], metrica_id: 3, atencion_salud_id: params[:atencion_salud_id], caracteristica: params[:car_presion] )
      @persona_presion.save
    end 

    @persona_sat = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],8).first
    if @persona_sat 
      @persona_sat.update( valor: params[:sat], fecha: fecha, caracteristica: params[:car_sat])
    else 
      @persona_sat = FiPersonaMetricas.new( valor: params[:sat], fecha: fecha , persona_id: params[:persona_id], metrica_id: 8, atencion_salud_id: params[:atencion_salud_id], caracteristica: params[:car_sat])
      @persona_sat.save
    end 
    
    render :json => { :success => true }  
  
  end

	def cargarDatosMetricas

    case params[:tipo]
    when 'estatura'
      metrica_id = 1
    when 'peso'
      metrica_id = 2
    when 'presion'
      metrica_id = 3
    when 'IMC'
      metrica_id = 4 
    when 'frec_car'
      metrica_id = 5
    when 'frec_res'
      metrica_id = 6
    when 'temp'
      metrica_id = 7
    when 'sat'
      metrica_id = 8      
    end

    @datos = []
    @texto = []

		@datos_metrica = FiPersonaMetricas.where("metrica_id = ? AND persona_id = ?",metrica_id,params[:persona_id])
    @persona = PerPersonas.find (params[:persona_id])

    @datos_metrica.each do |d_p|
      @datos << d_p.valor
      @texto << d_p.showFecha
    end 

    metrica = FiMetricas.find(metrica_id)

   	respond_to do |format|     
    	format.json { render json: {
                                    :datos => @datos,
                                    :texto => @texto,
                                    :paciente => @persona.showName('%n%p%m'),
                                    :nombre_metrica => metrica.nombre,
                                    :unidad => metrica.unidad
                                  } 
                  }
    end		

	end

end
