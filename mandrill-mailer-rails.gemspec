Gem::Specification.new do |s|
  s.name        = 'mandrill-mailer-rails'
  s.version     = '1.1.0'
  s.authors     = ['Tinfoil Security, Inc.']
  s.email       = ['engineers@tinfoilsecurity.com']
  s.homepage    = 'https://www.github.com/tinfoil/mandrill-mailer-rails'
  s.summary     = %q{Handler for Rails to send emails through Mandrill}
  s.description = %q{Provides an ActionMailer delivery handler sending emails through Mandrill}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency('mandrill-api')
  s.add_dependency('rails', '> 3.0')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec-rails')
  s.add_development_dependency('rspec-mocks')
  s.add_development_dependency('appraisal')
end
