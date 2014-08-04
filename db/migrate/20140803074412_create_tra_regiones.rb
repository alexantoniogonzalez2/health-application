class CreateTraRegiones < ActiveRecord::Migration
  def change
    create_table :tra_regiones do |t|
    	t.text :nombre

      t.timestamps
    end
  end
end
