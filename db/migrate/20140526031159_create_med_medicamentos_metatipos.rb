class CreateMedMedicamentosMetatipos < ActiveRecord::Migration
  def change
    create_table :med_medicamentos_metatipos do |t|
    	t.string :nombre	
      t.timestamps
    end
  end
end
