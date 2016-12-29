class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :organization, index: true
      
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable
      
      # Google+ API
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.string  :name,  null: false
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
