defmodule Mix.Tasks.Producer do
  use Mix.Task

  @shortdoc "Write 50,000 1kb messages as fast as we can to Kafka"

  def run(_args) do
    KafkaEx.start nil, nil

    # a 1kb binary message, simulating an Avro-encoded message
    message = Stream.repeatedly(fn -> :rand.uniform(255) end)
              |> Stream.take(1024)
              |> Enum.into([])
              |> :erlang.list_to_binary

    ProgressBar.render_spinner [
      text: "Producing to 'test'",
      spinner_color: IO.ANSI.magenta,
      interval: 100,
      frames: :braille
    ], fn ->
      produce("test", message, 50_000)
    end
  end

  def produce(_topic, _message, 0), do: nil

  def produce(topic, message, iterations_left) do
    KafkaEx.produce topic, 0, message
    produce(topic, message, iterations_left - 1)
  end
end
