public class ControllerTableSort {

    List<Opportunity> opps;
    public String sortField {get; set;}
    public String previousSortField {get; set;}
    
    public List<Opportunity> getOpps() {
        if(opps == null){
            opps = [select Id, Name, StageName, Probability, CloseDate, Amount, CreatedDate, CreatedById from Opportunity limit 10];
        }
        return opps;
    }
    
    public void doSort(){
        String order = 'asc';
        
        /*This checks to see if the same header was click two times in a row, if so 
        it switches the order.*/
        if(previousSortField == sortField){
            order = 'desc';
            previousSortField = null;
        }else{
            previousSortField = sortField;
        }
       
        //To sort the table we simply need to use this one line, nice!
        superSort.sortList(opps,sortField,order);
    }
}