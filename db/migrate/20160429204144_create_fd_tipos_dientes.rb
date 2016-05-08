class CreateFdTiposDientes < ActiveRecord::Migration
  def change
    create_table :fd_tipos_dientes do |t|
      t.string :nomenclatura
      t.integer :primer_digito
      t.integer :segundo_digito
      t.string :descripcion
      t.string :tipo_denticion

      t.timestamps null: false
    end
  end
end
