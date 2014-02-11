class CreateFiFichaTipos < ActiveRecord::Migration
  def change
    create_table :fi_ficha_tipos do |t|
      t.text :nombre	
      
      t.timestamps
    end
  end
end
