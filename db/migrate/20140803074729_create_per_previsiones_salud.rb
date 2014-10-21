class CreatePerPrevisionesSalud < ActiveRecord::Migration
  def change
    create_table :per_previsiones_salud do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
