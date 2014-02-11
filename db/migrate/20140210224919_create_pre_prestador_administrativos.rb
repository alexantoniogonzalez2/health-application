class CreatePrePrestadorAdministrativos < ActiveRecord::Migration
  def change
    create_table :pre_prestador_administrativos do |t|
      t.references :prestador 						#prestador_id
      t.references :rol_administrativo				#rol_administrativo_id
      t.references :administrativo					#administrativo_id

      t.timestamps
    end
  end
end
