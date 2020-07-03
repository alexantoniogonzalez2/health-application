class FdTiposDiagnosticos < ActiveRecord::Base
	has_many :diagnosticos, :class_name => 'FiDiagnosticos', :foreign_key => 'tipo_diagnostico_id'
	has_many :tratamiento_tipo_diagnostico, :class_name => 'FdTratamientosTiposDiagnosticos', :foreign_key => 'tipo_diagnostico_id'
	
	def app_params
    params.require(:list).permit(:id,:nombre,:tipo,:diagnosticos,:tratamiento_tipo_diagnostico)
  end
end
