# frozen_string_literal: true

require 'app_parser'

module Distribuo
  module PackageParser
    def self.parse(file_name)
      # Keep app_parser's file validation and Android parser; its IPA parser
      # still passes absolute extraction paths using the Rubyzip 2 API.
      raise ::AppParser::NotFoundError, file_name unless File.exist?(file_name)

      if ::AppParser.detect_os(file_name) == 'ios'
        Ipa.new(file_name)
      else
        ::AppParser.parse(file_name)
      end
    end

    class Ipa < ::AppParser::Ipa
      def icon_data(file_name)
        Dir.mktmpdir do |directory|
          find_entry(file_name).extract('src', destination_directory: directory)
          source = File.join(directory, 'src')
          destination = File.join(directory, 'dest')
          Pngdefry.defry(source, destination)
          File.binread(destination)
        end
      end

      private

      def search_icons(ipad: false)
        icon_names = info_plist.dig("CFBundleIcons#{'~ipad' if ipad}", 'CFBundlePrimaryIcon', 'CFBundleIconFiles')
        Dir.mktmpdir do |directory|
          Array(icon_names).flat_map do |name|
            find_entries("#{name}*").filter_map do |entry|
              next unless entry.name.include?('~ipad') == ipad

              filename = File.basename(entry.name)
              entry.extract(filename, destination_directory: directory)
              {dimensions: Pngdefry.dimensions(File.join(directory, filename)), file_name: filename}
            end
          end
        end
      end
    end
  end
end
