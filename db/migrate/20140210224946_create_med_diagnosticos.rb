class CreateMedDiagnosticos < ActiveRecord::Migration
  def change
    create_table :med_diagnosticos do |t|
      t.text :nombre
      t.text :codigo_cie10
      t.text :descripcion

      t.timestamps
    end
  end
end
