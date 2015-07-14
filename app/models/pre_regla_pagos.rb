class PreReglaPagos < ActiveRecord::Base

	has_many :boletas_atenciones_pagadas, :class_name => 'PreBoletasAtencionesPagadas', :foreign_key => 'atencion_pagada_id'
	belongs_to :prestador, :class_name => 'PrePrestadores'
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'

	private
  def app_params
    params.require(:list).permit(	:id,
    															:tipo,
    															:prestador,
    															:especialidad_prestador_profesional,
    															:porcentaje,
    															:fecha_inicio,
    															:fecha_termino)
  end	
end
