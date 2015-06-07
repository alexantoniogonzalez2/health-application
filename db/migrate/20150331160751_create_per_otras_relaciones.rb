class CreatePerOtrasRelaciones < ActiveRecord::Migration
  def change
    create_table :per_otras_relaciones do |t|
    	t.references :persona	#persona_id	
      t.references :persona_relacion #persona_relacion_id
      t.string :relacion
      t.timestamps
    end
  end
end
