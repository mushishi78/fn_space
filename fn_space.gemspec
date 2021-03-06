# coding: utf-8

Gem::Specification.new do |s|
  s.name         = 'fn_space'
  s.version      = '1.0.1'
  s.author       = 'Max White'
  s.email        = 'mushishi78@gmail.com'
  s.homepage     = 'https://github.com/mushishi78/fn_space'
  s.summary      = 'A Ruby class for explicit importing and exporting'
  s.license      = 'MIT'
  s.files        = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  s.require_path = 'lib'
  s.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
end
