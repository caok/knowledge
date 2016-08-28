require "delegate"
require "./post"

class SafeContentPostGateway < DelegateClass(Post)
  def initialize(target, on_error: ->(*){})
    super(target)
    @error_handler = on_error
  end

  def content_post_list(*args)
    super
  rescue StandardError => error
    @error_handler.call(error, :content_post_list, args)
    []
  end

  def find_content_post_by_id(*args)
    super
  rescue StandardError => error
    @error_handler.call(error, :find_content_post_by_id, args)
    {
      content: "<Episode content unavailable>",
      synopis: "<Synopsis unavailable>"
    }
  end
end
