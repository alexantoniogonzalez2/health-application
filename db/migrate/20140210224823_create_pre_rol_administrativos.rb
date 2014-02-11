class CreatePreRolAdministrativos < ActiveRecord::Migration
  def change
    create_table :pre_rol_administrativos do |t|
      t.text :nombre
      
      t.timestamps
    end
  end
end
