var SHEBA = {

  RichText: {
    options: {
      script_url : '/javascripts/tiny_mce/tiny_mce.js',
      theme : "advanced",
      skin : "sheba",
      fix_nesting : true,
      button_tile_map : true,
      theme_advanced_toolbar_location : 'top',
      theme_advanced_toolbar_align : "left",
      theme_advanced_path : false,
      theme_advanced_resizing : true,
      theme_advanced_statusbar_location: 'bottom',
      extended_valid_elements : "object[classid|codebase|width|height|align|type|data],param[id|name|type|value|valuetype<DATA?OBJECT?REF]",
      theme_advanced_buttons1: "bold,italic,underline,strikethrough,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,bullist,numlist,separator,blockquote,separator,link,unlink,separator,formatselect,separator,pastetext,pasteword,code",
      theme_advanced_buttons2: "",
      theme_advanced_buttons3: "",
      theme_advanced_blockformats : "p,div,h3,h4,h5,h6,blockquote,dt,dd,code",
      media_strict: false,
      plugins: "paste",
      paste_create_paragraphs : false,
      paste_create_linebreaks : false,
      paste_use_dialog : true,
      paste_auto_cleanup_on_paste : true,
      paste_convert_middot_lists : false,
      paste_unindented_list_class : "unindentedList",
      paste_convert_headers_to_strong : true,

      height: '400',
      width: '300',

      relative_urls : false,
      convert_urls : false
    },
    
    init: function (selector) {
      $(selector).tinymce(SHEBA.RichText.options);
      $(selector).after('<p class="box important"><a href="#" class="add-video">Add a video</a> | <a class="thickbox add-image" href="/images/new?height=420&width=420">Add an image</a></p>');
      tb_init('a.thickbox');
      $('.add-video').click(SHEBA.Video.receive);
    }
  },
  
  Images: {
    display_options: function(options, caption, attribution, link) {
      $('#TB_ajaxContent #new_image, #TB_ajaxContent h2').hide();
      options_string = '';
      for (label in options) {
        options_string += '<p><a href="' + options[label] + '">' + label + '</a></p>'
      }
      $('#upload_frame').before('<h2>Image uploaded. Insert</h2>' + options_string);

      $('#TB_ajaxContent p a').click(function () {
        SHEBA.Images.insert($(this).attr('href'), caption, attribution, link);
        tb_remove();
        return false;
      });
    },
    
    insert: function (src, caption, attribution, link) {
      var new_html = '<div class="uploaded-image"><a href="' + link + '"><img src="' + src + '"></a>';
      
      if (caption && caption != '') {
        new_html += '<p class="caption">' + caption + '</p>';
      }
      if (attribution && attribution != '') {
        new_html += '<p class="attribution">' + attribution + '</p>';
      }
      new_html += '</div>';
      
      var $area = $('textarea:tinymce')
        
      try {
        $area.tinymce().execCommand('mceInsertContent', false, new_html);
      } catch (err) {
        if (console && console.log) { console.log(err); }
        $area.tinymce().setContent($area.tinymce().getContent() +  new_html);
      }
      
    }
  },
  
  Video: {
    receive: function () {
      var video_url = window.prompt("What's the URL of your video on youtube or vimeo?");
      if (video_url != '' && video_url != null) {
        try {
          var new_html = SHEBA.Video.identify(video_url);
          $('textarea:tinymce').tinymce().execCommand('mceInsertContent', false, new_html + "<p></p>");
        } catch (err) {
          if (console && console.log) { console.log(err); }
          alert('Unable to process video url');
        }
      }
      return false;
    },
    
    identify: function (url) {
      if (url.match(/vimeo.com/)) {
        return SHEBA.Video.Vimeo(url);
      } else if (url.match(/youtube.com/) || url.match(/youtube.co.uk/)) {
        return SHEBA.Video.Youtube(url);
      }
      alert("Unsupported video");
      return '';
    },
    
    Vimeo: function (url) {
      var first_match = url.match(/vimeo.com\/(\d+)(\?|$)/);
      var video_id = first_match[1];
      
      var swf = "http://vimeo.com/moogaloop.swf?clip_id=" + video_id + "&server=vimeo.com&show_title=1&show_byline=1&show_portrait=1&color=00ADEF&fullscreen=1";
      var html = '<object width="420" height="240">';
      html = html + '<param name="allowfullscreen" value="true"/>';
      html = html + '<param name="allowscriptaccess" value="always"/>';
      html = html + '<param name="movie" value="' + swf + '"/>';
      html = html + '<embed src="' + swf + '" type="application/x-shockwave-flash" allowscriptaccess="true"  width="420" height="240" />';
      html = html + '</object>';
      return html;
    },
    
    Youtube: function (url) {
      var matches = url.match(/v=(.*?)(\&|$)/);
      
      if (matches == null || matches[1] == undefined) {
        matches = url.match(/\/([A-Za-z0-9_]+)$/);
      }
      if (matches == null || matches[1] == undefined) {
        throw "Bad Youtube URL";
      }
      var video_id = matches[1];
      var html = '<object width="420" height="240"><param name="movie" value="http://www.youtube.com/v/' + video_id + '&hl=en&fs=1&"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/' + video_id + '&hl=en&fs=1&" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="420" height="240"></embed></object>';
      return html;
    }
  }
}
