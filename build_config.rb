MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  conf.gembox 'default'
  conf.gem '../../hexes'
  conf.gem github: 'iij/mruby-io'
  conf.gem github: 'matsumoto-r/mruby-sleep'
end
