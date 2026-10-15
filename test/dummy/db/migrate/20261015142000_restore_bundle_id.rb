# The legacy dummy schema omitted this column from CreateDistribuoReleases.
class RestoreBundleId < ActiveRecord::Migration[7.1]
  def change
    add_column :distribuo_releases, :bundle_id, :string unless column_exists?(:distribuo_releases, :bundle_id)
  end
end
