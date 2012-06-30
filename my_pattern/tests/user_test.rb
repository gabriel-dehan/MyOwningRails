require_relative 'test_helper'
require_relative '../active_record'
require_relative '../models/user'

class UserTest < Test::Unit::TestCase
	def test_initialize_with_attributes
		user = User.new(id: 1, name: 'Marc')
		assert_equal 1, user.id
		assert_equal "Marc", user.name
	end

	def test_map_values_to_columns
		values = [1, 'Marc']
		expected_attributes = { id: 1, name: 'Marc' }

		assert_equal expected_attributes, User.map_values_to_columns(values)
	end

	def test_columns
		assert_equal [:id, :name], User.columns
	end

	def test_find
		user = User.find 1
		assert_equal 1, user.id
	end

	def test_all
		user = User.all.first
		assert_equal 1, user.id
	end

	def test_case
		assert_equal 'users', User.table_name
	end
end