@isTest
public class TestManageDues {
    
 	@isTest
    Static public void TestNoDefaulters()
    {
        ManageDues manageDue= new ManageDues();
        
        List<SelectOption> SocietyOptions= manageDue.getSocietySelOptions();
    	manageDue.societySel = '0016F00001w4V8M';
    	
        List<SelectOption> YearOptions= manageDue.getYearOptions();
    	manageDue.yearSel = YearOptions[0].getValue();
    	
         List<SelectOption> MonthOptions=manageDue.getMonthOptions();
    	manageDue.monthSel = MonthOptions[1].getValue();
        
        manageDue.viewDefaulters();
        
        System.assertEquals(null, manageDue.members,'No Defaulters found');
    }
        
    @isTest(SeeAllData = true)
    Static public void TestViewDefaulters()
    {
        ManageDues manageDue= new ManageDues();
        
        List<SelectOption> SocietyOptions= manageDue.getSocietySelOptions();
    	manageDue.societySel = '0016F00001w4V8M';
    	
        List<SelectOption> YearOptions= manageDue.getYearOptions();
    	manageDue.yearSel = YearOptions[2].getValue();
    	
         List<SelectOption> MonthOptions=manageDue.getMonthOptions();
    	manageDue.monthSel = MonthOptions[1].getValue();
        
        manageDue.viewDefaulters();
        
        System.assertNotEquals(null, manageDue.members,'Defaulters found');
    }
    
    @isTest(SeeAllData = true)
	Static public void TestAddDues()
    {
        ManageDues manageDue= new ManageDues();
        manageDue.addDues();
        //manageDue.dm.duesAmt = 
        manageDue.memberList[0].duesAmt = 1000;
        manageDue.Add();
        
       System.assertEquals(1000,manageDue.memberList[0].duesAmt,'Error: Amount should be equal to 1000');
    } 
    
    
}