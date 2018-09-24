class TagService

  def initialize(params)
    @taggable_id = params[:taggable_id]
    @taggable_type = params[:taggable_type]
  end


  def find_tag(id)
    Tag.find(id)
  end

  def update_tag(id, name)
    if tag_exist?
      tag = find_tag(id)
      tag.update_attributes(name: name, taggable_type: @taggable_type, taggable_id: @taggable_id)
    end
  end

  def delete_tag(id)
    Tag.find(id).destroy
  end

  def create_tag(name)
    Tag.create(name: name, taggable_type: @taggable_type, taggable_id: @taggable_id)
  end


  def tag_exist?
    Tag.exists?(taggable_type: @taggable_type, taggable_id: @taggable_id)
  end

end