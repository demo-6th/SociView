class AddTrackableToUser < ActiveRecord::Migration[6.0]
  def change
    # Trackable
<<<<<<< HEAD
    add_column :users, :sign_in_count, :integer, default: 0, null: false 
=======
    add_column :users, :sign_in_count, :integer, default: 0, null: false
>>>>>>> finsih and setbackpoint
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    #AddOmniauthToUsers
    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_index :users, :fb_uid
  end
end
