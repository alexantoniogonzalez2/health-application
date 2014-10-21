class CreateTraPaises < ActiveRecord::Migration
  def change
    create_table :tra_paises do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
