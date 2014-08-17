class FiHabitosAlcohol < ActiveRecord::Base

	self.table_name = "fi_habitos_alcohol"
	belongs_to :persona, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(:id,
    														 :persona,
    														 :fecha_test_audit,    														 
    														 :audit_1,
    														 :audit_2,
    														 :audit_3,
    														 :audit_4,
    														 :audit_5,
    														 :audit_6,
    														 :audit_7,
    														 :audit_8,
    														 :audit_9,
    														 :audit_10,    														 
    														 :audit_puntaje)
  end
end
