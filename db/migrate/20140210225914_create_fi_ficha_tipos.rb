class CreateFiFichaTipos < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_ficha_tipos do |t|
      t.string :nombre	
      
      t.timestamps
    end
  end
end
