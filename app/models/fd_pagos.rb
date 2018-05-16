class FdPagos < ActiveRecord::Base
	belongs_to :presupuesto, :class_name => 'FdPresupuestos'
	belongs_to :responsable, :class_name => 'PerPersonas'

	def app_params
    params.require(:list).permit(:id,:monto,:presupuesto,:comentario,:fecha_pago,:responsable,:numero,:pagado)
  end
end
