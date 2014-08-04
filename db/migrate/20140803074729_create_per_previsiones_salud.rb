class CreatePerPrevisionesSalud < ActiveRecord::Migration
  def change
    create_table :per_previsiones_salud do |t|
    	t.text :nombre

      t.timestamps
    end
  end
end
