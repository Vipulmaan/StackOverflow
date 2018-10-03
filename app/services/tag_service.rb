class TagService

  def initialize(params)
    @taggable_id = params[:taggable_id]
    @taggable_type = params[:taggable_type]

    
  end


  def update_tag(name)
      @available_tag = find_tag(name)
      @available_tag.update_attributes(name: name)
    end

  def delete_tag(name)
    find_tag(name).destroy
  end

  def create_tag(tag_name)
    @tag= AvailableTag.find_by(name: tag_name)
    if @tag.present?
    Tag.create!(available_tags_id: @tag.id,taggable_type: @taggable_type, taggable_id: @taggable_id)
    else
      @available_tag=AvailableTag.create!(name: tag_name)
      Tag.create!( available_tags_id: @available_tag.id , taggable_type: @taggable_type , taggable_id: @taggable_id)
   end
  end

  def find_tag(tag_name)
    @tag= AvailableTag.find_by!(name: tag_name)
    end


end