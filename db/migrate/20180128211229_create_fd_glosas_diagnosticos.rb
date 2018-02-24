class CreateFdGlosasDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fd_glosas_diagnosticos do |t|
    	t.references :glosa
    	t.references :diagnostico
      t.timestamps null: false
    end
  end
end
