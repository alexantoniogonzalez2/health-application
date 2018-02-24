class FdTratamientos < ActiveRecord::Base
	has_many :glosas_presupuestos, :class_name => 'FdGlosasPresupuestos', :foreign_key => 'tratamiento_id'
	has_many :precios, :class_name => 'FdPrecios', :foreign_key => 'tratamiento_id'
	has_many :tratamiento_tipo_diagnostico, :class_name => 'FdTratamientosTiposDiagnosticos', :foreign_key => 'tratamiento_id'

	def app_params
    params.require(:list).permit(:id,:descripcion,:glosas_presupuestos,:precios,:tratamiento_tipo_diagnostico)
  end
end
