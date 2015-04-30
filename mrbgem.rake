MRuby::Gem::Specification.new('hexes') do |spec|
  spec.license = 'MIT'
  spec.author = 'Oscar Esgalha'
  spec.linker.flags_before_libraries << "-lncurses"
end
