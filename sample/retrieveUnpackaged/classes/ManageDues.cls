public with sharing class ManageDues {
    
    Public Integer currentYear;
    Public Id societySel {get; set;} 
    Public String yearSel {get; set;} 
    Public String monthSel {get; set;} 
    
    Public List<Account> societyList;
    
    public Boolean DefaultersBlock{get;set;}
    public Boolean DuesBlock{get;set;}
    
    public List<defaulterMembers> members;
    public Boolean noDues{get;set;}
    
    public List<defaulterMembers> memberList;
    
   // public String secretaryProfileID='00e6F000002b4TRQAY';
    public String secretaryProfileID{get;set;}
    
    public ManageDues(){
        DefaultersBlock = false;
        
        DuesBlock = false;
        
         memberList = new List<defaulterMembers>();

         System.debug('----------------ManageDues DefaultersBlock---------------'+DefaultersBlock);
    }
    
    public List<SelectOption> getYearOptions() {
        List<SelectOption> YearOptions = new List<SelectOption>();
       // YearOptions.add(new SelectOption('',' '));
         currentYear= System.Today().year();
        for (Integer i = currentYear; i > 1960; i--)
        {
    		YearOptions.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
		}
        return YearOptions;
    }
    
    public List<SelectOption> getSocietySelOptions() {
        List<SelectOption> SocietySelOptions = new List<SelectOption>();
        //SocietySelOptions.add(new SelectOption('',''));
        
        List<profile> profileList = new List<profile>();
        
        societyList = new List<Account>();
        profileList = [SELECT id from profile where name = 'Secretary'];
        System.debug('profileList::: '+profileList.get(0));
        
        secretaryProfileID =string.valueOf(profileList[0].id);
 			System.debug('secretaryProfileID::: '+secretaryProfileID);
        
 			System.debug('UserInfo.getProfileId() ::: '+UserInfo.getProfileId());
        if(UserInfo.getProfileId() == secretaryProfileID)
        {
            system.debug('hiiiiiiiiiiiiiiiii');
            societyList = [
                    			SELECT Name FROM Account where Reg_Code__c != null AND OwnerID=:UserInfo.getUserId()
        			   	  ]; 
        }
         else
         {
             	societyList = [
                    		SELECT  Name
             				FROM Account 
             				where Reg_Code__c != null
        			   ]; 
         }
         for(Account sl : societyList)
             SocietySelOptions.add(new selectOption(sl.id, sl.Name));

        return SocietySelOptions;
    }
    
    public List<SelectOption> getMonthOptions() {
        List<SelectOption> MonthOptions = new List<SelectOption>();
        //MonthOptions.add(new SelectOption('',' '));
        
        MonthOptions.add(new SelectOption('January','January'));
        MonthOptions.add(new SelectOption('February','February'));
        MonthOptions.add(new SelectOption('March','March'));
        MonthOptions.add(new SelectOption('April','April'));
        MonthOptions.add(new SelectOption('May','May'));
        MonthOptions.add(new SelectOption('June','June'));
        MonthOptions.add(new SelectOption('July','July'));
        MonthOptions.add(new SelectOption('August','August'));
        MonthOptions.add(new SelectOption('September','September'));
        MonthOptions.add(new SelectOption('October','October'));
        MonthOptions.add(new SelectOption('November','November'));
        MonthOptions.add(new SelectOption('December','December'));

        return MonthOptions;
    }
   
    
    public List<defaulterMembers> getMemberList() {
		
			memberList.clear(); 
			for(Contact c: [
                                SELECT Name, Email, Account.Secretary__r.name 
                                FROM Contact 
                                where Account.ID =:societySel 
                                AND ID NOT IN 
                                (Select Member__c From Dues__c Where Month__c=:monthSel AND Dues_Year__c=:yearSel)
                           ]) 
            {
				memberList.add(new defaulterMembers(c));
                
			}
        
        System.debug('------with in getMemberList() memberList------------'+memberList);
        if(memberList.size() == 0)
        {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'No Defaulters found'));
            
        	DefaultersBlock = false;
        	DuesBlock = false;
            return null;
        }
        
		return memberList;
	}
    public void viewDefaulters() {
        DefaultersBlock = true;
        DuesBlock = false;
       	members =getMemberList();
        System.debug('------members------------'+members);
    } 
    
    public void addDues() {
        DuesBlock = true;
        DefaultersBlock = false;
        getMemberList();
    }
    
    public void SendReminderEmail() {
        for(defaulterMembers dm: memberList) {
            System.debug('hiiiii '+dm);
            
			if(dm.selected == true && dm.con.email != null) {
				 	System.debug('!!!!!!!!!!!!!!!!!dm.con.id!!!!!!!!!!!!!!!!!!'+dm.con.id);
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            
                    message.toAddresses = new String[] { dm.con.email };
                    message.subject = 'Maintenance Payment Reminder Mail';
                    message.plainTextBody = 'Hi '+dm.con.name +'\n \n Please Pay your maintenance payment for '+monthSel +' '+yearSel+'\n '+'\n Regards '+dm.con.Account.Secretary__r.name;
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                    if (results[0].success) 
                    {
                        system.debug('The email was sent successfully.');
                    } 
                	else {
                        system.debug('The email failed to send: '+ results[0].errors[0].message);
                    }
			}
            else if(dm.con.email == null)
            {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Selected user does not have email address'));
            }
		}
    }
    
    public void Add()
    {
        List<Dues__c> addDues = new List<Dues__c>();
        
        for(defaulterMembers dm: memberList) {
            System.debug('hiiiii '+dm);
			if(dm.duesAmt != 0 ) {
                if(dm.duesAmt == 1000)
                {
                	addDues.add(new Dues__c(Member__c=dm.con.id,Dues_Amount__c=dm.duesAmt, Dues_Year__c=yearSel, Month__c=monthSel));
          		}
                else
                {
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Amount should be equal to 1000'));
                }
            }
        }
      // Database.SaveResult[] srList = Database.insert(addDues, false);
        
        //System.debug('-----------srList------------'+srList);

        insert addDues;
    }
    
    public class defaulterMembers {
		public Contact con {get; set;}
		public Boolean selected {get; set;}
		public Integer duesAmt {get; set;}

		public defaulterMembers(Contact c) {
			con = c;
			selected = false;
            duesAmt = 0;
		}
	}
}