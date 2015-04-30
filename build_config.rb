MRuby::CrossBuild.new('hexes') do |conf|
  toolchain :gcc

  conf.gembox 'default'
  conf.gem '../../hexes'
  conf.gem github: 'iij/mruby-io'
  conf.gem github: 'matsumoto-r/mruby-sleep'
end
