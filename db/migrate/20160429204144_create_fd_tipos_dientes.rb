class CreateFdTiposDientes < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_tipos_dientes do |t|
      t.string :nomenclatura
      t.integer :primer_digito
      t.integer :segundo_digito
      t.string :descripcion
      t.string :tipo_denticion
      t.integer :grupo
      t.timestamps null: false
    end
  end
end
