class Review < ActiveRecord::Base
	validates :recipe_id, presence: true
	validates :chef_id, presence: true
	validates :comment, presence: true, length: { minimum: 10, maximum: 100 }
	belongs_to :recipe
	belongs_to :chef
end