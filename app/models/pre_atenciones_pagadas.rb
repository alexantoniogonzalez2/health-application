class PreAtencionesPagadas < ActiveRecord::Base

	has_many :boletas_atenciones_pagadas, :class_name => 'PreBoletasAtencionesPagadas', :foreign_key => 'atencion_pagada_id'
	belongs_to :agendamiento, :class_name => 'AgAgendamientos'
	belongs_to :prestacion, :class_name => 'MedPrestaciones'
	belongs_to :prevision_salud, :class_name => 'PerPrevisionesSalud'

	private
  def app_params
    params.require(:list).permit(:id,
                								 :agendamiento,
                								 :prestacion,
                								 :valor,
                								 :bonificacion_financiador,
                								 :aporte_seguro_complementario,
                								 :excedentes,
                								 :copago_beneficiario,
                								 :fecha_pago,
                								 :prevision_salud,
                                 :monto_pago_profesional,
                								 :boletas_atenciones_pagadas)
  end	
end
