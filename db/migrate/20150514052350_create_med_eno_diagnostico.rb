class CreateMedEnoDiagnostico < ActiveRecord::Migration
  def change
    create_table :med_eno_diagnostico do |t|
    	t.references :eno #eno_id
    	t.references :diagnostico #diagnostico_id
    	t.string :tipo_vigilancia
    	t.string :frecuencia_notificacion
    	t.integer :prioridad
      t.timestamps null: false
    end
  end
end
