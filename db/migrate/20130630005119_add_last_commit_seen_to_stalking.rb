class AddLastCommitSeenToStalking < ActiveRecord::Migration
  def change
    add_column :stalkings, :last_commit_seen, :string
  end
end
