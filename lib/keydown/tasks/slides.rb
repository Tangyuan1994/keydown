class Keydown < Thor

  desc "slides FILE", "Convert a Keydown FILE into an HTML presentation"
  def slides(file)

    file += '.md' unless file.match(/\.md$/)

    unless File.exist?(file)
      say "#{file} not found. Please call with a KeyDown Markdown file: keydown slides my_file.md", :red
      return
    end

    keydown_text = File.new(file).read

    @@template_dir = File.join(Keydown.source_root, 'templates', 'rocks')

    presentation = file.gsub('md', 'html')

    say "Creating KeyDown presentation from #{file}", :yellow
    create_file presentation do
      SlideDeck.new(keydown_text).to_html
    end
  end
end