class Post < ApplicationRecord

  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations

  def save_tags(tag_list)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(word: tag.downcase)
        begin
          self.tags.create!(word: tag)
        rescue
          nil
        end
      else
        PostTagRelation.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end
end
