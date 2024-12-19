# README

This is the code for the YouCook project.

## Getting Started

### Prerequisites

- Ruby 3.3.4
- PostgreSQL 17
- Bundler 2.4.x

### Installation

To use it locally, you can use the devcontainer provided in the `.devcontainer` folder.

### Production Url
https://youcook-production.up.railway.app/

## Decisions

### Architecture

#### Command Query
The aplication keeps the rails convention but adds the Command Query layers.

The reason for this is because allthough for simple cases, like this, calling the logic from the controller is enough I prefer to keep the separation of concerns.

#### Testing
For testing normally I prefer a unit test approach were the UNIT is a behavior instead a class alone.

This is because when taking behavior as the unit of testing you decople tests from code structure allowing for easier refactoring and maintenance.

For this application I have mixed a bit because I testing the behavior starting from the controller. I have done it this way because the amount of tests is small and the size of the application allowed it.

#### Frontend

For the frontend I decided to go with Hotwire (Turbo and Stimulus.js) instead of React.

This decision was made because I wanted to learn about it and it was going to make my life easier when deploying the application.

I tried to make make it not very ugly with my lack of design skills.

**SORRY if a designer sees this. :(**

### Other

#### Searching Recipes
For searching the recipe I started with a simple keyword search. It was a good starting point but it was messy and it didn't take into account plurals and combinations.

For improving it I made some research and though about using ElasticSearch but endep up using Postgres full text search (I learn about it during this project).

I think it ended up being a better solution that has less friction for the user.

## AI
For the project I have used some AI.

* Supermaven: As a copilot
* V0: Design and frontend help
* ChatGPT: for general questions and discussions about different approaches.



## User Stories

### USER STORY 1
#### Title: Search recipes
#### Story
    As a user, 
    I want to be able to search for recipes by keywords, 
    so that I can find what I can cooke with my ingredients.
#### Acceptance Criteria
    Scenario A:
    Given that a user inputs some keywords, 
    when the search button is pressed,
    then the user should see a list of recipes that contian the keywords he/she entered.

    Scenario B:
    Given that a user inputs no keywords,
    when the search button is pressed,
    then the user should see a list of all recipes.

#### Notes
Priority: High

Story Points: 5.

### USER STORY 2
#### Title: Add recipes
#### Story
    As a user, 
    I want to be able to create a new recipe,
    so that I can share my cooking experience with others.
#### Acceptance Criteria
    Scenario A:
    Given that a user fills the form, 
    when the create recipe button is pressed and the form is valid,
    then the user see the recipe created.
    
    Scenario B:
    Given that a user fills the form, 
    when the create recipe button is pressed and the form is invalid,
    then the user sees the errors.

#### Notes
Priority: High

Story Points: 3.

### USER STORY 3 (Not Implemented)
#### Title: Search recipes
#### Story
    As a user, 
    I want to be able to upload and image of my freezer,
    so that I can search for recipes with the image.
#### Acceptance Criteria
    Scenario A:
    Given that a user uploads an image,
    when the image is uploades,
    then we process the image and obtain the ingredients
    then the user sees the list of ingredients and the recipes that match the ingredients.

#### Notes
Priority: High

Story Points: 3.
