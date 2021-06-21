require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @article = @user.articles.build(subject: "hoge", content: "fuga")
  end
  
  test "should be valid" do
    assert @article.valid?
  end

  test "user id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "subject should be present" do
    @article.subject = " "
    assert_not @article.valid?
  end

  test "content should be present" do
    @article.content = " "
    assert_not @article.valid?
  end

  test "order should be most recent first" do
    assert_equal articles(:most_recent), Article.first
  end
end
