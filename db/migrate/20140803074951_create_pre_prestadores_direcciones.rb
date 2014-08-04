class CreatePrePrestadoresDirecciones < ActiveRecord::Migration
  def change
    create_table :pre_prestadores_direcciones do |t|
    	t.references :prestador #prestador_id
    	t.references :direccion #direccion_id

      t.timestamps
    end
  end
end
