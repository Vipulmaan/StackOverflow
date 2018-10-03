class AvailableTagsController < ApplicationController

   before_action :authenticate_user


   def index
   	@tags=AvailableTag.all
   end

end
