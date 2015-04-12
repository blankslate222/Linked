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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.cmpe282.lab3.model.CompanyProfile;
import com.cmpe282.lab3.model.JobPosting;
import com.cmpe282.lab3.model.UserProfile;
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
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView searchPage(Model model) {
		ModelAndView search = new ModelAndView("search");
		search.addObject("jobResult",null);
		search.addObject("personResult",null);
		search.addObject("companyResult",null);
		search.addObject("searchTerm", "");
		return search;
	}
	
	@RequestMapping(value = "/job", method = RequestMethod.GET)
	public ModelAndView searchJob(@RequestParam("name") String idOrName,Model model) {
		ModelAndView search = new ModelAndView("search");
		List<JobPosting> result = null;
		System.out.println(idOrName);
		result = getDynamoService().getJobs(idOrName);
		search.addObject("jobResult", result);
		search.addObject("searchTerm", idOrName);
		//System.out.println(result.get(0).getJobName());
		return search;
	}
	
	@RequestMapping(value = "/people", method = RequestMethod.GET)
	public ModelAndView searchPeople(@RequestParam("name") String name,Model model) {
		ModelAndView search = new ModelAndView("search");
		List<UserProfile> result = null;
		result = getDynamoService().getPeople(name);
		search.addObject("personResult", result);
		search.addObject("searchTerm", name);
		//System.out.println(result.get(0).getUniversity());
		return search;
   	}
	
	@RequestMapping(value = "/company", method = RequestMethod.GET)
	public ModelAndView searchCompany(@RequestParam("name") String name,Model model) {
		ModelAndView search = new ModelAndView("search");
		List<CompanyProfile> result = null;
		result = getDynamoService().getCompanies(name);
		search.addObject("companyResult", result);
		search.addObject("searchTerm", name);
		//System.out.println(getDynamoService().getCompanies(name).get(1).getOverview());
		return search;
	}
	
	
	
}
