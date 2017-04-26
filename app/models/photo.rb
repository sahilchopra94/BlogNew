class Photo < ApplicationRecord
  belongs_to :article

  has_attached_file :photo, :styles => { :small => "150*150>", :medium => "210*315>"}
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
