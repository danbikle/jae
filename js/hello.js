// This file shows you one example of a barebones program that handles
//  server error messages.

// Required package name is 'ibapi' If you use your own project path,
//  just use require('ibapi') from your project root as you would 
//  normally do.
var addon = require('ibapi'),
  messageIds = addon.messageIds,
  contract = addon.contract,
  order = addon.order;

// The api object handles the client methods. For details, refer to 
//  IB API documentation.
var api = new addon.NodeIbapi();

// Interactive Broker requires that you use orderId for every new order
//  inputted. The orderId is incremented everytime you submit an order.
//  Make sure you keep track of this.
var orderId = -1;

// Here we specify the event handlers.
//  Please follow this guideline for event handlers:
//  1. Add handlers to listen to messages
//  2. Each handler must have be a function (message) signature
var handleValidOrderId = function (message) {
  orderId = message.orderId;
  console.log('next order Id is ' + orderId);
};

var handleServerError = function (message) {
  console.log('Error: ' + message.id.toString() + '-' +
              message.errorCode.toString() + '-' +
              message.errorString.toString());
};
