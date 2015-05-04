package com.cmpe282.lab3.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;

@DynamoDBTable(tableName="UserProfile")
public class UserProfile implements Serializable{

	private static final long serialVersionUID = 3666183246195100859L;

	private String email;
	private String summary;
	private String location;
	private String highestDegree;
	private String university;
	private String skills;
	private String certifications;
	private List<Experience> experience = new ArrayList<Experience>();
	private List<String> usersFollowed = new ArrayList<String>();
	private List<String> companiesFollowed = new ArrayList<String>();
	private List<String> status = new ArrayList<String>();
	
	public List<String> getStatus() {
		return status;
	}
	public void setStatus(List<String> status) {
		this.status = status;
	}
	@DynamoDBHashKey(attributeName="email")
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	@DynamoDBAttribute(attributeName="summary")
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	@DynamoDBAttribute(attributeName="highestDegree")
	public String getHighestDegree() {
		return highestDegree;
	}
	public void setHighestDegree(String highestDegree) {
		this.highestDegree = highestDegree;
	}
	
	@DynamoDBAttribute(attributeName="university")
	public String getUniversity() {
		return university;
	}
	public void setUniversity(String university) {
		this.university = university;
	}
	
	@DynamoDBAttribute(attributeName="skills")
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	
	@DynamoDBAttribute(attributeName="certifications")
	public String getCertifications() {
		return certifications;
	}
	public void setCertifications(String certifications) {
		this.certifications = certifications;
	}
	
	@DynamoDBAttribute(attributeName="experience")
	public List<Experience> getExperience() {
		return experience;
	}
	public void setExperience(List<Experience> experience) {
		this.experience = experience;
	}
	
	@DynamoDBAttribute(attributeName="usersFollowed")
	public List<String> getUsersFollowed() {
		return usersFollowed;
	}
	public void setUsersFollowed(List<String> companiesFollowed) {
		this.usersFollowed = companiesFollowed;
	}
	
	@DynamoDBAttribute(attributeName="companiesFollowed")
	public List<String> getCompaniesFollowed() {
		return companiesFollowed;
	}
	public void setCompaniesFollowed(List<String> companiesFollowed) {
		this.companiesFollowed = companiesFollowed;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
}
