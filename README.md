# KafkaConsumerTest

Testing an apparent memory leak in streaming kafka messages with KafkaEx

## Usage

Have kafka running locally.

Get the repo and deps:

```
git clone https://github.com/dplummer/kakfa_consumer_test.git
cd kafka_consumer_test
mix deps.get
```

Compile and run the consumer and start the observer (in prod env if that matters):

```
MIX_ENV=prod mix compile
MIX_ENV=prod iex -S mix
iex> :observer.start
```

Run the producer from a different terminal:

```
mix producer
```
