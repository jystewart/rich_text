module RichTextHelper
  def rich_text_tags(css_selector)
    js = javascript_include_tag('rich_text', 'thickbox.compressed.js', 'tiny_mce/jquery.tinymce.js')
    css = stylesheet_link_tag('thickbox')
    script = javascript_tag('$(document).ready(function () { SHEBA.RichText.init("' + css_selector + '"); });')
    js + css + script
  end
end
