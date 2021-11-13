module PostImagesHelper

  def render_with_hashtags(hashbody)
    hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post_image/hashtag/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end


end
