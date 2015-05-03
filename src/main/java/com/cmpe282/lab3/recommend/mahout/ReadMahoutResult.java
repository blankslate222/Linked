package com.cmpe282.lab3.recommend.mahout;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

import com.cmpe282.lab3.service.DynamoConnection;

public class ReadMahoutResult {

	public void readFile() {
		FileReader fr = null;
		BufferedReader br = null;
		File mahoutResultFile = null;
		String line = null;
		DynamoConnection dynamoConnection = null;
		Recommendation recommendation = null;
		mahoutResultFile = new File(this.getClass().getClassLoader().getResource("part-00000").getFile());
		try {
			fr = new FileReader(mahoutResultFile);
			br = new BufferedReader(fr);
			dynamoConnection = new DynamoConnection();
			while ( (line = br.readLine()) != null) {
				String[] input = line.split("\t");
				recommendation = new Recommendation();
				if(input.length == 2) {
					recommendation.setKey(input[0]);
					recommendation.setValue(input[1]);
					System.out.println("key = " +input[0] + " \n value = "+ input[1]);
				}else if( input.length == 1){
					recommendation.setKey(input[0]);
					recommendation.setValue("");
					System.out.println("key = " +input[0] + " \n value = null");
				}else{
					
				}
				System.out.println("-----------------------------------------");
				
				dynamoConnection.getDynamoDBMapper().save(recommendation);
			}
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch(Exception ioe){
			ioe.printStackTrace();
		}
	}
}
