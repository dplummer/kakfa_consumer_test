defmodule KafkaConsumerTest.Mixfile do
  use Mix.Project

  def project do
    [app: :kafka_consumer_test,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :kafka_ex, :progress_bar],
     mod: {KafkaConsumerTest, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:kafka_ex, "~> 0.5.0"},
      {:progress_bar, "> 0.0.0"},
    ]
  end
end
