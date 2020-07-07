class CreateFdDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_diagnosticos do |t|
    	t.references :pieza_dental
      t.references :tipo_diagnostico
      t.string :zona
      t.datetime :fecha
      t.references :responsable
      t.references :atencion_salud

      t.timestamps null: false
    end
  end
end
