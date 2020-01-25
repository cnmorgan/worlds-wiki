class World < ApplicationRecord

    scope :are_public, -> { where(is_private: false) }
    scope :has_admin, -> (user){ 
        joins(:admins).where(user_id: user.id) 
    }
    scope :visible_to, -> (user){ 
        if user
            are_public.joins(:admins).or(World.has_admin(user)) 
        else
            are_public
        end
    }


    belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
    has_many :admin_privileges, dependent: :destroy
    has_many :admins, :through => :admin_privileges, :source => :user
    has_one :sub_wiki, dependent: :destroy

    validates :name, presence: true, uniqueness: true, length: {maximum: 50}
    after_create :initialize_wiki, :default_admin


    def is_admin?(user)
        user && (!user.admin_privileges.where(world: self).empty? || self.owner.username == user.username)
    end

    def make_admin(user)
        user.admin_worlds << self unless user.admin_worlds.where(name: self.name).count > 0
    end
    

    private

        def default_admin
            self.owner.admin_privileges.create(world_id: self.id)
        end
        

        def initialize_wiki
            self.sub_wiki = SubWiki.new() if self.sub_wiki.nil?
        end

        def validate_world_name
            w = World.find_by(name: self.name)

            errors.add(:name, message: "Name must be unique") unless w.nil?
        end


end
