class MedEno < ActiveRecord::Base
	self.table_name = "med_eno"	
	has_many :eno_diagnostico, :class_name => 'MedEnoDiagnostico', :foreign_key => 'eno_id'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:eno_diagnostico)
  end

end
