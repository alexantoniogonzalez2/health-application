class CreateTraCiudades < ActiveRecord::Migration
  def change
    create_table :tra_ciudades do |t|
    	t.text :nombre
    	
      t.timestamps
    end
  end
end
