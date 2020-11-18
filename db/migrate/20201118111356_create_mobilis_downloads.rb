class CreateMobilisDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :mobilis_downloads, type: :uuid do |t|
      t.references :mobilis_release, null: false, foreign_key: true, type: :uuid
      t.string :ip

      t.timestamps
    end
  end
end
