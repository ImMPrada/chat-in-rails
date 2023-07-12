module Messages
  class Creator
    attr_reader :errors_messages

    def initialize(params, destination, author)
      @params = params
      @destination = destination
      @author = author
      @errors_messages = []
    end

    def commit
      build_and_validate_message
      message if message.save
    rescue StandardError => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :destination, :author, :message

    def build_and_validate_message
      @message = Message.new(
        content: params[:content],
        classifiable: destination,
        author:
      )
      return if message.valid?

      raise StandardError, message.errors.full_messages.join(', ')
    end
  end
end
