class CreateTraRegiones < ActiveRecord::Migration
  def change
    create_table :tra_regiones do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
