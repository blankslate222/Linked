package com.cmpe282.lab3.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.cmpe282.lab3.model.CompanyProfile;

public class DynamoService {
	
	private DynamoConnection dynamoConnection;

	public DynamoConnection getDynamoConnection() {
		return dynamoConnection;
	}

	@Autowired
	public void setDynamoConnection(DynamoConnection dynamoConnection) {
		this.dynamoConnection = dynamoConnection;
	}

	public void createCompanyProfile(CompanyProfile companyProfile) {
		dynamoConnection.getDynamoDBMapper().save(companyProfile);
	}
	
	public CompanyProfile getCompanyProfile(String name) {
		CompanyProfile c = dynamoConnection.getDynamoDBMapper().load(CompanyProfile.class, name);
		return c;
	}
	
	public List<CompanyProfile> getCompanyProfiles() {
		ArrayList<String> ids = new ArrayList<String>();
		 
	    ScanResult result = null;
	 
	    do{
	        ScanRequest req = new ScanRequest();
	        req.setTableName("Company");
	 
	        if(result != null){
	            req.setExclusiveStartKey(result.getLastEvaluatedKey());
	        }
	        
	        result = dynamoConnection.getDynamoDB().scan(req);
	 
	        List<Map<String, AttributeValue>> rows = result.getItems();
	 
	        for(Map<String, AttributeValue> map : rows){
	            try{
	                AttributeValue v = map.get("company_id");
	                String id = v.getS();
	                ids.add(id);
	            } catch (NumberFormatException e){
	                System.out.println(e.getMessage());
	            }
	        }
	    } while(result.getLastEvaluatedKey() != null);
	    List<CompanyProfile> lists = new ArrayList<CompanyProfile>();
	    for(int i=0;i<ids.size();i++) {
	    	CompanyProfile companyProfile = dynamoConnection.getDynamoDBMapper().load(CompanyProfile.class, ids.get(i));
	    	
	    	lists.add(companyProfile);
	    }
	    return lists;
	}

}
