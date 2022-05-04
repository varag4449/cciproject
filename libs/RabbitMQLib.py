import pika
from robot.api.deco import keyword


class RabbitMQLib(object):

    def __init__(self):
        self.connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
        self.channel = self.connection.channel()

    @keyword
    def create_queue(self,queue_name):
        self.channel.queue_declare(queue=queue_name)

    @keyword
    def create_exchange(self,exchange_name):
        self.channel.exchange_declare(exchange=exchange_name)

    @keyword
    def bing_exchange_to_queue(self,exchange_name,queue_name):
        self.channel.queue_bind(queue=queue_name, exchange=exchange_name)

    @keyword
    def publish_message(self,exchange_name,queue_name,send_message):
        self.channel.basic_publish(exchange=exchange_name, routing_key=queue_name, body=send_message)
        print("message published")

    @keyword
    def callback(self,body):
        print("Received %r" % body)
        return {body}

    @keyword
    def verify_received_message(self,queue_name,received_message):
        self.channel.basic_consume(queue=queue_name, on_message_callback=self.callback, auto_ack=True)

    @keyword
    def close_connection(self):
        self.connection.close()
