require 'spec_helper'

describe 'bigbase36' do
  before do
    install_extension
  end

  describe 'conversion' do
	  it 'should encode integer' do
	  	query('SELECT 120::bigint::bigbase36').should match '3c'
	  end

	  it 'should decode text' do
	  	query("SELECT '3c'::bigbase36::bigint").should match '120'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT '3caaaaaaaaaaaaa'::bigbase36::bigint")}.to throw_error 'value "3caaaaaaaaaaaaa" is out of range for type bigbase36'
	  end

	  it 'should cast big bigbase36 values' do
	  	query("SELECT '1y2p0ij32e8e7'::bigbase36::bigint").should match 9223372036854775807
	  end

	  it 'should cast big bigint values' do
	  	query("SELECT 9223372036854775807::bigbase36").should match '1y2p0ij32e8e7'
	  end

	  it 'should error to big values' do
	  	expect{query("SELECT '1y2p0ij32e8e8'::bigbase36::bigint")}.to throw_error 'value "1y2p0ij32e8e8" is out of range for type bigbase36'
	  end

	  it 'should error invalid values' do
	  	expect{query("SELECT '3&'::bigbase36::bigint")}.to throw_error 'value "&" is not a valid digit for type bigbase36'
	  end
	end

	describe 'comparison' do
		it 'should compare using >' do
			query("SELECT 'a'::bigbase36 > 'b'::bigbase36").should match 'f'
		end

		it 'should compare using <' do
			query("SELECT 'a'::bigbase36 < 'b'::bigbase36").should match 't'
		end
	end

	describe 'negative values' do
		it 'should convert from base36' do
			query("SELECT '-zik0zj'::bigbase36::bigint").should match -2147483647
		end

		it 'should convert from ints' do
			query("SELECT '-2147483647'::bigint::bigbase36").should match '-zik0zj'
		end
	end
end
