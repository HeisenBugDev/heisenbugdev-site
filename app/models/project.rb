# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  articles_repo :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Project < ActiveRecord::Base
  has_many :builds, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :articles_repo
  validates_presence_of :description

  validates_uniqueness_of :name

  after_initialize :init

  def init
    self.articles_repo ||= "HeisenBugDev/#{self.name}"
    self.description ||= "Such description! Much information!"
  end
end
