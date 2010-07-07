namespace :rich_text do
  task :install => :environment do
    tiny_mce_version = "3.2.6"
    js_folder = File.expand_path(File.join(RAILS_ROOT, "public", "javascripts")).gsub(" ", "\\ ")
    css_folder = File.expand_path(File.join(RAILS_ROOT, "public", "stylesheets")).gsub(" ", "\\ ")
    image_folder = File.expand_path(File.join(RAILS_ROOT, "public", "images")).gsub(" ", "\\ ")
    
    puts "exporting tinymce #{tiny_mce_version} to #{js_folder}/tiny_mce"
    `svn export https://tinymce.svn.sourceforge.net/svnroot/tinymce/tinymce/tags/#{tiny_mce_version}/jscripts/tiny_mce #{js_folder}/tiny_mce`

    assets_folder = File.join(File.dirname(__FILE__), "..", "assets").gsub(" ", "\\ ")

    puts "Copying rich text js, stylesheets and tinymce skin"
    `cp #{assets_folder}/rich_text.js #{js_folder}`
    `cp #{assets_folder}/thickbox.compressed.js #{js_folder}`
    `cp #{File.join(assets_folder, 'thickbox.css')} #{css_folder}`
    `cp #{File.join(assets_folder, 'loadingAnimation.gif')} #{image_folder}`
    `cp -r #{assets_folder}/sheba #{js_folder}/tiny_mce/themes/advanced/skins/`
  end
end
