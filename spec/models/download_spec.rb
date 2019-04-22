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

require 'spec_helper'

describe Download do
  
  let (:user) { FactoryGirl.create(:user) }
  let (:collector) { FactoryGirl.create(:collector) }  

  before do
    @download = Download.create!(:user => user, :collector => collector, :url => "http://ya.ru",
                  :status => 1, :type => 10, :title => "Movie 1", :author => "Big Boy",
                  :length => 3251, :size => 15107015, :progress => 75, :quality => "720p",
                  :thumbnail => "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/371562_1200125730_907550213_q.jpg")
  end

  subject { @download }

  it { should respond_to(:url) }
  it { should respond_to(:collector_id) }
  it { should respond_to(:collector) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  its(:collector) { should == collector }

  it { should be_valid }
end
