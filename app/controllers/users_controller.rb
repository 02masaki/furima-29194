class UsersController < ApplicationController
  def show
    @nick_name = current_user.nick_name
    @items = current_user.items
  end
end
