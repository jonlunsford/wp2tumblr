module Wp2tumblr
  module Wordpress
    def self.parse_xml(file, type)
      case type
      when :posts
        self.parse_posts(file)
      when :categories
        self.parse_categories(file)
      when :tags
        self.parse_tags(file)
      when :all
        self.parse_all(file)
      end
    end 

    def parse_posts(file)
      items = get_file_contents(file)
      @posts = []
      items.to_enum.with_index(0) do |item, i|
        @posts[i] = {title: item.at_xpath("title").text, content: item.at_xpath("content:encoded").text, created_at: item.at_xpath("pubDate").text}
      end
      @posts
    end

    def parse_categories(file)
      items = get_file_contents(file)
      @categories = []
      items.to_enum.with_index(0) do |item, i| 
        @categories = get_post_meta(item, :category)
      end
      @categories
    end

    def parse_tags(file)
      items = get_file_contents(file)
      @tags = []
      items.to_enum.with_index(0) do |item, i| 
        @tags = get_post_meta(item, :tag)
      end
      @tags
    end

    def parse_all(file)
      items = get_file_contents(file)
      @posts = []
      items.to_enum.with_index(0) do |item, i|
        @posts[i] = {
          title: item.at_xpath("title").text, 
          content: item.at_xpath("content:encoded").text, 
          created_at: item.at_xpath("pubDate").text, 
          categories: get_post_meta(item, :category), 
          tags: get_post_meta(item, :tag),
          comments: get_post_meta(item, :comment)
        }
      end
      @posts
    end

    def get_post_meta(post, type)
      @meta = []
        case type
        when :category
          post.css("category").each do |item| 
            if item.attr("domain") === "category"
              @meta.push(item.text) unless @meta.include?(item.text)
            end
          end
        when :tag
          post.css("category").each do |item|
            if item.attr("domain") === "post_tag"
              @meta.push(item.text) unless @meta.include?(item.text)
            end 
          end
        when :comment 
          post.xpath("wp:comment").to_enum.with_index(0) do |comment, i|
            @meta.push({
              author: comment.at_xpath("wp:comment_author").text, 
              author_email: comment.at_xpath("wp:comment_author_email").text, 
              content: comment.at_xpath("wp:comment_content").text,
              approved: comment.at_xpath("wp:comment_approved").text === "1" ? true : false
            })
          end
        end
      @meta
    end

    def get_file_contents(file)
      Nokogiri::XML(file).xpath("//channel//item")
    end 

  end
end