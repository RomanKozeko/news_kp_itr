module ApplicationHelper

  def submit_name(post)
    if post.new_record?
      ".create"
    else
      ".edit"
    end
  end

  def bootstrap_class_for(name)
    { success:"alert-success",
      error:  "alert-danger",
      danger: "alert-danger",
      alert:  "alert-warning",
      notice: "alert-info"
    }[name.to_sym] || name
  end
end
