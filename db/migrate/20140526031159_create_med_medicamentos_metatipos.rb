class CreateMedMedicamentosMetatipos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_medicamentos_metatipos do |t|
    	t.string :nombre	
      t.timestamps
    end
  end
end
