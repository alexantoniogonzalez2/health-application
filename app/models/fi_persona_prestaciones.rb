class FiPersonaPrestaciones < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :prestacion, :class_name => 'MedPrestaciones'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:id,
  								:persona,
  								:prestacion,
  								:atencion_salud)
  end
								

end
