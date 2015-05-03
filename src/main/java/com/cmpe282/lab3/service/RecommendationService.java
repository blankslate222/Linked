package com.cmpe282.lab3.service;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.cmpe282.lab3.model.Experience;
import com.cmpe282.lab3.model.UserProfile;
import com.cmpe282.lab3.recommend.mahout.Recommendation;

public class RecommendationService {

	private DynamoConnection dynamoConnection;
	private UserProfileService userProfileService;

	public DynamoConnection getDynamoConnection() {
		return dynamoConnection;
	}

	@Autowired
	public void setDynamoConnection(DynamoConnection dynamoConnection) {
		this.dynamoConnection = dynamoConnection;
	}

	public UserProfileService getUserProfileService() {
		return userProfileService;
	}

	@Autowired
	public void setUserProfileService(UserProfileService userProfileService) {
		this.userProfileService = userProfileService;
	}

	public List<Recommendation> getCareerPathRecommendationsByJob(String forUser) {
		List<Recommendation> recommendations = new LinkedList<Recommendation>();
		UserProfile userProfile = getUserProfileService().getUserProfile(forUser);
		List<Experience> experiences = userProfile.getExperience();
		for( Experience exp : experiences ) {
			recommendations.add(getDynamoConnection().getDynamoDBMapper().load(Recommendation.class, exp.getPosition()));
		}
		return recommendations;
	}
}
