class FdTestDiagnostico < ActiveRecord::Base
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
	def app_params
    params.require(:list).permit(:id,:pieza_dental,:calor,:electrico,:percusion,:palpacion,:observacion)
  end
end
