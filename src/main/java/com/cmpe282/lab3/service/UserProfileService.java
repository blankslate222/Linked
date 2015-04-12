package com.cmpe282.lab3.service;


import org.springframework.beans.factory.annotation.Autowired;

import com.cmpe282.lab3.model.UserProfile;
import com.google.code.ssm.CacheFactory;
import com.google.code.ssm.api.InvalidateSingleCache;
import com.google.code.ssm.api.ParameterValueKeyProvider;
import com.google.code.ssm.api.ReadThroughSingleCache;
import com.google.code.ssm.api.ReturnDataUpdateContent;
import com.google.code.ssm.api.UpdateSingleCache;

public class UserProfileService {
	private DynamoConnection dynamoConnection;
	@Autowired
	private CacheFactory memcachedClient;
	public DynamoConnection getDynamoConnection() {
		return dynamoConnection;
	}

	@Autowired
	public void setDynamoConnection(DynamoConnection dynamoConnection) {
		this.dynamoConnection = dynamoConnection;
	}
	
	@InvalidateSingleCache
	public void saveUserProfile(UserProfile userProfile) {
		dynamoConnection.getDynamoDBMapper().save(userProfile);;
	}
	
	@UpdateSingleCache(expiration = 180)
	public void updateUserProfile(@ParameterValueKeyProvider String email, UserProfile userProfile) {
		UserProfile user = getDynamoConnection().getDynamoDBMapper().load(UserProfile.class, email);
		user.setCertifications(userProfile.getCertifications());
		user.setExperience(userProfile.getExperience());
		user.setHighestDegree(userProfile.getHighestDegree());
		user.setSkills(userProfile.getSkills());
		user.setSummary(userProfile.getSummary());
		user.setUniversity(userProfile.getUniversity());
		getDynamoConnection().getDynamoDBMapper().save(user);
		}

	
	@ReadThroughSingleCache(expiration = 3600)
	public UserProfile getUserProfile(@ParameterValueKeyProvider String email) {
		UserProfile c = dynamoConnection.getDynamoDBMapper().load(UserProfile.class, email);
		//if(c==null) System.out.println("user profile  null");
		
		return c;
	}
	
}
