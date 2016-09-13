class FdPeriodoncias < ActiveRecord::Base
	has_many :periodoncia_indices, :class_name => 'FdPeriodonciaIndices', :foreign_key => 'pieza_dental_id'
  belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	def app_params
    params.require(:list).permit(:id,:atencion_salud,:observacion,:diagnostico,:tratamiento,:periodoncia_indices)
  end
end
