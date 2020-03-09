$:.unshift File.expand_path("../lib", __FILE__)
require "sud/version"

Gem::Specification.new do |s|
    s.name        = 'sud'
    s.version     = Sud::VERSION
    s.platform    = Gem::Platform::RUBY
    s.summary     = "A tool to streamline project management"
    s.description = "Sud is a tool to help streamline and improve project management"
    s.authors     = ["BSFishy"]
    # s.email       = ''
    # s.files       = ["lib/sud.rb"]
    s.homepage    = 'https://github.com/bitmodo/sud'
    s.license     = 'MIT'

    root_path      = File.dirname(__FILE__)
    all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
    all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
    # all_files.reject! { |file| file.start_with?("website/") }
    # all_files.reject! { |file| file.start_with?("test/") }
    gitignore_path = File.join(root_path, ".gitignore")
    gitignore      = File.readlines(gitignore_path)
    gitignore.map!    { |line| line.chomp.strip }
    gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

    unignored_files = all_files.reject do |file|
        # Ignore any directories, the gemspec only cares about files
        next true if File.directory?(file)

        # Ignore any paths that match anything in the gitignore. We do
        # two tests here:
        #
        #   - First, test to see if the entire path matches the gitignore.
        #   - Second, match if the basename does, this makes it so that things
        #     like '.DS_Store' will match sub-directories too (same behavior
        #     as git).
        #
        gitignore.any? do |ignore|
        File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
            File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
        end
    end

    s.files         = unignored_files
    s.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
    s.require_path  = 'lib'
end
