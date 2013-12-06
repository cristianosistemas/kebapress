module Kebapress
  class Post < ActiveRecord::Base
    scope :published, -> { where.not(published_at: nil) }
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :categories

    validates :title, presence: true
    validates :body, presence: true
    #validates :commentable, presence: true, inclusion: { in: [true, false] }
  end
end
