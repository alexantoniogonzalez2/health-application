class CreateTraRegionesComunas < ActiveRecord::Migration
  def change
    create_table :tra_regiones_comunas do |t|
    	t.references :region #region_id
    	t.references :comuna #comuna_id
    	
      t.timestamps
    end
  end
end
