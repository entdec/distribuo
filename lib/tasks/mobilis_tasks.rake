# frozen_string_literal: true

desc 'Release a new version'
namespace :mobilis do
  task :release do
    version_file = './lib/mobilis/version.rb'
    File.open(version_file, 'w') do |file|
      file.puts <<~EOVERSION
        # frozen_string_literal: true

        module Mobilis
          VERSION = '#{Mobilis::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
        end
      EOVERSION
    end
    module Mobilis
      remove_const :VERSION
    end
    load version_file
    puts "Updated version to #{Mobilis::VERSION}"

    `git commit lib/mobilis/version.rb -m "Version #{Mobilis::VERSION}"`
    `git push`
    `git tag #{Mobilis::VERSION}`
    `git push --tags`
  end
end
