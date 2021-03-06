//Generated by wsdl2apex

public class WS_Navision_Binding {
    public class BasicHttpBinding_ITwoWayAsync {
        //public String endpoint_x = 'http://nlzpms28mw.primagaz.nl/WCFLookupServices/SalesForce.svc';
        public String endpoint_x = 'https://biztalk-dev-primagaz-nl.shv.net/WCFLookupServices/SalesForce.svc';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.primagaz.nl/mashups/amountsdue', 'WS_Navision_AmountsDue', 'http://www.primagaz.nl/mashups/pricesanddiscounts', 'WS_Navision_Prices', 'http://www.primagaz.nl/lookups', 'WS_Navision_Binding'};
        public WS_Navision_Prices.ResponseOUT_element getPricesAndDiscounts(String CustomerCode,String LanguageCode) {
            WS_Navision_Prices.RequestIN_element request_x = new WS_Navision_Prices.RequestIN_element();
            WS_Navision_Prices.ResponseOUT_element response_x;
            request_x.CustomerCode = CustomerCode;
            request_x.LanguageCode = LanguageCode;
            Map<String, WS_Navision_Prices.ResponseOUT_element> response_map_x = new Map<String, WS_Navision_Prices.ResponseOUT_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'getPricesAndDiscounts',
              'http://www.primagaz.nl/mashups/pricesanddiscounts',
              'RequestIN',
              'http://www.primagaz.nl/mashups/pricesanddiscounts',
              'ResponseOUT',
              'WS_Navision_Prices.ResponseOUT_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
        public WS_Navision_AmountsDue.ResponseOUT_element getAmountsDue(String CustomerCode) {
            WS_Navision_AmountsDue.RequestIN_element request_x = new WS_Navision_AmountsDue.RequestIN_element();
            WS_Navision_AmountsDue.ResponseOUT_element response_x;
            request_x.CustomerCode = CustomerCode;
            Map<String, WS_Navision_AmountsDue.ResponseOUT_element> response_map_x = new Map<String, WS_Navision_AmountsDue.ResponseOUT_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'getAmountsDue',
              'http://www.primagaz.nl/mashups/amountsdue',
              'RequestIN',
              'http://www.primagaz.nl/mashups/amountsdue',
              'ResponseOUT',
              'WS_Navision_AmountsDue.ResponseOUT_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
    }
}