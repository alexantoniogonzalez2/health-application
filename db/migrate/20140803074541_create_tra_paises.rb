class CreateTraPaises < ActiveRecord::Migration
  def change
    create_table :tra_paises do |t|
    	t.text :nombre

      t.timestamps
    end
  end
end
