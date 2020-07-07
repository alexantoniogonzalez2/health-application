class CreateTraDirecciones < ActiveRecord::Migration[5.0]
  def change
    create_table :tra_direcciones do |t|
    	t.string :calle 
    	t.integer :numero
    	t.integer :departamento
    	t.references :comuna #comuna_id
    	t.references :ciudad #ciudad_id
    	t.references :pais #pais_id
    	
      t.timestamps
    end
  end
end
