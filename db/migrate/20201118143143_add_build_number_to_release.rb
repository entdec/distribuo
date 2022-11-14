class AddBuildNumberToRelease < ActiveRecord::Migration[6.0]
  def change
    add_column :distribuo_releases, :build_number, :string
  end
end
