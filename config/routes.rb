Rails.application.routes.draw do

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"

  post "/graphql", to: "graphql#execute"
end
