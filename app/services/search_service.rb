class SearchService

  def initialize(params)
    @search_in = params[:class]
    @column_name = params[:column]
    @data = params[:data]
  end


  def search
    @search_in.where("#{@column_name} LIKE ?", "%#{@data}%")
  end


end