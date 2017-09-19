public class WT_TandTController {
        
        String master{get;set;}
        String itemid;        
        List<WorktraceTandT.echo> resultSet;
         
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
        

}