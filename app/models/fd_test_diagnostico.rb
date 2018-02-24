class FdTestDiagnostico < ActiveRecord::Base
	self.table_name = "fd_test_diagnostico"
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
	belongs_to :endodoncia, :class_name => 'FdEndodoncias'

	def getEstado
		{
    	id: pieza_dental.tipo_diente.nomenclatura,
    	name: pieza_dental.tipo_diente.nomenclatura,
      image: ActionController::Base.helpers.asset_path('dental/od_'<<pieza_dental.tipo_diente.primer_digito.to_s<<'/'<<pieza_dental.tipo_diente.nomenclatura<<'.jpg'),
      calor: calor,
      electrico: electrico,
      percusion: percusion,
      palpacion: palpacion,
      observacion: observacion
    }
	end

	def app_params
    params.require(:list).permit(:id,:pieza_dental,:endodoncia,:calor,:electrico,:percusion,:palpacion,:observacion)
  end

end