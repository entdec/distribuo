class CreateDistribuoApps < ActiveRecord::Migration[6.0]
  def change
    create_table :distribuo_apps, id: :uuid do |t|
      t.string :name
      t.string :release_type
      t.string :operating_system
      t.references :mobiliable, type: :uuid, polymorphic: true, index: { name: 'index_app_on_mobiliable' }

      t.timestamps
    end
  end
end
