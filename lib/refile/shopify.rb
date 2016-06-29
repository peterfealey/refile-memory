require "refile"
require "refile/shopify/version"

module Refile
  module Shopify
    class Backend
      extend Refile::BackendMacros
      attr_reader :directory

      attr_reader :max_size
      
      def verify_id(method)
		  mod = Module.new do
			define_method(method) do |id|
			  id = self.class.decode_id(id)
			  # if self.class.valid_id?(id)
# 				super(id)
# 			  else
# 				raise Refile::InvalidID
# 			  end
			end
		  end
		  prepend mod
      end
	  
	  def verify_uploadable(method)
      mod = Module.new do
        define_method(method) do |uploadable|
          # [:size, :read, :eof?, :rewind, :close].each do |m|
#             unless uploadable.respond_to?(m)
#               raise Refile::InvalidFile, "does not respond to `#{m}`."
#             end
#           end
          if max_size and uploadable.size > max_size
            raise Refile::InvalidMaxSize, "#{uploadable.inspect} is too large"
          end
          super(uploadable)
        end
      end
      prepend mod
    end
	  
	  
	  
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
