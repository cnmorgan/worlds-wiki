class Category < ApplicationRecord

    scope :in, ->(world) { where(sub_wiki_id: world.sub_wiki.id) }

    belongs_to :sub_wiki
    belongs_to :category, optional: true
    has_many :sub_categories, :class_name => "Category"
    has_many :page_categories, dependent: :destroy
    has_many :pages, :through => :page_categories

    validates :name, presence: true
    validate :unique_to_world

    private
        def unique_to_world
            unless self.sub_wiki.categories.where(name: self.name).where.not(id: self.id).empty?
                self.errors.add(:name, 'already exists')
            end
        end

end
