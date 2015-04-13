package com.cmpe282.lab3.service;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeoutException;

import net.spy.memcached.MemcachedClient;

import org.springframework.beans.factory.annotation.Autowired;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.amazonaws.services.elastictranscoder.model.Job;
import com.cmpe282.lab3.model.CompanyProfile;
import com.cmpe282.lab3.model.JobPosting;
import com.cmpe282.lab3.model.UserProfile;
import com.google.code.ssm.Cache;
import com.google.code.ssm.CacheFactory;
import com.google.code.ssm.api.format.SerializationType;
import com.google.code.ssm.providers.CacheException;
import com.sun.corba.se.impl.oa.poa.ActiveObjectMap.Key;

public class DynamoService {

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

	public void createCompanyProfile(CompanyProfile companyProfile) {
		getDynamoConnection().getDynamoDBMapper().save(companyProfile);
	}

	public void createJobPosting(JobPosting jobPosting) {

		getDynamoConnection().getDynamoDBMapper().save(jobPosting);
		CompanyProfile companyProfile = getDynamoConnection()
				.getDynamoDBMapper().load(CompanyProfile.class,
						jobPosting.getCompanyName());
		ArrayList<String> lists = (ArrayList<String>) companyProfile.getJobs();
		if (lists != null) {
			lists.add(jobPosting.getId());
		} else {
			lists = new ArrayList<String>();
			lists.add(jobPosting.getId());
		}
		companyProfile.setJobs(lists);
		getDynamoConnection().getDynamoDBMapper().save(companyProfile);
	}

	public List<String> getAllJobs(String companyName) {
		CompanyProfile companyProfile = getDynamoConnection()
				.getDynamoDBMapper().load(CompanyProfile.class, companyName);
		return (companyProfile.getJobs());
	}

	public List<JobPosting> getActiveJobs(String companyName) {

		CompanyProfile companyProfile = getDynamoConnection()
				.getDynamoDBMapper().load(CompanyProfile.class, companyName);
		if (companyProfile != null) {
			ArrayList<String> lists = (ArrayList<String>) companyProfile
					.getJobs();
			List<JobPosting> result = null;
			if (lists == null) {
				return null;
			} else {
				result = new ArrayList<JobPosting>();
				for (String str : lists) {
					JobPosting jobPosting = getDynamoConnection()
							.getDynamoDBMapper().load(JobPosting.class, str);
					if (jobPosting != null
							&& jobPosting.getExpiry().after(new Date())) {
						result.add(jobPosting);
					} else {
						if (jobPosting != null) {
							getDynamoConnection().getDynamoDBMapper().delete(
									jobPosting);
						}
					}
				}
			}

		}
		return null;

	}

	public void removeJob(String companyName, String jobId) {
		CompanyProfile companyProfile = getDynamoConnection()
				.getDynamoDBMapper().load(CompanyProfile.class, companyName);
		System.out.println(companyName);
		System.out.println(jobId);
		ArrayList<String> lists = (ArrayList<String>) companyProfile.getJobs();
		Iterator<String> ite = lists.iterator();
		while (ite.hasNext()) {
			String next = ite.next();
			if (next.equals(jobId)) {
				JobPosting jobPosting = getDynamoConnection()
						.getDynamoDBMapper().load(JobPosting.class, next);
				ite.remove();
				getDynamoConnection().getDynamoDBMapper().delete(jobPosting);
			}
		}
		companyProfile.setJobs(lists);
		getDynamoConnection().getDynamoDBMapper().save(companyProfile);

	}

	public CompanyProfile getCompanyProfile(String name) {
		CompanyProfile c = getDynamoConnection().getDynamoDBMapper().load(
				CompanyProfile.class, name);
		return c;
	}

	public JobPosting getJobPosting(String name) {
		JobPosting c = getDynamoConnection().getDynamoDBMapper().load(
				JobPosting.class, name);
		return c;
	}

	public List<String> getStatusPosts(String name) {
		CompanyProfile c = getDynamoConnection().getDynamoDBMapper().load(
				CompanyProfile.class, name);
		return c.getStatusPost();
	}

	public void removePost(String status, String name) {
		CompanyProfile c = getDynamoConnection().getDynamoDBMapper().load(
				CompanyProfile.class, name);
		ArrayList<String> arr = (ArrayList<String>) c.getStatusPost();
		arr.remove(status);
		c.setStatusPost(arr);
		getDynamoConnection().getDynamoDBMapper().save(c);
	}

	public void postStatus(String status, String name) {
		CompanyProfile c = getDynamoConnection().getDynamoDBMapper().load(
				CompanyProfile.class, name);
		ArrayList<String> statusList = (ArrayList<String>) c.getStatusPost();
		System.out.println(statusList);
		if (statusList != null && statusList.size() > 0) {

			statusList.add(status);
			System.out.println(statusList);
		} else {

			statusList = new ArrayList<String>();
			statusList.add(status);

		}
		System.out.println(statusList);
		c.setStatusPost(statusList);

		getDynamoConnection().getDynamoDBMapper().save(c);
	}

	public void postUserStatus(String status, String name) {
		System.out.println(name);
		UserProfile c = getDynamoConnection().getDynamoDBMapper().load(
				UserProfile.class, name);
		ArrayList<String> statusList = (ArrayList<String>) c.getStatus();
		System.out.println(statusList);
		if (statusList != null) {
			System.out.println("status is " + status);
			statusList.add(status);
			System.out.println("not null" + statusList);
		} else {

			statusList = new ArrayList<String>();
			statusList.add(status);

		}
		System.out.println(statusList);
		c.setStatus(statusList);

		getDynamoConnection().getDynamoDBMapper().save(c);
	}

	public List<CompanyProfile> getCompanyProfiles(String user) {
		ArrayList<String> ids = new ArrayList<String>();

		ScanResult result = null;

		do {
			ScanRequest req = new ScanRequest();
			req.setTableName("Company");

			if (result != null) {
				req.setExclusiveStartKey(result.getLastEvaluatedKey());
			}

			result = getDynamoConnection().getDynamoDB().scan(req);

			List<Map<String, AttributeValue>> rows = result.getItems();

			for (Map<String, AttributeValue> map : rows) {
				try {
					AttributeValue v = map.get("company_id");
					String id = v.getS();
					ids.add(id);
				} catch (NumberFormatException e) {
					System.out.println(e.getMessage());
				}
			}
		} while (result.getLastEvaluatedKey() != null);
		List<CompanyProfile> lists = new ArrayList<CompanyProfile>();
		for (int i = 0; i < ids.size(); i++) {
			CompanyProfile companyProfile = getDynamoConnection()
					.getDynamoDBMapper().load(CompanyProfile.class, ids.get(i));
			if (companyProfile.getEmail().equals(user)) {
				lists.add(companyProfile);
			}
		}
		return lists;
	}

	@SuppressWarnings("unchecked")
	public List<JobPosting> getJobs(String id) {
		String configEndpoint = "localhost";
		Integer clusterPort = 11211;
		Object obj = null;
		MemcachedClient client = null;
		List<JobPosting> lists = new ArrayList<JobPosting>();
		try {
			client = new MemcachedClient(new InetSocketAddress(configEndpoint,
					clusterPort));
			obj = client.get(id);
			if(obj != null) {
				lists = (List<JobPosting>) obj;
				System.out.println("from cache with size ="+lists.size());
				return lists;
			}
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		List<Map<String, AttributeValue>> items = new ArrayList<Map<String, AttributeValue>>();
		Condition scanFilterCondition = new Condition().withComparisonOperator(
				ComparisonOperator.CONTAINS).withAttributeValueList(
				new AttributeValue().withS(id));
		Map<String, Condition> conditions = new HashMap<String, Condition>();
		conditions.put("id", scanFilterCondition);
		System.out.println("1");
		Key lastKeyEvaluated = null;
		List<String> ids = new ArrayList<String>();
		do {
			System.out.println("2");
			ScanRequest scanRequest = new ScanRequest().withTableName(
					"JobPosting").withScanFilter(conditions);
			System.out.println("3");
			ScanResult result = getDynamoConnection().getDynamoDB().scan(
					scanRequest);
			System.out.println("4");
			for (Map<String, AttributeValue> item : result.getItems()) {
				items.add(item);
				if (item.containsKey("id")) {
					AttributeValue v = item.get("id");
					String id1 = v.getS();
					ids.add(id1);
				}

			}

			lastKeyEvaluated = (Key) result.getLastEvaluatedKey();

		} while (lastKeyEvaluated != null);
		System.out.println("5");
		
		for (int i = 0; i < ids.size(); i++) {
			JobPosting companyProfile = getDynamoConnection()
					.getDynamoDBMapper().load(JobPosting.class, ids.get(i));
			if (companyProfile.getExpiry().after(new Date())) {
				lists.add(companyProfile);
			} else {
				getDynamoConnection().getDynamoDBMapper()
						.delete(companyProfile);
			}
		}
		System.out.println("5");
		client.set(id, 3600, lists);
		System.out.println("cache miss - added");
		return lists;
	}

	public List<UserProfile> getPeople(String name) {
		List<Map<String, AttributeValue>> items = new ArrayList<Map<String, AttributeValue>>();
		Condition scanFilterCondition = new Condition().withComparisonOperator(
				ComparisonOperator.CONTAINS).withAttributeValueList(
				new AttributeValue().withS(name));
		Map<String, Condition> conditions = new HashMap<String, Condition>();
		conditions.put("email", scanFilterCondition);
		System.out.println("1");
		Key lastKeyEvaluated = null;
		List<String> ids = new ArrayList<String>();
		do {
			System.out.println("2");
			ScanRequest scanRequest = new ScanRequest().withTableName(
					"UserProfile").withScanFilter(conditions);
			System.out.println("3");
			ScanResult result = getDynamoConnection().getDynamoDB().scan(
					scanRequest);
			System.out.println("4");
			for (Map<String, AttributeValue> item : result.getItems()) {
				items.add(item);
				if (item.containsKey("email")) {
					AttributeValue v = item.get("email");
					String id1 = v.getS();
					ids.add(id1);
				}

			}

			lastKeyEvaluated = (Key) result.getLastEvaluatedKey();

		} while (lastKeyEvaluated != null);
		System.out.println("5");
		List<UserProfile> lists = new ArrayList<UserProfile>();
		for (int i = 0; i < ids.size(); i++) {
			UserProfile companyProfile = getDynamoConnection()
					.getDynamoDBMapper().load(UserProfile.class, ids.get(i));
			lists.add(companyProfile);
		}
		System.out.println("5");
		return lists;
	}

	public List<CompanyProfile> getCompanies(String name) {
		List<Map<String, AttributeValue>> items = new ArrayList<Map<String, AttributeValue>>();
		Condition scanFilterCondition = new Condition().withComparisonOperator(
				ComparisonOperator.CONTAINS).withAttributeValueList(
				new AttributeValue().withS(name));
		Map<String, Condition> conditions = new HashMap<String, Condition>();
		conditions.put("company_id", scanFilterCondition);
		System.out.println("1");
		Key lastKeyEvaluated = null;
		List<String> ids = new ArrayList<String>();
		do {
			System.out.println("2");
			ScanRequest scanRequest = new ScanRequest()
					.withTableName("Company").withScanFilter(conditions);
			System.out.println("3");
			ScanResult result = getDynamoConnection().getDynamoDB().scan(
					scanRequest);
			System.out.println("4");
			for (Map<String, AttributeValue> item : result.getItems()) {
				items.add(item);
				if (item.containsKey("company_id")) {
					AttributeValue v = item.get("company_id");
					String id1 = v.getS();
					ids.add(id1);
				}

			}

			lastKeyEvaluated = (Key) result.getLastEvaluatedKey();

		} while (lastKeyEvaluated != null);
		System.out.println("5");
		List<CompanyProfile> lists = new ArrayList<CompanyProfile>();
		for (int i = 0; i < ids.size(); i++) {
			CompanyProfile companyProfile = getDynamoConnection()
					.getDynamoDBMapper().load(CompanyProfile.class, ids.get(i));
			lists.add(companyProfile);
		}
		System.out.println("5");
		return lists;
	}

}
