class FiMetricas < ActiveRecord::Base

	has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'metrica_id'

  private
  def app_params
    params.require(:list).permit(:id,
  								:nombre,
  								:persona_metricas,	
  								:unidad)
  end
								
end
