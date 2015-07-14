class PreBoletas < ActiveRecord::Base

	has_many :boletas_atenciones_pagadas, :class_name => 'PreBoletasAtencionesPagadas', :foreign_key => 'boleta_id'
	belongs_to :profesional, :class_name => 'ProProfesionales'
	belongs_to :prestador, :class_name => 'PrePrestadores'

	private
  def app_params
    params.require(:list).permit(:id,:profesional,:prestador,:monto,:estado,:fecha_desde,:fecha_hasta,:boletas_atenciones_pagadas)
  end	
end
