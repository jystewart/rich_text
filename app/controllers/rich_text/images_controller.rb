class RichText::ImagesController < ApplicationController
  layout false
  
  def new
    @image = EditorImage.new
    render :template => '/images/new'
  end
  
  def show
    @image = current_user.editor_images.find(params[:id])
    render :template => 'images/show'
  end

  def create
    @image = current_user.editor_images.build(params[:editor_image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to editor_image_path(@image), :notice => 'Image was successfully stored' }
        format.js {
          # Support iframe remoting trick. Could use http://code.google.com/p/responds-to-parent/ 
          # but it seemed overkill
          response.headers["Content-Type"] = 'text/html'
          render :template => 'images/create', :format => 'js'
        }   
      else
        format.html { render :template => "images/new" }
        format.js { render :json => @image.errors }
      end
    end
  end
end