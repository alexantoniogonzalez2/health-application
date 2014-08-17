class FiHabitosDrogas < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(:id,
    														 :persona,
    														 :fecha_test_dast,
    														 :tipo_dast,
    														 :dast_1,
    														 :dast_2,
    														 :dast_3,
    														 :dast_4,
    														 :dast_5,
    														 :dast_6,
    														 :dast_7,
    														 :dast_8,
    														 :dast_9,
    														 :dast_10,
    														 :dast_11,
    														 :dast_12,
    														 :dast_13,
    														 :dast_14,
    														 :dast_15,
    														 :dast_16,
    														 :dast_17,
    														 :dast_18,
    														 :dast_19,
    														 :dast_20,
    														 :dast_puntaje)
  end

end
