# Representative data for manually running Mensa's verifier in this test host.
User.find_or_create_by!(name: 'Table administrator')
app = Distribuo::App.find_or_create_by!(name: 'Verifier iOS app') do |record|
  record.operating_system = 'ios'
  record.release_type = 'beta'
end
other = Distribuo::App.find_or_create_by!(name: 'Verifier Android app') do |record|
  record.operating_system = 'android'
end
if !app.icon.attached? || app.icon.blob.content_type != 'image/png'
  app.icon.attach(io: StringIO.new(Base64.decode64('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jRZkAAAAASUVORK5CYII=')), filename: 'icon.png', content_type: 'image/png')
end
[[app, '2.0'], [other, '1.0']].each do |owner, version|
  next if owner.releases.exists?

  id = SecureRandom.uuid
  Distribuo::Release.insert_all!([{id: id, app_id: owner.id, position: 1, version: version, build_number: '42', bundle_id: 'org.example.mobile', created_at: Time.current, updated_at: Time.current}])
  next unless owner == app

  ['127.0.0.1', '127.0.0.1', '127.0.0.2'].each do |ip|
    Distribuo::Download.create!(distribuo_release_id: id, ip: ip)
  end
end
