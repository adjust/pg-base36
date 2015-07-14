require 'spec_helper'

describe 'base36' do
  before do
    install_extension
  end

  describe 'conversion' do
	  it 'should encode integer' do
	  	query('SELECT 120::bigint::base36').should match '3c'
	  end

	  it 'should decode text' do
	  	query("SELECT '3c'::base36::bigint").should match '120'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT '3caaaaaaaaaaaaa'::base36::bigint")}.to throw_error 'value "3caaaaaaaaaaaaa" is out of range for type base36'
	  end

	  it 'should cast big base36 values' do
	  	query("SELECT '1y2p0ij32e8e7'::base36::bigint").should match 9223372036854775807
	  end

	  it 'should cast big int values' do
	  	query("SELECT 9223372036854775807::base36").should match '1y2p0ij32e8e7'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT '1y2p0ij32e8e8'::base36::bigint")}.to throw_error 'value "1y2p0ij32e8e8" is out of range for type base36'
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
