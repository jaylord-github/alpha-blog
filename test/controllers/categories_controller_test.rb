require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @category = categories(:one)
    @category = Category.create(name: "Sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    # session[:user_id] = @user.id # rails 6
    sign_in_as(@user, "password") # rails 5

    get new_category_url
    assert_response :success
  end

  test "should create category" do
    # session[:user_id] = @user.id # rails 6
    sign_in_as(@user, "password") # rails 5

    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    # get(:show, {'id' => @category.id})
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      # post :create, category: { name: "sports" } # rails 6
      post categories_url, params: { category: { name: 'sports' } } # rails 5
    end
    assert_redirected_to categories_path # or pwedi ra pud 'categories_url'
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
