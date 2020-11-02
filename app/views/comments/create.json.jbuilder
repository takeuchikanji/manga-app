json.text  @comment.text
json.user_id  @comment.user.id
json.user_name  @comment.user.name
json.created_at  @comment.created_at.strftime("%y.%m.%d %H:%M")
json.comic_id  @comment.comic.id
json.comment_id  @comment.id