class CreateProEspecialidades < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_especialidades do |t|
      t.string :nombre
      t.references :prestacion #prestacion_id
      t.timestamps
    end
  end
end
