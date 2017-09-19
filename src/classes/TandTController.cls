public class TandTController {
        String master{get;set;}
        String itemid;
        testClass.ArrayOfSerialNumberInfo myArray;
        List<testClass.SerialNumberInfo> resultSet;
        testClass.ServiceSoap soap = new testClass.ServiceSoap();

    public PageReference search() {
        myArray = soap.getSerialNumberInfo(master);
        resultSet=myArray.SerialNumberInfo;
        for (testClass.SerialNumberInfo sr:resultSet) {
            System.debug(sr.serialnumber);
        }
        return null;
    }
        
        public String getMaster() {
                return master;
        }
        
        public void setItemid(String itemidIn) {
                 itemid=itemidIn;
        }
        
        public String getItemid() {
                return itemid;
        }
        
        public void setMaster(String masterIn) {
                 master=masterIn;
        }
        
        public void setResultSet(List<testClass.SerialNumberInfo> resultSetIn) {
                 resultSet=resultSetIn;
        }
        
        public List<testClass.SerialNumberInfo> getResultSet() {
                return resultSet;
        }       
        
}