class CreatePerPersonasTelefonos < ActiveRecord::Migration[5.0]
  def change
    create_table :per_personas_telefonos do |t|
    	t.references :persona #persona_id
    	t.references :telefono #telefono_id
    	
      t.timestamps
    end
  end
end
