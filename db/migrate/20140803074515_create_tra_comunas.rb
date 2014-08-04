class CreateTraComunas < ActiveRecord::Migration
  def change
    create_table :tra_comunas do |t|
    	t.text :nombre

      t.timestamps
    end
  end
end
