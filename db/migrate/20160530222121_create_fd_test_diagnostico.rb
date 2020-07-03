class CreateFdTestDiagnostico < ActiveRecord::Migration
  def change
    create_table :fd_test_diagnostico do |t|
      t.references :endodoncia
    	t.references :pieza_dental
      t.integer :calor
      t.integer :electrico
      t.integer :percusion
      t.integer :palpacion
      t.text :observacion
      t.timestamps null: false
    end
  end
end
