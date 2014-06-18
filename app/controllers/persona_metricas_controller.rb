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

  	@persona_presion = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:atencion_salud_id],3).first
  	if @persona_presion 
  		@persona_presion.update( valor: params[:presion], fecha: fecha )
  	else 
  		@persona_presion = FiPersonaMetricas.new( valor: params[:presion], fecha: fecha , persona_id: params[:persona_id], metrica_id: 3, atencion_salud_id: params[:atencion_salud_id])
  		@persona_presion.save
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

	def cargarDatosPeso

    @datos = []
    @texto = []

		@datos_peso = FiPersonaMetricas.where("metrica_id = ? AND persona_id = ?",2,params[:persona_id])

		datos2 = [7.0, 6.9]
    texto2 = ['hola', 'Feb']

    @datos_peso.each do |d_p|
      @datos << d_p.valor
      @texto << d_p.id
    end 

   	respond_to do |format|     
    	format.json { render json: {:datos => @datos,:texto => @texto} }
    end		

	end

end
