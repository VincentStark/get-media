# == Schema Information
#
# Table name: downloads
#
#  id           :integer         not null, primary key
#  collector_id :integer         not null
#  user_id      :integer         not null
#  url          :string(255)     not null
#  status       :integer         default(1), not null
#  type         :integer         not null
#  title        :string(255)     not null
#  author       :string(255)     not null
#  length       :integer         not null
#  size         :integer         not null
#  progress     :integer         not null
#  quality      :string(255)     not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  thumbnail    :string(255)
#  bitrate      :integer
#

class Download < ActiveRecord::Base
  attr_accessible :url, :status, :type,
                  :title, :author, :length, :size, :progress,
                  :quality, :thumbnail, :bitrate,
                  :user, :collector

  set_inheritance_column :ruby_type

  belongs_to :user
  belongs_to :collector

  validates :user_id, presence: true
  validates :collector_id, presence: true
end
