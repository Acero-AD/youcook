FactoryBot.define do
  factory :recipe do
    title { "title_#{rand(100)}" }
    cook_time { 1 }
    prep_time { 1 }
    ingredients { %w[apples oranges pears] }
    ratings { "9.99" }
    cuisine { "cooker" }
    category { "italian" }
    author { "diego" }
    image { "incredible.jpg" }
  end
end
