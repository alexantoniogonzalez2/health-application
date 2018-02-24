class CreateFdTiposDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fd_tipos_diagnosticos do |t|
      t.string :nombre
      t.string :tipo
      t.timestamps null: false
    end
  end
end
