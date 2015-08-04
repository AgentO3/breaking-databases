class UseIndexesController < ApplicationController
  def before
    user_id = rand(1000)
    @prescription = BadPrescription.joins(:user).find(user_id)
  end

  def after
    user_id = rand(1000)
    @prescription = GoodPrescription.joins(:user).find(user_id)
  end
end
