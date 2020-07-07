class CreateMedDiagnosticoEstados < ActiveRecord::Migration[5.0]
  def change
    create_table :med_diagnostico_estados do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
