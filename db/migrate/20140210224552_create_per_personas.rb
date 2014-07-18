class CreatePerPersonas < ActiveRecord::Migration
  def change
    create_table :per_personas do |t|
    	
    	t.references :user #user_id	
      t.integer :rut
      t.string :digito_verificador , :limit => 1
      t.string :nombre
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :genero
      t.datetime :fecha_nacimiento
      t.datetime :fecha_muerte

      t.timestamps
    end
  end
end
