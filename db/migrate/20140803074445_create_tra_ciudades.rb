class CreateTraCiudades < ActiveRecord::Migration
  def change
    create_table :tra_ciudades do |t|
    	t.string :nombre
    	
      t.timestamps
    end
  end
end
