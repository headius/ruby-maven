require_relative 'setup'
require 'maven/ruby/maven'

describe Maven::Ruby::Maven do

  subject { Maven::Ruby::Maven.new }

  let(:pkg) { File.expand_path("../pkg", __dir__) }

  it 'shows mvn commandline with verbose flag' do
    CatchStdout.exec do
      subject.exec( '-Dverbose', 'validate' )
    end
    subject.verbose = false
    _(CatchStdout.result).must_match /mvn -Dverbose validate/
  end

  it 'takes declared jruby version' do
    begin
      subject.inherit_jruby_version '9.0.4.0'
      subject.exec( '-X', 'initialize', '-l', "#{pkg}/log1.txt" )
      _(File.read("#{pkg}/log1.txt")).must_match /resolve jruby for version 9.0.4.0/
    ensure
      subject['jruby.version'] = nil
    end
  end

  if defined? JRUBY_VERSION
    it 'inherits jruby version' do
      subject.inherit_jruby_version
      subject.exec( '-X', 'initialize', '-l', "#{pkg}/log2.txt" )
      _(File.read("#{pkg}/log2.txt")).must_match /resolve jruby for version #{JRUBY_VERSION}/
    end
  else
    it 'takes default jruby version with inherit jruby version' do
      subject.inherit_jruby_version
      subject.exec( '-X', 'initialize', '-l', "#{pkg}/log3.txt" )
      _(File.read("#{pkg}/log3.txt")).must_match /resolve jruby for version 9.3.1.0/
    end
  end
 end
