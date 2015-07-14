class PreBoletasAtencionesPagadas < ActiveRecord::Base

	belongs_to :boleta, :class_name => 'PreBoletas'
	belongs_to :atencion_pagada, :class_name => 'PreAtencionesPagadas'

	private
  def app_params
    params.require(:list).permit(:id,:boleta,:atencion_pagada)
	end	
end
