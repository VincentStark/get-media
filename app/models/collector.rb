# == Schema Information
#
# Table name: collectors
#
#  id           :integer         not null, primary key
#  ip           :string(255)     not null
#  uptime       :integer         not null
#  status       :integer         not null
#  host_os      :string(255)     not null
#  host_la      :string(255)     not null
#  storage_used :integer         not null
#  storage_free :integer         not null
#  memory_used  :integer         not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  is_blocked   :integer         default(0), not null
#  checked_at   :datetime
#  url_port     :integer         default(8080), not null
#

class Collector < ActiveRecord::Base
  attr_accessible :ip, :uptime, :status, :host_os, :host_la,
                  :storage_used, :storage_free, :memory_used,
                  :is_blocked, :checked_at, :url_port

  has_many :downloads
  has_many :users, :through => :downloads

  scope :downloads_count,
        joins('LEFT JOIN downloads ON downloads.collector_id = collectors.id')
          .select('collectors.*, COUNT(collectors.id) AS downloads_total')
          .group('collectors.id, collectors.ip, collectors.uptime,
                  collectors.status, collectors.host_os, collectors.host_la,
                  collectors.storage_used, collectors.storage_free,
                  collectors.memory_used, collectors.created_at, collectors.updated_at,
                  collectors.is_blocked, collectors.checked_at, collectors.url_port')

  scope :bitrate_count,
        joins('LEFT JOIN downloads ON downloads.collector_id = collectors.id')
          .select('collectors.*, COALESCE(SUM(downloads.bitrate), 0) AS downloads_bitrate')
          .group('collectors.id, collectors.ip, collectors.uptime,
                  collectors.status, collectors.host_os, collectors.host_la,
                  collectors.storage_used, collectors.storage_free,
                  collectors.memory_used, collectors.created_at, collectors.updated_at,
                  collectors.is_blocked, collectors.checked_at, collectors.url_port')
end
