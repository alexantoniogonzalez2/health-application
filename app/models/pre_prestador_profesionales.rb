class PrePrestadorProfesionales < ActiveRecord::Base

	belongs_to :prestador, :class_name => 'PrePrestadores'
	belongs_to :profesional, :class_name => 'PerPersonas'
	belongs_to :especialidad, :class_name => 'ProEspecialidades'
	has_many :boletas, :class_name => 'PreBoletas', :foreign_key => 'especialidad_prestador_profesional_id'
	has_many :agendamientos, :class_name => 'AgAgendamientos', :foreign_key => 'especialidad_prestador_profesional_id'
	has_many :acciones_masivas, :class_name => 'AgAccionMasiva', :foreign_key => 'especialidad_prestador_profesional_id'
	has_many :regla_pagos, :class_name => 'PreReglaPagos', :foreign_key => 'especialidad_prestador_profesional_id'

	def getMontoPagoProfesional (monto,fecha_atencion)

		@porcentaje = 0
		@monto_pago = 0
		#Primero se busca una regla específica para el profesional
		@regla_para_profesional = PreReglaPagos.where("tipo = 'profesional' AND especialidad_prestador_profesional_id = ? AND fecha_inicio < ? AND (fecha_termino < ? OR fecha_termino is null)", id, fecha_atencion, fecha_atencion).first
		
		#Si no hay una regla, se utiliza la regla del centro
		unless @regla_para_profesional
			@regla_para_profesional = PreReglaPagos.where("tipo = 'prestador' AND prestador_id = ? AND fecha_inicio < ? AND (fecha_termino < ? OR fecha_termino is null)", prestador, fecha_atencion, fecha_atencion).first
		end

		@porcentaje = @regla_para_profesional.porcentaje
		@monto_pago = monto*@porcentaje
		return @monto_pago.to_i	
	end

	private
  def app_params
    params.require(:list).permit(:id,
																:prestador,
																:profesional,
																:especialidad,
																:agendamientos,
																:acciones_masivas,
																:regla_pagos)
  end

  								
end
