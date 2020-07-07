class CreateMedPrestaciones < ActiveRecord::Migration[5.0]
  def change
    create_table :med_prestaciones do |t|
      t.text :nombre
      t.text :descripcion
      t.string :codigo_fonasa
      t.references :subgrupo #subgrupo_id      
      t.timestamps
    end
  end
end
