# Scenario
**This isn't real**

This document describes a simple messaging system in a design state.

The Ops Engineer was fired from the company, and we really need to get this product into production. So your task will be to improve and finish the design and get it into prod.

We found these scrawlings from the previous guy along with his console password under his keyboard.

VPC A contains the application servers.

Web servers serve HTTP traffic using two components, NGINX as a SSL termination point that proxies the connection to UWSGI serving a Python Django application running on port 8000.

Queue management is running RabbitMQ, the code running on the web servers can publish tasks to the RabbitMQ server. The workers are running the same code as the web servers however are in a task consumption mode. They monitor the queue and take a task if there is one available, it reports back a completion if the task was executed properly.

The database is a standard PostgreSQL instance.

The integration instance is for supporting customer integrations, each customer has one. This server can
run various software in order to support healthcare protocols and transpose them into something our core
web servers can understand.

Customers connect over the Internet for their app and webapp connectivity however some integrations are
not secure so we need to provide a VPN in order to connect to them.
