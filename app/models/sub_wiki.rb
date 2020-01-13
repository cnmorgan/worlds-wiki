class SubWiki < ApplicationRecord

    belongs_to :world
    has_many :categories, dependent: :destroy
    has_many :pages, dependent: :destroy

end
