class CreateFiHabitosDrogas < ActiveRecord::Migration
  def change
    create_table :fi_habitos_drogas do |t|
    	t.references :persona #persona_id
    	t.datetime :fecha_test_dast
    	t.string :tipo_dast
    	t.integer :dast_1
    	t.integer :dast_2
    	t.integer :dast_3
    	t.integer :dast_4
    	t.integer :dast_5 
    	t.integer :dast_6
    	t.integer :dast_7
    	t.integer :dast_8
    	t.integer :dast_9
    	t.integer :dast_10
    	t.integer :dast_11
    	t.integer :dast_12
    	t.integer :dast_13
    	t.integer :dast_14
    	t.integer :dast_15
    	t.integer :dast_16
    	t.integer :dast_17
    	t.integer :dast_19
    	t.integer :dast_20
    	t.integer :dast_puntaje
      t.timestamps
    end
  end
end
