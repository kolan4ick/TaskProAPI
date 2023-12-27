class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "Client subscribed"

    # Store all GraphQL subscriptions the consumer is listening for on this channel
    @subscription_ids = []
  end

  def execute(data)
    begin
      query = data["query"]
      variables = ensure_hash(data["variables"])
      operation_name = data["operationName"]
      context = {
        channel: self
      }

      # Execute the GraphQL query
      result = TaskProApiSchema.execute(
        query: query,
        context: context,
        variables: variables,
        operation_name: operation_name
      )

      payload = {
        result: result.subscription? ? { data: nil } : result.to_h,
      }

      # Track the subscription here so we can remove it
      # on unsubscribe.
      @subscription_ids << context[:subscription_id] if result.context[:subscription_id]

      transmit(payload)

    rescue Exception => e
      Rails.logger.error "Error executing GraphQL subscription: #{e.message}"
    end
  end

  def unsubscribed
    Rails.logger.info "Client unsubscribed"

    # Delete all of the consumer's subscriptions from the GraphQL Schema
    @subscription_ids.each do | sid |
      TaskProApiSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end