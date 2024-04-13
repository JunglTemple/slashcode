Gem::Specification.new do |spec|
  spec.name          = "slashcode"
  spec.version       = "0.0.1"
  spec.authors       = ["JunglTemple", "XxDreamXxXx"]
  spec.summary       = "slashcode: The language based on the slash"
  spec.homepage      = "https://github.com/JunglTemple/slashcode"
  spec.license       = "MIT"

  # Add the config directory to the files
  spec.files         = Dir["lib/**/*", "config/**/*"]

  spec.bindir        = "bin"
  spec.executables   = ["slash"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.1"
  spec.add_dependency "toml", "~> 0.2.0" 
end
