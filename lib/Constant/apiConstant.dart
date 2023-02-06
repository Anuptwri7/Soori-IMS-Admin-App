class ApiConstant {
  //Live Base URL
  
  static const String baseUrl = "https://api.sooritechnology.com.np/api/v1/";

  // Stagging Base URL
  // static const String baseUrl =
  //     "https://api-soori-ims-staging.dipendranath.com.np/api/v1/";

//login
  static const String login = "user-app/login";

//refresh token
  static const String refreshToken = "user-app/login/refresh";

//logout
  static const String logout = "user-app/logout";

//user data
  static const String user = "api/v1/user-app/users/";

//branch
  static const String branch = "branches";
//By Batch
  static const String byBatch = "api/v1/customer-order-app/batch-list?&limit=0&search=";
//customer Order
  static const String customerList = "api/v1/chalan-app/customer-list?limit=0";
  static const String itemList = "api/v1/customer-order-app/item-list?limit=0";
  static const String allCustomer =
      "api/v1/customer-app/customer?limit=0&ordering=-id&search=";
  static const String orderMaster =
      "api/v1/customer-order-app/order-master?&ordering=-id&search=&limit=0";
  static const String orderSummary = "api/v1/customer-order-app/order-summary/";

  static const String cancelOrder = "api/v1/customer-order-app/cancel-order/";
  static const String cancelSingleOrder =
      "api/v1/customer-order-app/cancel-single-order/";
  //save by batch
  static const String saveCustomerOrderByBatch =
      "api/v1/customer-order-app/save-customer-order-by-batch";

  static const String saveCustomerOrder =
      "api/v1/customer-order-app/save-customer-order";
  static const String editCustomerOrder = "api/v1/customer-order-app/update-customer-order/";
  static const String createCustomer = "api/v1/customer-app/customer";

  //Notification
  static const String notificationCount =
      "api/v1/notification-app/user-notification/count";
  static const String notificationReceive =
      "api/v1/notification-app/user-notification/receive";

  static const String allNotification =
      "api/v1/notification-app/user-notification?limit=0&ordering=-created_date_ad";

//Stock Analysis
  static const String stockListLocation =
      "api/v1/warehouse-location-app/location-items?limit=0&ordering=-id&search=";
  static const String stockListBatch =
      "api/v1/stock-analysis-app/stock-by-batch?limit=0&ordering=-id&search=";
  static const String stockList =
      "api/v1/stock-analysis-app/stock-analysis?limit=0&ordering=name&search=";

//Party Payment
  static const String partyPaymentSupplier =
      "api/v1/party-payment-app/supplier-list?limit=0";

  static const String partyPayment =
      "api/v1/party-payment-app/party-payment?limit=0&ordering=-id";

  static const String getPartyInvoice =
      "api/v1/party-payment-app/get-party-invoice?&limit=0&supplier=";

  static const String clearPartyInvoice =
      "party-payment-app/clear-party-invoice";

  static const String partyReport =
      'api/v1/financial-report/supplier-party-payment?limit=0';
  static const String customerOrderReport =
      'api/v1/financial-report/order-master?limit=0';
      
  static const String supplierList = 'api/v1/financial-report/supplier-list';

//Credit Clearance
  static const String allCreditClearance =
      "api/v1/credit-management-app/credit-clearance?limit=0&ordering=-id&search=";
  static const String getCreditInvoice =
      "api/v1/credit-management-app/get-credit-invoice?limit=0&customer=";

  static const String creditCustomer =
      "api/v1/credit-management-app/customer-list?&limit=0";

  static const String paymentMethod = "credit-management-app/payment-mode-list";

  static const String clearCreditInvoice =
      "api/v1/credit-management-app/clear-credit-invoice";

  static const String creditReport = "api/v1/financial-report/customer-credit?limit=0";
  static const String userList = "api/v1/financial-report/user-list";

  static const String postPaymentMode = 'api/v1/core-app/payment-mode';

  //line chart

  static const String lineChart = "dashboard-app/line-chart";

  //forget password
static const String forgetPassword = "api/v1/user-app/password-reset/";
//quotation
static const String quotation= "api/v1/quotation-app/quotation?offset=0&limit=0&ordering=-id";
// view quotation
static const String viewQuotation= "api/v1/quotation-app/quotation-detail?quotation=";
// cancel quotation
static const String cancelQuotation= "api/v1/quotation-app/cancel-quotation-master/";
//Quoatation Order Summary
static const String quotationOrderSummary= "api/v1/quotation-app/quotation-summary/";
// update quotation
static const String updateQuotation = "api/v1/quotation-app/update-quotation/" ;
//save Quotation
static const String saveQuotation = "api/v1/quotation-app/save-quotation" ;
// item quotation
static const String itemQuotation = "api/v1/quotation-app/item-list?search=&offset=0&limit=0";
static const String readAllNotification = "api/v1/notification-app/user-notification/read-all";
// cancel single item Quotation
static const String cancelItemQuotation = "api/v1/quotation-app/cancel-quotation-detail/";

}
