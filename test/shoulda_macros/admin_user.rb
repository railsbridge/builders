def admin_user(&blk)
  context "as an admin user" do
    setup do
      @user = Factory(:user, :admin => true)
      activate_authlogic
      UserSession.create(@user)
    end

    merge_block(&blk)
  end
end
