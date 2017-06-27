@isTest
public class TestViewSocietyCont {
    
    @isTest
    Static public void TestgetSocietyList() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.getSocietyList();
    }
    
    @isTest(seeAllData=true)
    Static public void TestNext() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        
        viewSociety.setCon.setPageNumber(1);
        viewSociety.next();
        
        System.assertEquals(2,viewSociety.setCon.getPageNumber(),'Invalid next page');
        
    }
    
    @isTest(seeAllData=true)
    Static public void TestPrevious() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.setCon.setPageNumber(2);
        viewSociety.previous();
        
        System.assertEquals(1,viewSociety.setCon.getPageNumber(),'Invalid previous page');
    }
  
    @isTest(seeAllData=true)
    Static public void TestFirst() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.setCon.setPageNumber(2);
        viewSociety.first();
        
        System.assertEquals(1,viewSociety.setCon.getPageNumber(),'Invalid first page');
    }
    
    @isTest(seeAllData=true)
    Static public void TestLast() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.setCon.setPageNumber(1);
        viewSociety.last();
        
        System.assertEquals(16,viewSociety.setCon.getPageNumber(),'Invalid Last page');
    }
    
    @isTest(seeAllData=true)
    Static public void TestHasPrevious() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.setCon.setPageNumber(2);
        
        System.assertEquals(true,viewSociety.hasPrevious,'No Prev page');
    }
    
    @isTest(seeAllData=true)
    Static public void TestHasNext() {
        
        viewSocietyCont viewSociety= new viewSocietyCont();
        viewSociety.setCon.setPageNumber(1);
        
        System.assertEquals(true,viewSociety.hasNext,'No Next page');
    }
}