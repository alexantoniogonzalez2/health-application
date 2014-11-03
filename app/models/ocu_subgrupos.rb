class OcuSubgrupos < ActiveRecord::Base

	has_many :ocupaciones, :class_name => 'OcuOcupaciones', :foreign_key => 'subgrupo_id'
	belongs_to :grupo, :class_name => 'OcuGrupos'

	private
  def app_params
    params.require(:list).permit(:id, :nombre, :codigo, :ocupaciones, :grupo)
  end  

end
