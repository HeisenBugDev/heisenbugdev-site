# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  version           :string(255)
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_builds_on_project_id  (project_id)
#

require 'spec_helper'

describe Build do
  let(:project) { FactoryGirl.create(:project) }
  let(:build) { FactoryGirl.create(:build, :project => project) }

  subject { build }
  it { should validate_presence_of(:build_number) }
  it { should validate_presence_of(:version) }
  it { should validate_presence_of(:commit) }
  it { should validate_presence_of(:minecraft_version) }
end
