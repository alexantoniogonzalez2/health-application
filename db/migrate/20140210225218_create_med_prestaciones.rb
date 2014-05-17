class CreateMedPrestaciones < ActiveRecord::Migration
  def change
    create_table :med_prestaciones do |t|
      t.text :nombre
      t.text :descripcion
      t.text :codigo_fonasa
      t.references :subgrupo #subgrupo_id
      
      t.timestamps
    end
  end
end
