require "smush/version"

module Smush
  class << self
    def smush(hash, key_stack=[])
      if hash.is_a?(Array)
        hash.map.with_index { |h, i|
          smush(h, key_stack + [i])
        }.flatten
      elsif hash.is_a?(Hash)
        hash.inject([]) { |smushed, keyval|
          smushed + smush(keyval[1], key_stack + [keyval[0]])
        }
      else
        [{ key: key_stack, value: hash }]
      end
    end

    def unsmush(smushed)
      unsmushed = {}
      smushed.each { |h|
        bury!(unsmushed, *h[:key], h[:value])
      }
      unsmushed
    end

    # Non monkey-patching version of proposed Hash#bury method
    def bury!(hash, *args)
      if args.count < 1
        raise ArgumentError.new("Requires a location to bury")
      elsif args.count < 2
        raise ArgumentError.new("Requires a value to bury")
      elsif args.count == 2
        hash[args[0]] = args[1]
      else
        arg = args.shift
        # Assume an integer key in the chain means it's an array
        if args.first.is_a?(Integer)
          hash[arg] ||= []
        else
          hash[arg] ||= {}
        end
        bury!(hash[arg], *args) if args.any?
        hash
      end
    end
  end
end
