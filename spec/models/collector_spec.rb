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

require 'spec_helper'

describe Collector do
  pending "add some examples to (or delete) #{__FILE__}"
end
