package com.cmpe282.lab3.model;

import java.io.Serializable;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBDocument;

@DynamoDBDocument
public class Experience implements Serializable{

	private static final long serialVersionUID = -4556123040864984929L;
	
	private String company;
	private String numberOfYears;
	
	@DynamoDBAttribute(attributeName = "company")
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
	@DynamoDBAttribute(attributeName = "numberOfYears")
	public String getNumberOfYears() {
		return numberOfYears;
	}
	public void setNumberOfYears(String numberOfYears) {
		this.numberOfYears = numberOfYears;
	}

}
