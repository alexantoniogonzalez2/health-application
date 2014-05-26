class CreateMedMedicamentosMetatipos < ActiveRecord::Migration
  def change
    create_table :med_medicamentos_metatipos do |t|
    	t.text :nombre	
      t.timestamps
    end
  end
end
