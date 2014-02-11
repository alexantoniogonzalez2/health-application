class CreateMedExamenes < ActiveRecord::Migration
  def change
    create_table :med_examenes do |t|
      t.text :nombre
      t.text :descripcion
      t.text :indicaciones
      t.text :codigo_isapre
      
      t.timestamps
    end
  end
end
