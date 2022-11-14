class CreateDistribuoReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :distribuo_releases, id: :uuid do |t|
      t.references :app, type: :uuid, index: true
      t.string :bundle_id
      t.integer :position
      t.string :version
      t.text :notes

      t.timestamps
    end
  end
end
