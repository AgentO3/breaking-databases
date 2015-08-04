class UseCacheController < ApplicationController
  def before
    offset = rand(50)
    @users = User.offset(offset).limit(20)
  end

  def after
    @offset = rand(50)
    @users = User.offset(@offset).limit(20)
  end

end
