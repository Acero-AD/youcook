class AddSearchVectorToRecipes < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE recipes ADD COLUMN ingredients_vector tsvector;

      UPDATE recipes
      SET ingredients_vector = to_tsvector('english',
        array_to_string(
          array(
            SELECT unnest(ingredients)::text
          ),
          ' '
        )
      );

      CREATE INDEX recipes_ingredients_vector_idx ON recipes USING gin(ingredients_vector);

      CREATE OR REPLACE FUNCTION recipes_vector_trigger() RETURNS trigger AS $$
      begin
        new.ingredients_vector := to_tsvector('english',#{' '}
          array_to_string(
            array(
              SELECT unnest(new.ingredients)::text
            ),#{' '}
            ' '
          )
        );
        return new;
      end
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON recipes FOR EACH ROW EXECUTE FUNCTION recipes_vector_trigger();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS tsvectorupdate ON recipes;
      DROP FUNCTION IF EXISTS recipes_vector_trigger();
      DROP INDEX IF EXISTS recipes_ingredients_vector_idx;
      ALTER TABLE recipes DROP COLUMN ingredients_vector;
    SQL
  end
end
