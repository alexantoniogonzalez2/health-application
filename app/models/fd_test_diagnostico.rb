class FdTestDiagnostico < ActiveRecord::Base
	self.table_name = "fd_test_diagnostico"
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
	belongs_to :endodoncia, :class_name => 'FdEndodoncia'
	def app_params
    params.require(:list).permit(:id,:pieza_dental,:endodoncia,:calor,:electrico,:percusion,:palpacion,:observacion)
  end
end
