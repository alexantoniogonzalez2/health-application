class PreBoletas < ActiveRecord::Base

	has_many :boletas_atenciones_pagadas, :class_name => 'PreBoletasAtencionesPagadas', :foreign_key => 'boleta_id'
	belongs_to :especialidad_prestador_profesional, :class_name => 'PrePrestadorProfesionales'
	belongs_to :responsable, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(:id,:especialidad_prestador_profesional,:monto,:estado,:fecha,:responsable,:fecha_desde,:fecha_hasta,:boletas_atenciones_pagadas)
  end	
end
