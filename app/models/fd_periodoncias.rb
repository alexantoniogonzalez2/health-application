class FdPeriodoncias < ActiveRecord::Base
	has_many :periodoncia_indices, :class_name => 'FdPeriodonciaIndices', :foreign_key => 'pieza_dental_id'
  belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  belongs_to :diagnostico, :class_name => 'FdDiagnosticos', optional: true
	def app_params
    params.require(:list).permit(:id,:atencion_salud,:comentario,:diagnostico,:periodoncia_indices,:diagnostico)
  end
end
