class CreateTraComunas < ActiveRecord::Migration
  def change
    create_table :tra_comunas do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
