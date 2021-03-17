public class RecordDetailFSCHelper {
 
    /**
     * called from RecordDetailFlowScreenComponent LWC when a user clicks the save button on a record-edit-form
     * it will instantiate the given apexClass invoke the doBeforeSave method
     * If an error is thrown, the insert/update operation will not be committed to Salesforce
     * User will see exception message in an Error Toast
     * 
     * @param  apexClassToCall this class must implement RecordDetailFSCFormInterface
     */
    @auraEnabled
    public static void doBeforeSave(string objectApiName, string jsonFields, String apexClassToCall){
        
        System.debug(jsonFields);
        Type t = Type.forName(apexClassToCall);   
        //Create newInstance of given class
        RecordDetailFSCFormInterface formI = (RecordDetailFSCFormInterface)t.newInstance();
        //call doBeforeSave() 
        formI.doBeforeSave(objectApiName, jsonFields);
    }
}
