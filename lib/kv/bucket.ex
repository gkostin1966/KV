defmodule KV.Bucket do
  use Agent
#  use GenServer

  @moduledoc """
  Documentation for KV.Bucket.

  ## Examples

    iex> {:ok, bucket} = KV.Bucket.start_link([])
    iex> KV.Bucket.put(bucket, "key", "value")
    :ok
    iex> KV.Bucket.get(bucket, "key")
    "value"
    iex> KV.Bucket.delete(bucket, "key")
    "value"
    iex> KV.Bucket.get(bucket, "key")
    nil

  """

  @doc """
    Starts a new bucket.

    ## Examples

      {:ok, bucket} = KV.Bucket.start_link([])

  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the `bucket` by `key`.

  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
    Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    # Agent.update(bucket, &Map.put(&1, key, value))
    # Here is the client code
     Agent.update(bucket, fn state ->
    # Here is the server code
     Map.put(state, key, value)
     end)
    # Back to the client code
#    GenServer.call(bucket, {:put, key, value})
  end

#  # Server callback
#  def handle_call({:put, key, value}, _from, state) do
#    {:noreply, Map.put(state, key, value)}
#  end

  @doc """
    Deletes `key` from `bucket`.

    Returns the current value of `key`, if `key` exists.
  """

  def delete(bucket, key) do
    # Agent.get_and_update(bucket, &Map.pop(&1, key))
    # puts client to sleep
    Process.sleep(1000)

    Agent.get_and_update(bucket, fn dict ->
      # puts server to sleep
      Process.sleep(1000)
      Map.pop(dict, key)
    end)
  end
end
