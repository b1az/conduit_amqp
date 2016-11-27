defmodule ConduitAMQP.Subscribers do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    children = [worker(ConduitAMQP.Subscriber, [], restart: :temporary)]

    supervise(children, strategy: :simple_one_for_one, name: __MODULE__)
  end

  def start_subscriber(chan, source, subscriber, payload, props) do
    Supervisor.start_child(__MODULE__, [chan, source, subscriber, payload, props])
  end
end