class CreateSecretCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :secret_codes do |t|
      t.string :secret_code
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
