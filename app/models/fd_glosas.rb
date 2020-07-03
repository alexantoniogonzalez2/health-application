class FdGlosas < ActiveRecord::Base
	belongs_to :tratamiento, :class_name => 'FdTratamientos'
	belongs_to :precio, :class_name => 'FdPrecios'
	belongs_to :presupuesto, :class_name => 'FdPresupuestos'
	has_many :glosas_diagnosticos, :class_name => 'FdGlosasDiagnosticos', :foreign_key => 'glosa_id'

	def app_params
    params.require(:list).permit(:id,:tratamiento,:precio,:descuento,:total,:presupuesto,:estado,:glosas_diagnosticos)
  end
end
