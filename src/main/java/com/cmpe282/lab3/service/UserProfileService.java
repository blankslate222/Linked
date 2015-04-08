package com.cmpe282.lab3.service;


import org.springframework.beans.factory.annotation.Autowired;

import com.cmpe282.lab3.model.UserProfile;

public class UserProfileService {
	private DynamoConnection dynamoConnection;

	public DynamoConnection getDynamoConnection() {
		return dynamoConnection;
	}

	@Autowired
	public void setDynamoConnection(DynamoConnection dynamoConnection) {
		this.dynamoConnection = dynamoConnection;
	}
	
	public void saveUserProfile(UserProfile userProfile) {
		dynamoConnection.getDynamoDBMapper().save(userProfile);
	}
	
	public UserProfile getUserProfile(String email) {
		UserProfile c = dynamoConnection.getDynamoDBMapper().load(UserProfile.class, email);
		//if(c==null) System.out.println("user profile  null");
		return c;
	}
	
}
