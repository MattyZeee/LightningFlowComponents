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
        //create new sObject based on objectApiName
        Schema.SObjectType sObjType = Schema.getGlobalDescribe().get(objectApiName);
        SObject sObj = sObjType.newSObject();
        //deserialize jsonFields into map: fieldName --> fieldValue
        Map<String, Object> fieldMap = (Map<String, Object>)JSON.deserializeUntyped(jsonFields);
        //set sObject field / values
        for(String fieldName : fieldMap.keyset()){
            sObj.put(fieldName, fieldMap.get(fieldName));
        }

        //instatiate apex class based from className
        Type t = Type.forName(apexClassToCall);   
        //Create newInstance of given class
        RecordDetailFSCFormInterface formI = (RecordDetailFSCFormInterface)t.newInstance();
        //call doBeforeSave() 
        formI.doBeforeSave(sObj);
    }
}
