# -*- mode:ruby -*-

gemspec

properties 'push.skip': true, 'jruby.version': '9.2.9.0'

profile :id => :release do
  properties 'maven.test.skip' => true, 'invoker.skip' => true
  properties 'push.skip' => false
  build do
    default_goal :deploy
  end
end

# vim: syntax=Ruby
