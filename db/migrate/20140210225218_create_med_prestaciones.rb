class CreateMedPrestaciones < ActiveRecord::Migration
  def change
    create_table :med_prestaciones do |t|
      t.string :nombre
      t.string :descripcion
      t.string :codigo_fonasa
      t.references :subgrupo #subgrupo_id
      
      t.timestamps
    end
  end
end
