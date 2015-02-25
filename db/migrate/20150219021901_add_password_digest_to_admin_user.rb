class AddPasswordDigestToAdminUser < ActiveRecord::Migration

  def up
    remove_column "Admin_users", "hashed_password"
    add_column "Admin_users", "password_digest", :string
  end

  def down
    remove_column "admin_users", "password_digest"
    add_column "admin_users", "hased_password", :string, :limit => 40
  end

end
