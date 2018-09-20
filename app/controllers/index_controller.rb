class IndexController < ApplicationController
  def Index
    @users=User.all
  end
end
