// fx_order_node.js

// This script should order an fx future.

// Demo:
// node fx_order_node.js $buysell $size $symbol $currency $port $ibid
// node fx_order_node.js BUY      100000 EUR    GBP       7426  11

var myhost   = '127.0.0.1';

var buysell  = process.argv[2];
var mysize   = process.argv[3];
var symbol   = process.argv[4];
var currency = process.argv[5];
var myport   = parseInt(process.argv[6]);
var clientId = parseInt(process.argv[7]);

var addon    = require('ibapi'),
  messageIds = addon.messageIds,
  contract   = addon.contract,
  order      = addon.order;

var mysym = contract.createContract();
mysym.symbol          = symbol;
mysym.secType         = 'CASH';
mysym.exchange        = 'IDEALPRO';
mysym.primaryExchange = 'IDEALPRO';
mysym.currency        = currency;

var myorder = order.createOrder();
myorder.action        = buysell;
myorder.totalQuantity = mysize;
myorder.orderType     = 'MKT';
myorder.price         = 0.0;
myorder.auxPrice      = 0.0;
myorder.account       = "DU93930";

var api     = new addon.NodeIbapi();
var orderId = -1;

// state variable to determine if program is safe to quit
var safeToQuit = false;

var handleValidOrderId = function (message) {
  orderId = message.orderId;
  console.log('next order Id is ' + orderId);
  console.log('I will order now.');
  api.placeOrder(orderId, mysym, myorder);
  safeToQuit = true;};
api.handlers[messageIds.nextValidId] = handleValidOrderId;

var handleServerError = function (message) {
  console.log('Error: ' + message.id.toString() + '-' +
              message.errorCode.toString() + '-' +
              message.errorString.toString());};
api.handlers[messageIds.svrError] = handleServerError;

var handleClientError = function (message) {
  console.log('clientError');
  console.log(JSON.stringify(message));};
api.handlers[messageIds.clientError] = handleClientError;

// This handler looks at when the order status callback has been returned.
// It will tell you that order has been submitted.
var handleOrderStatus = function (message) {
  console.log('OrderStatus: ');
  console.log(JSON.stringify(message));
  if (message.status == "PreSubmitted") {
    // add other qualifier to ensure all orders were accepted by API server
    //   see OrderStatus callback in IB API documentation for details on 
    //   various flags    
    // Following call exits the program.
    if (safeToQuit)
      process.exit(0);  }};
api.handlers[messageIds.orderStatus] = handleOrderStatus;

var connected = api.connect(myhost, myport, clientId);

if (connected) {
  api.beginProcessing();
}
