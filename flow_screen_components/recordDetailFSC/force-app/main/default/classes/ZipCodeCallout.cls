public class ZipCodeCallout {
    
    public static String getZipCodeInfo(String zipCode, String country){
		
        //build params to add to url
        String params = '?codes=' + zipCode.deleteWhitespace();
        if(String.isNotBlank(country)){
            params += '&country=' + country.deleteWhitespace();
        }
        //params = EncodingUtil.urlEncode(params, 'UTF-8');
        
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:ZipCodeBase' + params);
        
        //set apikey in header from named Credential
        request.setHeader('APIKEY', '{!$Credential.Password}');
        
        System.debug(':::: Sending Callout to ZipCodeBase');
        HttpResponse response = new http().send(request);
        
      	System.debug(':::: Received Response');
        System.debug(response);
        
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
        }
        
        return response.getBody();
    }

    public static Set<String> getStatesForZipCode(String zipCode, String country){
        Set<String> liStates = new Set<String>();
        String responseBody = getZipCodeInfo(zipCode, country);
        if(String.isNotBlank(responseBody)){
            JSONParser parser = JSON.createParser(responseBody);
            System.JSONToken token;
            String text;
            while(parser.nextToken() != null){
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'state'){
                    parser.nextToken();
                    liStates.add(parser.getText());
                }
            }
        }
        return liStates;
    }
    
}