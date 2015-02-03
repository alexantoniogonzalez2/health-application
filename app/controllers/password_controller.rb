class PasswordController < Devise::PasswordsController

	protected
  def after_resetting_password_path_for(resource)
    password_reseted_path 
  end
  def after_sending_reset_password_instructions_path_for(resource_name)
    password_reset_path   
  end

end
