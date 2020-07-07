class CreateTraRegiones < ActiveRecord::Migration[5.0]
  def change
    create_table :tra_regiones do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
