class PersonaMetricasController < ApplicationController
	
	def guardarMetricas		

    valor_metrica = params[:valor_metrica]
		fecha = DateTime.current 
    case params['metrica']
    when 'estatura'
      metrica_id = 1
    when 'peso'
      metrica_id = 2
    when 'presion-am'
      metrica_id = 3
    when 'imc'
      metrica_id = 4 
    when 'frec-car'
      metrica_id = 5
    when 'frec-res'
      metrica_id = 6
    when 'temp'
      metrica_id = 7
    when 'sat'
      metrica_id = 8
    when 'presion-sis'
      metrica_id = 9
    when 'presion-dias'
      metrica_id = 10          
    end

    if ([1,2,4].include?(metrica_id))
      caracteristica = ''
    else 
      caracteristica = params['caracteristica']
    end 

  	@persona_caracteristica = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],metrica_id).first

    if @persona_caracteristica 
  		@persona_caracteristica.update( valor: valor_metrica, fecha: fecha, caracteristica: caracteristica )
  	else 
  		@persona_caracteristica = FiPersonaMetricas.new( valor: valor_metrica, fecha: fecha , persona_id: params[:persona_id], metrica_id: metrica_id, atencion_salud_id: params[:atencion_salud_id], caracteristica: caracteristica )
  		@persona_caracteristica.save
  	end

    @persona_caracteristica.destroy if valor_metrica == '' and caracteristica == ''
  	
  	render :json => { :success => true }	
	
	end

	def cargarDatosMetricas

    case params[:tipo]
    when 'estatura'
      metrica_id = 1
    when 'peso'
      metrica_id = 2
    when 'presion_am'
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
    when 'presion_sis'
      metrica_id = 9
    when 'presion_dias'
      metrica_id = 10          
    end

    @datos = []
    @texto = []

    metrica = FiMetricas.find(metrica_id)
    metrica_nombre =  metrica.nombre
    @persona = PerPersonas.find (params[:persona_id])

    if metrica_id == 3
      @datos_1 = []
      @datos_2 = []
      @datos_3 = []
      @atenciones = FiPersonaMetricas.select('distinct(atencion_salud_id)').where("metrica_id IN (3,9,10) AND persona_id = ?",params[:persona_id])
      @atenciones.each do |atencion|
        @dato_metrica_1 = FiPersonaMetricas.where("metrica_id = 3 AND persona_id = ? AND atencion_salud_id = ?",params[:persona_id], atencion.atencion_salud_id).first
        @dato_metrica_2 = FiPersonaMetricas.where("metrica_id = 9 AND persona_id = ? AND atencion_salud_id = ?",params[:persona_id], atencion.atencion_salud_id).first
        @dato_metrica_3 = FiPersonaMetricas.where("metrica_id = 10 AND persona_id = ? AND atencion_salud_id = ?",params[:persona_id], atencion.atencion_salud_id).first
        @fecha_texto = FiPersonaMetricas.where("metrica_id in (3,9,10) AND persona_id = ? AND atencion_salud_id = ?",params[:persona_id], atencion.atencion_salud_id).first
          
        dato_1 = (@dato_metrica_1 == nil) ? '' : (@dato_metrica_1.valor == nil ? '' : @dato_metrica_1.valor.to_f)  
        @datos_1 << dato_1
        dato_2 = (@dato_metrica_2 == nil) ? '' : (@dato_metrica_2.valor == nil ? '' : @dato_metrica_2.valor.to_f)  
        @datos_2 << dato_2 
        dato_3 = (@dato_metrica_3 == nil) ? '' : (@dato_metrica_3.valor == nil ? '' : @dato_metrica_3.valor.to_f)  
        @datos_3 << dato_3   
     

        @texto << @fecha_texto.showFecha
      end 
      @datos = [@datos_2,@datos_1,@datos_3]
      metrica_nombre = [['Presión sistólica'],['Presión arterial media'],['Presión diastólica']]
    else
      @datos_metrica = FiPersonaMetricas.where("metrica_id = ? AND persona_id = ?",metrica_id,params[:persona_id])      
      @datos_metrica.each do |d_p|
        @datos << d_p.valor.to_f
        @texto << d_p.showFecha
      end 
    end 

   	respond_to do |format|     
    	format.json { render json: {
                                    :datos => @datos,
                                    :texto => @texto,
                                    :paciente => @persona.showName('%n%p%m'),
                                    :nombre_metrica => metrica_nombre,
                                    :unidad => metrica.unidad
                                  } 
                  }
    end		

	end

end
