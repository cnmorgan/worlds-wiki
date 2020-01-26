class Page < ApplicationRecord

    scope :in, ->(world) { where(sub_wiki_id: world.sub_wiki.id) }
    scope :not_drafts, -> { where(is_draft: false) }
    
    belongs_to :sub_wiki, optional: true
    belongs_to :user, optional: true
    has_many :page_categories, dependent: :destroy
    has_many :categories, :through => :page_categories
    has_many :edits, dependent: :destroy
    
    validates :title, presence: true
    validate :unique_to_wiki, if: :page?
    validate :unique_to_user, if: :template?

    private

        def unique_to_wiki
            if !self.sub_wiki.pages.where(title: self.title).where.not(id: self.id).empty?
                self.errors.add(:title, "already exists") 
            end 
        end

        def unique_to_user
            if !self.user.templates.where(title: self.title).where.not(id: self.id).empty?
                self.errors.add(:title, "already exists")
            end  
        end

        def page?
            self.sub_wiki
        end
        
        def template?
            self.user
        end
        
        
        
end
