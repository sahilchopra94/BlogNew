class Article < ApplicationRecord
	belongs_to :user
	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_attached_file :photo, :styles => { :small => "150*150>", :medium => "210*315>"}
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  validates :title, presence: true,  on: :create
  validates :body, presence: true,  on: :create
  validates :photo, presence: true,  on: :create

end
