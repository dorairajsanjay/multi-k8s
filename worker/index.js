console.log("Worker Node starting...\n");

const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000
});
const sub = redisClient.duplicate();

function fib(index) {

  console.log("Worker node in fib function executing for index:" + index);

  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}

sub.on('message', (channel, message) => {
  console.log("Worker node received a message of some sort:" + message);
  redisClient.hset('values', message, fib(parseInt(message)));
});

console.log("Worker node subscribing for inserts on REDIS");
sub.subscribe('insert');
