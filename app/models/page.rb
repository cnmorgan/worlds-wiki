class Page < ApplicationRecord

    scope :in, ->(world) { where(sub_wiki_id: world.sub_wiki.id) }
    
    belongs_to :sub_wiki
    has_many :page_categories, dependent: :destroy
    has_many :categories, :through => :page_categories
    has_many :edits, dependent: :destroy
    
    validates :title, presence: true
    validate :unique_to_wiki

    private

        def unique_to_wiki
            if !self.sub_wiki.pages.where(title: self.title).where.not(id: self.id).empty?
                self.errors.add(:title, "already exists")
            end
        end
        
end
