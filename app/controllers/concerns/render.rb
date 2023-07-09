module Render
  extend ActiveSupport::Concern

  # The code inside the included block is evaluated
  # in the context of the class that includes the Visible concern.
  # You can write class macros here, and
  # any methods become instance methods of the including class.
  included do
    attr_accessor :visible_to

    def add_channels_list_to_stream
      turbo_stream.update(
        :workspace_channel_sidebar,
        partial: 'partials/workspace_channel/channels_list',
        locals: {
          workspace:,
          user: current_user,
          workspace_channels:
        }
      )
    end

    def update_workspaces_list(workspaces)
      turbo_stream.update(
        :my_workspaces_list,
        partial: 'partials/workspaces/list',
        locals: { workspaces: }
      )
    end

    def remove_new_workspace_form
      turbo_stream.update(:new_workspace_form, '')
    end

    def notice_message(message)
      notify_message(
        {
          classes: 'notice',
          message:
        }
      )
    end

    def alert_message(message)
      notify_message(
        {
          classes: 'alert',
          message:
        }
      )
    end

    private

    def notify_message(notification)
      turbo_stream.update(
        :notifications_bar,
        partial: 'partials/bar_notification',
        locals: notification
      )
    end
  end

  # The methods added inside the class_methods block (or, ClassMethods module)
  # become the class methods on the including class.
  class_methods do
    def all_visible
      all.select { |item| item.is_visible? }
    end
  end
end
