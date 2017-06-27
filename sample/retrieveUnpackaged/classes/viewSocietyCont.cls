public with sharing class viewSocietyCont {
    
    Public List<Account> societyList;
    
    public viewSocietyCont(){}
    
     public List<Account> getSocietyList() {
        societyList = new List<Account>();
         
         for(Account da : (List<Account>) setCon.getRecords())
             societyList.add(da);
        system.debug('societyList====================== '+societyList);
         
         return societyList;
     }
    
    //////////////////////
      Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 2;
               
                string queryString = 'SELECT Reg_Code__c, Name, Secretary__r.name,no_of_members__c, BillingStreet FROM Account where Reg_Code__c != null';
                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
                
                system.debug('----------------setCon ----------------'+ (List<Account>)setCon.getRecords());
            }
            return setCon;
        }set;
    }
     
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
  
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
  
    public void first() {
        setCon.first();
    }
  
    public void last() {
        setCon.last();
    }
  
    public void previous() {
        setCon.previous();
    }
  
    public void next() {
        setCon.next();
    }


}