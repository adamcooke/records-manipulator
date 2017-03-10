Gem::Specification.new do |s|
  s.name          = "records_manipulator"
  s.description   = %q{Add manipulations to an Active Record scope to change the records when they are finally returned from the database}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/records-manipulator"
  s.version       = '1.0.1'
  s.files         = Dir.glob("{lib}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
end
