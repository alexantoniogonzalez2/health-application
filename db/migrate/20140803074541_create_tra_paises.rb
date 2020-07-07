class CreateTraPaises < ActiveRecord::Migration[5.0]
  def change
    create_table :tra_paises do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
