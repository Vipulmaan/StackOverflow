class AuthService

  def initialize(params)
    @users = params[:class]
    @name = params[:name]
    @data = params[:data]
  end


  def search
    @search_in.where("#{@column_name} LIKE ?", "%#{@data}%")
  end


end