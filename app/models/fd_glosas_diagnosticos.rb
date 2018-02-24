class FdGlosasDiagnosticos < ActiveRecord::Base
	belongs_to :glosa, :class_name => 'FdGlosas'
	belongs_to :diagnostico, :class_name => 'FdDiagnosticos'

	def app_params
    params.require(:list).permit(:id,:glosa,:diagnostico)
  end
end
