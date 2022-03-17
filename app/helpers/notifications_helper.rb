module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @post_comment = nil
    @visitor_comment = notification.post_comment_id
    
    case notification.action
    # when 'follow'
      
    #   # tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    # when 'like'
    #   tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: post_image_path(notification.post_image_id)) + 'にいいねしました'
    when 'comment' then
      @post_comment = PostComment.find_by(id: @visitor_comment)
      @post_comment_content =@post_comment.content
      @post_image_title =@post_comment.post_image.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@post_image_title}", href: post_image_path(notification.post_image_id)) + 'にコメントしました'
    end
  end
end