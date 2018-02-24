class FdDiagnosticos < ActiveRecord::Base
	belongs_to :pieza_dental, :class_name => 'FdPiezasDentales'
  belongs_to :tipo_diagnostico, :class_name => 'FdTiposDiagnosticos'
  belongs_to :responsable, :class_name => 'PerPersonas'
  belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  has_many :glosas_diagnosticos, :class_name => 'FdGlosasDiagnosticos', :foreign_key => 'diagnostico_id', dependent: :delete_all
  has_many :endodoncias, :class_name => 'FdEndodoncias', :foreign_key => 'diagnostico_id'
  has_many :periodoncias, :class_name => 'FdPeriodoncias', :foreign_key => 'diagnostico_id'

  def app_params
    params.require(:list).permit(:id,:pieza_dental,:tipo_diagnostico,:responsable,:atencion_salud,:zona,:fecha,:glosas_diagnosticos,:endodoncias,:periodoncias)
  end
end
