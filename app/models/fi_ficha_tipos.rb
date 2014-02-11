class FiFichaTipos < ActiveRecord::Base

	has_many :atencion_medica, :class_name => 'FiAtencionesMedicas', :foreign_key => 'tipo_ficha_id'
	
  private
  def app_params
    params.require(:list).permit(:atencion_medica,
  								:id,
  								:nombre)
  end
								
end
