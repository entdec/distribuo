# Mensa's default discovery only scans the host app/tables directory.
Rake::Task['mensa:verify_all'].clear_actions
namespace :mensa do
  task verify_all: :environment do
    classes = Mensa::Verifier.table_classes(Distribuo::Engine.root.join('app/tables'))
    classes -= [Distribuo::ApplicationTable]
    exit(1) unless Mensa::Verifier.run(classes)
  end
end
