class CreateDistribuoDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :distribuo_downloads, type: :uuid do |t|
      t.references :distribuo_release, null: false, foreign_key: true, type: :uuid
      t.string :ip

      t.timestamps
    end
  end
end
