# == Schema Information
#
# Table name: artifacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  artifact   :string(255)
#  build_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  downloads  :integer
#  file_size  :string(255)
#
# Indexes
#
#  index_artifacts_on_build_id  (build_id)
#

class Artifact < ActiveRecord::Base
  belongs_to :build

  mount_uploader :artifact, ArtifactUploader

  validates_presence_of :name
  validates_presence_of :build

  before_save :update_artifact_attributes
  after_save :update_parent_downloads

  def update_parent_downloads
    build.save
  end

  private

  def update_artifact_attributes
    if artifact.present? && artifact_changed?
      self.file_size = artifact.file.size
    end
  end
end
