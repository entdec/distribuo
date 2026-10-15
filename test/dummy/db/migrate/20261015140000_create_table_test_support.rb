# Test-host dependencies: Mensa views belong to users and icons use Active Storage.
class CreateTableTestSupport < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
    end

    create_table :active_storage_blobs, id: :uuid do |t|
      t.string :key, null: false
      t.string :filename, null: false
      t.string :content_type
      t.text :metadata
      t.string :service_name, null: false
      t.bigint :byte_size, null: false
      t.string :checksum
      t.datetime :created_at, null: false
      t.index :key, unique: true
    end
    create_table :active_storage_attachments, id: :uuid do |t|
      t.string :name, null: false
      t.references :record, null: false, polymorphic: true, type: :uuid
      t.references :blob, null: false, type: :uuid, foreign_key: {to_table: :active_storage_blobs}
      t.datetime :created_at, null: false
      t.index [:record_type, :record_id, :name, :blob_id], unique: true, name: :index_active_storage_attachments_uniqueness
    end
    create_table :active_storage_variant_records, id: :uuid do |t|
      t.belongs_to :blob, null: false, type: :uuid, foreign_key: {to_table: :active_storage_blobs}
      t.string :variation_digest, null: false
      t.index [:blob_id, :variation_digest], unique: true, name: :index_active_storage_variant_records_uniqueness
    end
  end
end
