require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  
  test "the truth" do
     test_chop
  end
  
  def test_chop
    assert_equal(-1, Tweet.basic_chop(3, []))
    assert_equal(-1, Tweet.basic_chop(3, [1]))
    assert_equal(0,  Tweet.basic_chop(1, [1]))
    #
    assert_equal(0,  Tweet.basic_chop(1, [1, 3, 5]))
    assert_equal(1,  Tweet.basic_chop(3, [1, 3, 5]))
    assert_equal(2,  Tweet.basic_chop(5, [1, 3, 5]))
    assert_equal(-1, Tweet.basic_chop(0, [1, 3, 5]))
    assert_equal(-1, Tweet.basic_chop(2, [1, 3, 5]))
    assert_equal(-1, Tweet.basic_chop(4, [1, 3, 5]))
    assert_equal(-1, Tweet.basic_chop(6, [1, 3, 5]))
    #
    assert_equal(0,  Tweet.basic_chop(1, [1, 3, 5, 7]))
    assert_equal(1,  Tweet.basic_chop(3, [1, 3, 5, 7]))
    assert_equal(2,  Tweet.basic_chop(5, [1, 3, 5, 7]))
    assert_equal(3,  Tweet.basic_chop(7, [1, 3, 5, 7]))
    assert_equal(-1, Tweet.basic_chop(0, [1, 3, 5, 7]))
    assert_equal(-1, Tweet.basic_chop(2, [1, 3, 5, 7]))
    assert_equal(-1, Tweet.basic_chop(4, [1, 3, 5, 7]))
    assert_equal(-1, Tweet.basic_chop(6, [1, 3, 5, 7]))
    assert_equal(-1, Tweet.basic_chop(8, [1, 3, 5, 7]))
  end

end
