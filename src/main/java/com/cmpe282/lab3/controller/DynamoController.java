/**
 * 
 */
package com.cmpe282.lab3.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.CompanyProfile;
import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.service.DynamoService;

/**
 * @author madhur
 *
 */
@Controller
@RequestMapping("/company")
public class DynamoController {
	private DynamoService dynamoService;
	
	public DynamoService getDynamoService() {
		return dynamoService;
	}

	@Autowired
	public void setDynamoService(DynamoService dynamoService) {
		this.dynamoService = dynamoService;
	}

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String display(Model model) {
		model.addAttribute("companyProfile", new CompanyProfile());
		return "companyProfile";
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public String createDynamoRec(@ModelAttribute("companyprofile") CompanyProfile company, BindingResult result, Model model) {
		getDynamoService().createCompanyProfile(company);
		return "redirect:/company/"+company.getCompany_id();
	}
	
	@RequestMapping(value = "/{company}", method = RequestMethod.GET)
	public String getDynamoRec(@PathVariable("company") String company, Model model) {
		CompanyProfile companyProfile = getDynamoService().getCompanyProfile(company);
		model.addAttribute("companyProfile", companyProfile);
		return "SingleCompanyView";
	}
	
	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public ModelAndView getDynamoRecords( Model model) {
		ModelAndView modelAndView = new ModelAndView("companyView");
		
		ArrayList<CompanyProfile> companyProfile = (ArrayList<CompanyProfile>) getDynamoService().getCompanyProfiles();
		modelAndView.addObject("companyList", companyProfile);
		System.out.println(companyProfile.get(0).getOverview());
		return modelAndView;
	}
	
}
