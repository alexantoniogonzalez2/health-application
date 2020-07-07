class CreateFiHabitosAlcohol < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_habitos_alcohol do |t|
    	t.references :persona #persona_id
    	t.datetime :fecha_test_audit
    	t.integer :audit_1
    	t.integer :audit_2
    	t.integer :audit_3
    	t.integer :audit_4
    	t.integer :audit_5
    	t.integer :audit_6
    	t.integer :audit_7
    	t.integer :audit_8
    	t.integer :audit_9
    	t.integer :audit_10
    	t.integer :audit_puntaje
      t.timestamps
    end
  end
end
