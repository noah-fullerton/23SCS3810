## Part A

A recipe can have one or more “tags” that can be used to identify “meal types” such as breakfast, brunch, lunch, tea, supper, dinner, or snack.  Users can “tag” their recipes anyway they want.  A recipe lists all of its ingredients, each identified by a three-letter code, also having a longer description.  For example, “salted butter” might be cataloged in the system as “sbt” with a longer description “Salted Butter.” A recipe must define, for each of its ingredients, the quantity used in the recipe and their unit (cup, teaspoon, tablespoon, grams, pinch, etc.). Finally, a recipe defines a list of steps, each step uniquely identified (within a recipe) by a sequential number accompanied by a short description of the step. 

Draw an E/R Diagram (ERD) to model the “recipes” database system, identifying all entity sets, their attributes, key attributes, and relationships.

## Part B

Derive a relational schema from your E/R Diagram (ERD), describing the relations, attributes, key attributes, and domains.

relational schema:

Recipes(id: int [und], name: str)
Tags(meal_type: str [und])
Ingredients(code: str [und], description: str)
Steps(recipe_id: str [und], seq_number: int [und, partialkey], description: str)
Recipes_Ingredients (recipe_id: str [und], ing_code: str [und], quantity: int, unit: str)
Recipes_Tags (recipe_id: int [und], meal_type: str [und])