class CreateFiPersonaActividadFisica < ActiveRecord::Migration[5.0]

  def change
    create_table :fi_persona_actividad_fisica do |t|
    	t.references :persona #persona_id
    	t.string :nivel_actividad
    	t.integer :P1
    	t.integer :P2
    	t.integer :P3
    	t.integer :P4
    	t.integer :P5
    	t.integer :P6
    	t.integer :P7
    	t.integer :P8
    	t.integer :P9
    	t.integer :P10
    	t.integer :P11
    	t.integer :P12
    	t.integer :P13
    	t.integer :P14
    	t.integer :P15
      t.timestamps
    end
  end
end
