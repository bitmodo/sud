module Sud
  # This will always be up to date with the current version of Sud,
  # since it is used to generate the gemspec and is also the source of
  # the version for `sud -v`
  VERSION = File.read(File.expand_path("../../../version.txt", __FILE__)).chomp
end
