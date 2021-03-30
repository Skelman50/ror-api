module CategoriesServices
  class DestroyAll
   
    def call
      Category.destroy_all
    end
  end
end