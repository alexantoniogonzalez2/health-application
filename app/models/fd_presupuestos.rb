class FdPresupuestos < ActiveRecord::Base
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	has_many :glosas_presupuestos, :class_name => 'FdGlosasPresupuestos', :foreign_key => 'presupuesto_id'
	has_many :pagos, :class_name => 'FdPagos', :foreign_key => 'presupuesto_id'

	def app_params
    params.require(:list).permit(:id,:atencion_salud,:estado,:valor,:descuento,:total,:pagado,:pendiente,:glosas_presupuestos,:numero_cuotas,:iguales,:pagos)
  end
end
