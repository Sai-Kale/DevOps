# 1.0 API :

- API means Application Programming Interface
   - Application : Software on which task runs.
   - Programming : Program(P) that does a task within an Application(A)
   - Interface : Place (I) tell the program to run
- In whole an API exsists where you can tell (I) a computer program (P) to run in an Application(A). Ex: calculator, google translate etc.,..
- However in the IT context API is something you interact with in order to serve the customer. Ex: waiter in a bar
- For example to check for the usage of an API just search for that service and API. Ex: ebay api and know how to use the same.
- We might use an authentication token provided by the API providers for security purposes.

## 1.1 Advantages of API:

- Just use the program dont write it!
- Platform Independent. (Software can be downloaded on any platform and ask the relavant program to run)
- Upgrade Safe.

## 1.2 API Details:

- In general 3 things happen in an API.
- 1) You send the request to the API URL in the form of some request.
  2) The API recieves the request and process it.
  3) API sends the response back in the form of some HTML  or JSON format etc.,..
- Ex: when you search a term 'flower' in google browser , the request is sent to the google API www.google.com/search/ . Here /search is the folder path where the request needs to be looked at.
  and the search parameter flower is given next in the from of '?q=flower' . Here, ? means aksing and q for query about 'flower'. In all we need to send the request in the URL format as
  www.google.com/search/?q=flower.
- Similarly we can consider a ebay API to do search order as well. www.apix.sandbox.ebay.com/buy/order?q=12345
  Here , www.apix.sanbox.ebau.com (the interface computer to interact with)
  /buy/order is the path we need to search our order in 
  ?q=12345 search for our order id.

## 1.3 API Mashup:
 - API to use a bunch of other API's
 - Ex: ixigo air flight booking app. when we enter the flight details the ixigo app API uses those details and requests all the APIs of indigo, go, Air India and fetches the flight details.
   once the flight details are fetched its presents the information in the app in a neat human readable format.
 - In future its going to be API's calling multiple API's to fetch the information. this is how all the third party software like paytm, google pay works.

## 1.4 API (web service definition):
- Web = Internet, Service = API.
- Web service = API that uses internet. So, all the web service is an API. The current API s are mostly in this format.
- **There is an exception, all the API's may not be web services. Not all APIs use the internet.**
- Web service use:
    - XML or JSON format data over the internet (We have to use data in a certain format to send it over the internet.)
    - REST, SOAP ,  or XML/RPC to transfer the data. (The protocol which we use to send that data)
- To understand better its we have ( UI -> App server -> DB)
  UI is written Javascript, HTML and CSS to render a web page upon sending the request.
  Whereas , Web Service API's respond with the data in raw format and they directly reach the server.
- JSON and XML are the most common formats. All the modern programming languages parse the JSON and XML format making them friendly choice for developers.
  Most modern APIs favor JSON over XML.
- To build an API we have write some function on the web server where it recieves the http request, parse it and responds back with some data fetched from DB in JSON or XML format.
- 3rd party tools makes this API call's and get the data and present to the user in a human readable format ex: flight booking.
- [What_is_an_API](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f "What_an_API")
- [API_medium_article](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f "What_is_API")
- AWS provides us with the tools like AWS API Gateway which is written in NodeJS so that we dont have to the write the programming logic and select the kind of requests to be served from exsisting options.

