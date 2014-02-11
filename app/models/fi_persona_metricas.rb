class FiPersonaMetricas < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :metricas, :class_name => 'FiMetricas'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:atencion_salud,
  								:id,
  								:metricas,
  								:persona)
  end
								
end
