module Neoon
  module Client
    module Indexing

      def list(label)
        Neoon.db.get("/schema/index/#{label}")
          .map{|f| f.send("property-keys")}.flatten.map(&:to_sym).sort
      end

      def create(label, keys = [])
        keys.each do |key|
          Neoon.db.cypher("CREATE INDEX ON :#{label}(#{key.to_s.downcase})")
        end
      end

      def drop(label, keys = [])
        keys.each do |key|
          Neoon.db.cypher("DROP INDEX ON :#{label}(#{key.to_s.downcase})")
        end
      end

    end
  end
end
