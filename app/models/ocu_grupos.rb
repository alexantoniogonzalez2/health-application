class OcuGrupos < ActiveRecord::Base
	has_many :subgrupos, :class_name => 'OcuSubgrupos', :foreign_key => 'grupo_id'
	belongs_to :gran_grupo, :class_name => 'OcuGrandesGrupos'

	private
  def app_params
    params.require(:list).permit(:id, :nombre, :codigo, :subgrupos, :gran_grupo)
  end  

end
