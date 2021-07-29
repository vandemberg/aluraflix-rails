class AddNonCategoryToVideosWithoutCategories < ActiveRecord::Migration[6.1]
  def change
    category = Category.create({ title: "Sem categoria", color: "#b9abbb"})

    Video.where({ category_id: nil }).update_all({
      category_id: category.id,
    })
  end
end
