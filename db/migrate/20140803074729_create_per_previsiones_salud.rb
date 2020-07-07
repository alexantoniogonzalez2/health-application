class CreatePerPrevisionesSalud < ActiveRecord::Migration[5.0]
  def change
    create_table :per_previsiones_salud do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
