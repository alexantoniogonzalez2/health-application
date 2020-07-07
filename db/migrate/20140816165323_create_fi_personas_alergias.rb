class CreateFiPersonasAlergias < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_personas_alergias do |t|
    	t.references :persona #persona_id
    	t.references :alergia #alergia_id
      t.timestamps
    end
  end
end
