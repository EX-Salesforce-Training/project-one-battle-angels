public class CaseList {
   private ApexPages.StandardSetController ssc;

    public CaseList(){
        List<Case> caseList = [SELECT Status FROM Case];

        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(caseList);
    }

    public List<Case> getCases() 
    {
        return (List<Case>)ssc.getRecords();
    }

}