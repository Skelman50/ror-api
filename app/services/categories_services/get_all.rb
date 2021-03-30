module CategoriesServices
  class GetAll
    def call
      categories = Category.order(created_at: :desc).all
      CategoryPresenters::Collection.new(categories).call
    end
  end
end