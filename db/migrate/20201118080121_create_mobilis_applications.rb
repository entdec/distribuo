class CreateMobilisApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :mobilis_applications, id: :uuid do |t|
      t.string :name
      t.string :release_type
      t.string :operating_system
      t.references :mobiliable, type: :uuid, polymorphic: true, index: { name: 'index_application_on_mobiliable' }

      t.timestamps
    end
  end
end
