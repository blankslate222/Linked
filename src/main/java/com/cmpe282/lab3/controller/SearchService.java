/**
 * 
 */
package com.cmpe282.lab3.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.cmpe282.lab3.model.CompanyProfile;
import com.cmpe282.lab3.service.DynamoService;
import com.sun.corba.se.impl.oa.poa.ActiveObjectMap.Key;

/**
 * @author madhur
 *
 */
@Controller
@RequestMapping("/search")
public class SearchService {

private DynamoService dynamoService;
	
	public DynamoService getDynamoService() {
		return dynamoService;
	}

	@Autowired
	public void setDynamoService(DynamoService dynamoService) {
		this.dynamoService = dynamoService;
	}
	
	@RequestMapping(value = "/job/{idOrName}", method = RequestMethod.GET)
	public void searchJob(@PathVariable("idOrName") String idOrName,Model model) {
		System.out.println(getDynamoService().getJobs("123456").get(0).getJobName());
        
	}
	
	@RequestMapping(value = "/people/{name}", method = RequestMethod.GET)
	public void searchPeople(@PathVariable("name") String name,Model model) {
		System.out.println(getDynamoService().getPeople("first@second.third").get(0).getUniversity());
        
	}
	
	@RequestMapping(value = "/company/{name}", method = RequestMethod.GET)
	public void searchCompany(@PathVariable("name") String name,Model model) {
		System.out.println(getDynamoService().getCompanies("dhur").get(1).getOverview());
        
	}
	
}
