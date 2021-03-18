public class RecordDetailFSCContactValidation implements RecordDetailFSCFormInterface{
 
    public void doBeforeSave(sObject recordData){

        //ContactWrapper con = (ContactWrapper)JSON.deserialize(jsonFields, ContactWrapper.class);
        
        Contact con = (Contact)recordData;
        String zipCode = con.MailingPostalCode;
        String country = con.MailingCountry;
        String state = con.MailingState;
        System.debug('MailingZipCode: ' + zipCode + 'MailingCountry: ' + country);

        Set<String> setStates = ZipCodeCallout.getStatesForZipCode(zipCode, country);
        if(!setStates.contains(state)){
            String errorMsg = 'The Zip Code entered: ' + zipCode + ', is not in ' + state + '\n'; 
            errorMsg +=  ' Please update the State to one of the following values: ' + setStates;

            throw new MyException(errorMsg);
        }
    }

/*
    public class ContactWrapper{
        String FirstName;
        String LastName;
        String MailingState;
        String MailingPostalCode;
        String MailingCountry;
    }
*/
    public class MyException extends Exception{}

}

