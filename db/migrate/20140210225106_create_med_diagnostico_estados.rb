class CreateMedDiagnosticoEstados < ActiveRecord::Migration
  def change
    create_table :med_diagnostico_estados do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
