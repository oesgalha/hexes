MRuby::CrossBuild.new('minimal') do |conf|
  toolchain :gcc

  conf.gembox 'default'
  conf.gem github: 'iij/mruby-io'

  conf.cc.defines = %w(DISABLE_STDIO)
  conf.bins = []
end
