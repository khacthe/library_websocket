class FollowAuthorsController < ApplicationController
  before_action :logged_in_user

  def create
    @author = Author.find params[:author_id]
    current_user.follow_author @author
    respond_to do |format|
      format.html { redirect_to @author }
      format.js
    end
  end

  def destroy
    @author = FollowAuthor.find(params[:id]).author
    current_user.unfollow_author @author
    respond_to do |format|
      format.html { redirect_to @author }
      format.js
    end
  end
end
