class MysqlN1QueriesController < ApplicationController
  
  def before
    offset = rand(1000)
    @users = User.offset(offset).limit(10)
  end

  def after
    offset = rand(1000)
    @users = User.includes(:emails).offset(offset).limit(10)
  end
end
