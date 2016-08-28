class Post
  def initialize()
  end

  def content_post_list
    puts "hello"
  end

  def find_content_post_by_id
  end

  def self.content_post_gateway
    #scope[:content_post_gateway] ||= CachedContentPostGateway.new(Post.new(xxxx))

    #SafeContentPostGateway.new(xxx, on_error: ->(error, method, args){...})
  end
end
