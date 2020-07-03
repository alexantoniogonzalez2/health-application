class FdPrecios < ActiveRecord::Base
	belongs_to :tratamiento, :class_name => 'FdTratamientos'
	belongs_to :prestador, :class_name => 'PrePrestadores'
	has_many :glosas_presupuestos, :class_name => 'FdGlosasPresupuestos', :foreign_key => 'precio_id'

	def app_params
    params.require(:list).permit(:id,:tratamiento,:valor,:fecha_inicio,:fecha_termino,:activo,:descripcion,:prestador,:glosas_presupuestos)
  end
end
