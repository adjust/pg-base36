require 'spec_helper'

describe 'base36' do
  before do
    install_extension
  end

  describe 'conversion' do
	  it 'should encode integer' do
	  	query('SELECT 120::base36').should match '3c'
	  end

	  it 'should decode text' do
	  	query("SELECT '3c'::base36::int").should match '120'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT '3caaaaaaaaaaaaa'::base36::bigint")}.to throw_error 'value "3caaaaaaaaaaaaa" is out of range for type base36'
	  end

	  it 'should cast big base36 values' do
	  	query("SELECT 'zik0zj'::base36::int").should match 2147483647
	  end

	  it 'should cast big int values' do
	  	query("SELECT 2147483647::base36").should match 'zik0zj'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT 'zik0zk'::base36::int")}.to throw_error 'value "zik0zk" is out of range for type base36'
	  end

	  it 'should error invalid values' do
	  	expect{query("SELECT '3&'::base36::bigint")}.to throw_error 'value "&" is not a valid digit for type base36'
	  end
	end

	describe 'comparison' do
		it 'should compare using >' do
			query("SELECT 'a'::base36 > 'b'::base36").should match 'f'
		end

		it 'should compare using <' do
			query("SELECT 'a'::base36 < 'b'::base36").should match 't'
		end
	end
end
