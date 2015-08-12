require 'spec_helper'

describe 'base36 binary' do
  before do
    install_extension
  end

  it "should copy data binary from country" do
    query("CREATE TABLE before (a base36)")
    query("INSERT INTO before VALUES ('aa'), ('-aa'), ('zik0zj'), ('-zik0zj'), ('0')")
    query("CREATE TABLE after (a base36)")
    query("COPY before TO '/tmp/tst' WITH (FORMAT binary)")
    query("COPY after FROM '/tmp/tst' WITH (FORMAT binary)")
    query("SELECT * FROM after").should match \
    ['aa'],
    ['-aa'],
    ['zik0zj'],
    ['-zik0zj'],
    ['0']
  end
end

describe 'bigbase36 binary' do
  before do
    install_extension
  end

  it "should copy data binary from country" do
    query("CREATE TABLE before (a bigbase36)")
    query("INSERT INTO before VALUES ('aa'), ('-aa'), ('1y2p0ij32e8e7'), ('-1y2p0ij32e8e7'), ('0')")
    query("CREATE TABLE after (a bigbase36)")
    query("COPY before TO '/tmp/tst' WITH (FORMAT binary)")
    query("COPY after FROM '/tmp/tst' WITH (FORMAT binary)")
    query("SELECT * FROM after").should match \
    ['aa'],
    ['-aa'],
    ['1y2p0ij32e8e7'],
    ['-1y2p0ij32e8e7'],
    ['0']
  end
end