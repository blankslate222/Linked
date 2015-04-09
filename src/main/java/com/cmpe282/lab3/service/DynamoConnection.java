/**
 * 
 */
package com.cmpe282.lab3.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.cmpe282.lab3.model.CompanyProfile;


/**
 * @author madhur
 *
 */
public class DynamoConnection {
	
	private AmazonDynamoDBClient dynamoDB;
	private DynamoDBMapper dynamoDBMapper;
	
	public DynamoConnection() {
		AWSCredentials awsCredentials;
		try {
			awsCredentials = new PropertiesCredentials(new File(this.getClass().getClassLoader().getResource("Awscredentials.properties").getFile()));
			dynamoDB = new AmazonDynamoDBClient(awsCredentials);
			dynamoDB.setRegion(Region.getRegion(Regions.US_WEST_2));
			dynamoDBMapper = new DynamoDBMapper(dynamoDB);
			System.out.println("done creating connection");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public AmazonDynamoDBClient getDynamoDB() {
		return dynamoDB;
	}

	public void setDynamoDB(AmazonDynamoDBClient dynamoDB) {
		this.dynamoDB = dynamoDB;
	}

	public DynamoDBMapper getDynamoDBMapper() {
		if(dynamoDBMapper == null)System.out.println("mapper null");
		return dynamoDBMapper;
	}

	public void setDynamoDBMapper(DynamoDBMapper dynamoDBMapper) {
		this.dynamoDBMapper = dynamoDBMapper;
	}
		/**
	 * @param args
	 */
	public static void main(String[] args) {
		
	}

}
