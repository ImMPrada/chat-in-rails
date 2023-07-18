module Destinationable
  def message_box_turbo_tag
    raise NotImplementedError
  end

  def messages_turbo_tag
    raise NotImplementedError
  end

  def destination_path
    raise NotImplementedError
  end

  def destination_url(workspace)
    Rails.application.routes.url_helpers.public_send(destination_path, workspace, self)
  end
end
