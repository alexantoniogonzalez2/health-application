class OcuOcupaciones < ActiveRecord::Base

	has_many :personas_ocupaciones, :class_name => 'PerPersonasOcupaciones', :foreign_key => 'ocupacion_id'
	belongs_to :subgrupo, :class_name => 'OcuSubgrupos'

	def formato_ocupaciones
  {
    :id        => id,
    :text     => nombre     
  }
	end

	private
  def app_params
    params.require(:list).permit(:id, :nombre, :codigo, :subgrupo, :personas_ocupaciones)
  end
  
end
