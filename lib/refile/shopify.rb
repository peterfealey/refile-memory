require "refile"
require "refile/shopify/version"

module Refile
  module Shopify
    class Backend
      extend Refile::BackendMacros
      attr_reader :directory

      attr_reader :max_size

      def initialize(max_size: nil, hasher: Refile::RandomHasher.new)
        @hasher = hasher
        @max_size = max_size
        @store = {}
      end

      verify_uploadable def upload(uploadable)
        id = @hasher.hash(uploadable)

        @store[id] = uploadable.read

        #Refile::File.new(self, id)
        ShopifyAPI::Asset.new(:key => uploadable.original_filename, :attach => uploadable.tempfile)
      end

      verify_id def get(id)
        #Refile::File.new(self, id)
        ShopifyAPI::Asset.new(:key => id.original_filename, :attach => uploadable.tempfile)
      end

      verify_id def delete(id)
        #@store.delete(id)
        ShopifyAPI::Asset.destroy(id)
      end

      verify_id def open(id)
        ShopifyAPI::Asset.find(id)
        #StringIO.new(@store[id])
      end

      verify_id def read(id)
        @store[id]
      end

      verify_id def size(id)
        @store[id].bytesize if exists?(id)
      end

      verify_id def exists?(id)
        @store.has_key?(id)
      end

      def clear!(confirm = nil)
        raise Refile::Confirm unless confirm == :confirm
        @store = {}
      end
    end
  end
end
