# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

require "dry/configurable"
require "forwardable"

# @example
#
#   AssetMapper.configure do |config|
#     config.manifest_files = "public/asset_manifest.json"
#     config.asset_host = "/"
#   end
module AssetMapper
  extend ::Forwardable
  extend ::Dry::Configurable

  # Where to find the json mapping of your asset files.
  setting :manifest_files

  # In case you server off of a CDN, you may want to prepend urls.
  setting :asset_host, default: "/"

  def_delegators :manifest, :find_entrypoint, :find_asset

  def self.manifest
    @manifest ||= Manifest.new(self)
  end
end
