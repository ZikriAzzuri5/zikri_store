class AddPasswordConfirmationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_confirmation_token, :string, after: :confirmed_at
  end
end
