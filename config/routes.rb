Rails.application.routes.draw do
  devise_for :users

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"

  post "/graphql", to: "graphql#execute"
end
