*** Settings ***
Documentation     This is a Keywords Resource File
Library           ../libs/RabbitMQLib.py

*** Keywords ***
Create Channel Exchange
    [Arguments]    ${exchange_name}
    RabbitMQLib.Create Exchange    ${exchange_name}

Create Channel Queue
    [Arguments]    ${queue_name}
    RabbitMQLib.Create Queue    ${queue_name}

Bind Exchange To A Queue
    [Arguments]    ${exchange_name}    ${queue_name}
    RabbitMQLib.Bing Exchange To Queue    ${exchange_name}    ${queue_name}

Send Message to Queue
    [Arguments]    ${exchange_name}    ${queue_name}    ${send_message}
    RabbitMQLib.Publish Message    ${exchange_name}    ${queue_name}    ${send_message}

Verify Received Message From Queue
    [Arguments]    ${queue_name}    ${received_message}
    RabbitMQLib.Verify Received Message    ${queue_name}    ${received_message}

Close Connection
    RabbitMQLib.Close Connection



