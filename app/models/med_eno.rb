class MedEno < ActiveRecord::Base
	self.table_name = "med_eno"	
	has_many :eno_diagnosticos, :class_name => 'MedEnoDiagnostico', :foreign_key => 'eno_id'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:eno_diagnosticos)
  end

end
