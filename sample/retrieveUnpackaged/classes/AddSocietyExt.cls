public with sharing class AddSocietyExt {
	Public ApexPages.StandardController con;
    public Boolean showBlock{get;set;}
    Public Integer currentYear;
    Public String societyID;
    Public List<Contact> membersList;
    public Boolean noMembers{get;set;}
    Public Id SecretaryID {get; set;}
    Public List<Contact>  SelectedMemberList = new List<Contact>();
    Public Account acc;
    
    
    public AddSocietyExt(){}
    
    public AddSocietyExt(ApexPages.StandardController controller) {
    	con = controller;
      
       if(ApexPages.currentPage().getParameters().get('id') != null){
           showBlock = false;
           societyID = ApexPages.currentPage().getParameters().get('id');
           getMembersList();
           getSelectedMemberOption();
       }
        else {
            showBlock = true;
        }
        
        currentYear= System.Today().year();
    }
    
    /* getting members list */
    public List<SelectOption> getSelectedMemberOption()
    {
         List<SelectOption> SelectedMemberOption = new List<SelectOption>();
        if(societyID != null){
            SelectedMemberList = [SELECT Name, AccountId ,Account.id FROM Contact where Account.id = :societyID];
        
            for(Contact Con: SelectedMemberList) {
                    SelectedMemberOption.add(new selectOption(Con.id, Con.Name));
            }
        }
        return SelectedMemberOption;
        
    }
    
    /* adding Secretary to a selected society */
    public void addSecretary()
    {
         acc = new Account(id=societyID,Secretary__c=SecretaryID);
        update acc;
    }
   
     /* Saving society  */
    public PageReference saveSociety()
    {
        
        System.debug('____________societyID__________'+con.getID());
        con.save();
        showBlock = false;
        societyID = con.getID();
        System.debug('____________societyID__________'+societyID);
        PageReference redirectPage = Page.Add_New_Society;
    	redirectPage.setRedirect(true);
    	redirectPage.getParameters().put('id',societyID);
    	return redirectPage;
       
    }
    
    public PageReference AddMembers()
    {
       
        PageReference redirectPage = Page.AddMemberPopup;
    	redirectPage.setRedirect(true);
    	redirectPage.getParameters().put('id',societyID);
    	return redirectPage;
       
    }
    
    public List<SelectOption> getformationYearOptions() {
        List<SelectOption> formationYearOptions = new List<SelectOption>();
        formationYearOptions.add(new SelectOption('',''));
        
        for (Integer i = 1960; i <= currentYear; i++)
        {
    		formationYearOptions.add(new SelectOption(''+i,''+i));
		}


        return formationYearOptions;
    }
    
   public List<Contact> getMembersList() {
       
        	membersList = new List<Contact>();
       
      		 membersList = [
                    			 SELECT Name 
                                 FROM Contact 
                                 where Account.id = :societyID
        					]; 
               if(membersList.size() > 0)
               {
                   noMembers = true;
               }
           		else
                {
                    noMembers = false;
                }
           
       return membersList;
     
   }
   
}