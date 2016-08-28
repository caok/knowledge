class ContentPostGateway
  def initialize()
  end

  def content_post_list(*args)
    puts "hello"
  end

  def find_content_post_by_id(*args)
  end

  def self.content_post_gateway
    #scope[:content_post_gateway] ||= CachedContentPostGateway.new(Post.new(xxxx))

    #SafeContentPostGateway.new(xxx, on_error: ->(error, method, args){...})
  end
end
