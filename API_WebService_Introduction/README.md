# 1.0 API :

- API means Application Programming Interface
   - Application : Software that does a task.
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
  3) API sends the response back in the form of some HTML code or JSON code etc.,..
- Ex: when you search a term 'flower' in google browser , the request is sent to the google API www.google.com/search/ . Here /search is the folder path where the request needs to be looked at.
  and the search parameter flower is given next in the from of '?q=flower' . Here, ? means aksing and q for query about 'flower'. In all we need to send the request in the URL format as
  www.google.com/search/?q=flower.
- Similarly we can consider a ebay API to do some order as well. www.apix.sandbox.ebay.com/buy/order?q=12345
  Here , www.apix.sanbox.ebau.com (the interface computer to interact with)
  /buy/order is the path we need to search our order in 
  ?q=12345 search for our order id.

