Gem::Specification.new do |s|
  s.name        = 'mandrill-mailer-rails'
  s.version     = '0.0.1'
  s.authors     = ['Tinfoil Security, Inc.']
  s.email       = ['engineers@tinfoilsecurity.com']
  s.homepage    = 'https://www.github.com/bsedat/mandrill-mailer-rails'
  s.summary     = %q{Handler for Rails to send emails through Mandrill}
  s.description = %q{Provides an ActionMailer delivery handler sending emails through Mandrill}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency('mandrill-api')
  s.add_dependency('rails')

  s.add_development_dependency('rake')
end
