class CreateFdTratamientosTiposDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fd_tratamientos_tipos_diagnosticos do |t|
    	t.references :tratamiento
    	t.references :tipo_diagnostico
      t.timestamps null: false
    end
  end
end
