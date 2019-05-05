class AddConfirmationTokenAndConfirmedAtToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :confirmation_token, :string, after: :password_digest
    add_column :users, :confirmed_at, :datetime, after: :confirmation_token

    User.update_all(confirmed_at: DateTime.now)
  end

  def down
    remove_columns :users, :confirmation_token, :confirmed_at
  end
end
