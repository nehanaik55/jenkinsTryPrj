@isTest
public class TestAddSociety {
    
    @isTest
    Static public void TestAddSecretary()
    {
        
        AddSocietyExt addSociety= new AddSocietyExt();
        addSociety.societyID = '0016F00001w4V8M';
        addSociety.SecretaryID ='0036F000025EsrS';
        
        addSociety.addSecretary();
        System.assertEquals(addSociety.secretaryId, addSociety.acc.Secretary__c,'Secretary ID is not matching');
    }
    
    
    @isTest(SeeAllData = true)
    static void TestGetSelectedMembersList() {
        
        AddSocietyExt addSociety= new AddSocietyExt();
        addSociety.societyID = '0016F00001w4VTR';
        
        List <Contact> lstContact = new List<Contact>();
      	lstContact= addSociety.getMembersList();
        addSociety.getSelectedMemberOption();
        
        
       System.assertNotEquals(0, lstContact.size(),'list is empty');
        
    }

    @isTest
    static void TestAddSocietyExt()
    {
        Account obj = new Account(Name ='Test', Reg_Code__c='test1');
        ApexPages.StandardController con = new ApexPages.StandardController(obj);
        
        AddSocietyExt addSociety= new AddSocietyExt(con);
    }
    
    @isTest
    static void TestSaveSociety()
    {
        Account obj = new Account(Name ='Test', Reg_Code__c='test1');
        ApexPages.StandardController con = new ApexPages.StandardController(obj);
        
        AddSocietyExt addSociety= new AddSocietyExt();
        
        addSociety.con = con;
        
        addSociety.currentYear= System.Today().year();
        addSociety.getformationYearOptions();
        
        PageReference save = addSociety.saveSociety();
        
    }
    
     @isTest
    static void TestAddMembers()
    {
        
        AddSocietyExt addSociety= new AddSocietyExt();        
        addSociety.societyID = '0016F00001w4V8M';
        addSociety.AddMembers();
        
    }
}