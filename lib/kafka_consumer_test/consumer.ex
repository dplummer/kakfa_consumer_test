defmodule KafkaConsumerTest.Consumer do
  require Logger

  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, :ok)

  def init(:ok) do
    send self, :begin_streaming
    {:ok, []}
  end

  def handle_info(:begin_streaming, state) do
    Task.async fn ->
      topic = "test"
      offset = latest_offset(topic)
      Logger.info "Beginning stream of #{topic}..."
      KafkaEx.stream(topic, 0, offset: offset)
      |> Stream.each(&process_message/1)
      |> Stream.run
    end
    {:noreply, state}
  end

  def process_message(%{offset: offset}) do
    Logger.info "Offset: #{offset}"
  end

  defp latest_offset(topic) do
    case KafkaEx.latest_offset(topic, 0) do
      [%{partition_offsets: [%{offset: [offset]}]}] ->
        offset
      error ->
        Logger.warn "Error retrieving offset for '#{topic}': #{inspect error}"
        0
    end
  end
end
