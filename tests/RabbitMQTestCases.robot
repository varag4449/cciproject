*** Settings ***
Documentation    This suite automates RabbitMQ send and receive messages from Exchanges using Robot
Resource    ../resources/RabbitMQKeywords.robot

*** Variables ***
${exchange_name}    atlantis
${queue_name}    atlantis-queue
${message}    Hello World

*** Test Cases ***
Verify Send And Receive Message On RabbitMQ
    RabbitMQKeywords.Create Channel Exchange    ${exchange_name}
    RabbitMQKeywords.Create Channel Queue    ${queue_name}
    RabbitMQKeywords.Bind Exchange To A Queue    ${exchange_name}    ${queue_name}
    RabbitMQKeywords.Send Message to Queue    ${exchange_name}    ${queue_name}    ${message}
    RabbitMQKeywords.Verify Received Message From Queue    ${queue_name}    ${message}
    [Teardown]    RabbitMQKeywords.Close Connection
