class FdTratamientosTiposDiagnosticos < ActiveRecord::Base
	belongs_to :tratamiento, :class_name => 'FdTratamientos'
	belongs_to :tipo_diagnostico, :class_name => 'FdTiposDiagnosticos'

	def app_params
    params.require(:list).permit(:id,:tratamiento,:tipo_diagnostico)
  end
end
