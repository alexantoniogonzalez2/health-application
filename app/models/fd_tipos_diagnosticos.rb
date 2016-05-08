class FdTiposDiagnosticos < ActiveRecord::Base
	has_many :diagnosticos, :class_name => 'FiDiagnosticos', :foreign_key => 'tipo_diagnostico_id'
	def app_params
    params.require(:list).permit(:id,:nombre)
  end
end
