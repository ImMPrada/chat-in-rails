module Destinationable
  def destination_path
    raise NotImplementedError
  end

  def destination_url(workspace)
    Rails.application.routes.url_helpers.public_send(destination_path, workspace, self)
  end
end
