package { 'bundler':
  ensure => 'installed',
  provider => 'gem',
}

package { 'build-essential':
  ensure => 'present'
}

exec { "install gems":
    environment => "BUNDLE_GEMFILE=/home/vagrant/crunchbase_webapp/Gemfile",
    command => "bundle install",
    path    => "/opt/ruby/bin/:/usr/bin/:/bin/",
    unless => "bundle check",
    timeout     => 1800,
    require => [Package['bundler'], Package['build-essential']]
}

file {
  '/etc/init.d/crunchbase_app':
    ensure => present,
    source => '/home/vagrant/crunchbase_webapp/puppet/files/crunchbase_app';
}

service { 'crunchbase_app':
  ensure => 'running',
  require => [File['/etc/init.d/crunchbase_app'], Exec['install gems']]
}

