class CreateMobilisReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :mobilis_releases, id: :uuid do |t|
      t.references :application, type: :uuid, index: true
      t.text :notes

      t.timestamps
    end
  end
end
