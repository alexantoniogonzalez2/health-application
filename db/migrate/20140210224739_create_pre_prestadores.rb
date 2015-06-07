class CreatePrePrestadores < ActiveRecord::Migration
  def change
    create_table :pre_prestadores do |t|
      t.integer :rut
      t.string :nombre
      t.boolean :es_centinela
      t.timestamps
    end
  end
end
