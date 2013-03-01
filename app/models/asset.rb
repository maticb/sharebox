class Asset < ActiveRecord::Base
  attr_accessible :user_id, :uploaded_file  , :folder_id



  belongs_to :user

  #set up "uploaded_file" field as attached_file (using Paperclip)
  has_attached_file :uploaded_file,
                    :url => "/assets/get/:id",
                    :path => "/assets/:id/:basename.:extension"

  validates_attachment_size :uploaded_file, :less_than => 10.megabytes
  validates_attachment_presence :uploaded_file
  def file_size
    uploaded_file_file_size
  end

  belongs_to :folder


  def get
    #first find the asset within own assets
    asset = current_user.assets.find_by_id(params[:id])

    #if not found in own assets, check if the current_user has share access to the parent folder of the File
    asset ||= Asset.find(params[:id]) if current_user.has_share_access?(Asset.find_by_id(params[:id]).folder)

    if asset
      #Parse the URL for special characters first before downloading
      data = open(URI.parse(URI.encode(asset.uploaded_file.url)))
      send_data data, :filename => asset.uploaded_file_file_name
      #redirect_to asset.uploaded_file.url
    else
      flash[:error] = "Don't be cheeky! Mind your own assets!"
      redirect_to root_url
    end
  end

end
