def authenticated_user(&blk)
  context "as an authenticated user" do
    setup do
      @user = Factory(:user)
      activate_authlogic
      UserSession.create(@user)
    end

    merge_block(&blk)
  end  
end