require_relative 'connection_adapter'

module ActiveRecord
	class Base
		@@connection = SqliteAdapter.new

		def initialize attributes
			@attributes = attributes
		end

		def method_missing(name, *args)
			if self.class.columns.include?(name)
				@attributes[name]
			else
				super
			end
		end

		class << self
			def find id
				find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
			end

			def all
				find_by_sql("SELECT * FROM #{table_name}")
			end

			def find_by_sql(sql)
				rows = @@connection.execute(sql)
				rows.map do |row|
					new map_values_to_columns(row)
				end
			end

			def map_values_to_columns(values)
				Hash[columns.zip(values)]
			end

			def columns
				@@connection.columns(table_name)
			end

			def table_name
				name.downcase + 's'
			end
		end
	end
end
