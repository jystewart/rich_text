class RichText::ImagesController < ApplicationController
  layout false
  
  def new
    @image = EditorImage.new
    render :template => '/images/new'
  end
  
  def create
    @image = current_user.editor_images.build(params[:image])

    respond_to do |format|
      if @image.save
        format.html { 
          flash[:notice] = 'Image was successfully stored'
          redirect_to :back
        }
        format.js {
          # Support iframe remoting trick. Could use http://code.google.com/p/responds-to-parent/ 
          # but it seemed overkill
          response.headers["Content-Type"] = 'text/html'
          render :template => 'images/create', :format => 'js'
        }   
      else
        format.html { render :template => "images/new" }
      end
    end
  end
end