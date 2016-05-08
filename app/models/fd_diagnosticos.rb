class FdDiagnosticos < ActiveRecord::Base
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
  belongs_to :tipo_diagnostico, :class_name => 'FdTiposDiagnosticos'
  belongs_to :responsable, :class_name => 'PerPersonas'
  belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  def app_params
    params.require(:list).permit(:id,:pieza_dental,:tipo_diagnostico,:responsable,:atencion_salud,:zona,:fecha)
  end
end
