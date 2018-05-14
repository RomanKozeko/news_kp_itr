module PostsHelper
  def submit_name(post)
    if post.new_record?
      ".create"
    else
      ".edit"
    end
  end
end
