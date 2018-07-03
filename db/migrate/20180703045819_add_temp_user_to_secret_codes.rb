class AddTempUserToSecretCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :secret_codes, :temp_user, :string
  end
end
