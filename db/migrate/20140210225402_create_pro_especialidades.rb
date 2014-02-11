class CreateProEspecialidades < ActiveRecord::Migration
  def change
    create_table :pro_especialidades do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
