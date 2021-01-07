class Tag < ApplicationRecord
  before_save :downcase_tag_name

  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  private

  def downcase_tag_name
    self.tag_name.downcase!
  end
end
