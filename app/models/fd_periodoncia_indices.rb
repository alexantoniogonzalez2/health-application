class FdPeriodonciaIndices < ActiveRecord::Base
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
	belongs_to :periodoncia, :class_name => 'FdPeriodoncias'
	def app_params
    params.require(:list).permit(:id,:periodoncia,:pieza_dental,:vestibular,:mesial,:palatino,:distal,:indice)
  end
end
