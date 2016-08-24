Gem::Specification.new do |s|
  s.name = "llrb"
  s.version = "0.1.0"
  s.license = "MIT"
  s.authors = ["Dmitry Maksimov"]
  s.email = "dmtmax@gmail.com"
  s.homepage = "https://github.com/kolo/llrb"
  s.summary = "llrb-0.1.0"
  s.description = "Ruby implementation of Left-leaning Red-black tree"

  s.files = `git ls-files -- lib/*`.split("\n")
  s.files += ["LICENSE.md"]
  s.test_files = `git ls-files -- test/*`.split("\n")
end
