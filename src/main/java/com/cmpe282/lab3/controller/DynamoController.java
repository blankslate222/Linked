/**
 * 
 */
package com.cmpe282.lab3.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.CompanyProfile;
import com.cmpe282.lab3.model.JobPosting;
import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.service.DynamoService;
import com.google.gson.Gson;

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
	public ModelAndView getDynamoRecords( Model model, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("companyView");
		String user = (String)request.getSession().getAttribute("user");
		ArrayList<CompanyProfile> companyProfile = (ArrayList<CompanyProfile>) getDynamoService().getCompanyProfiles(user);
		modelAndView.addObject("companyList", companyProfile);
		System.out.println(companyProfile.get(0).getOverview());
		return modelAndView;
	}
	
	@RequestMapping(value = "/manage", method = RequestMethod.GET)
	public String manageCompany(Model model, HttpServletRequest request) {
		System.out.println(request.getSession().getAttribute("user"));
		String user = (String)request.getSession().getAttribute("user");
		List<CompanyProfile> companyProfile = getDynamoService().getCompanyProfiles(user);
		model.addAttribute("companyProfile", companyProfile);
		return "manageCompany";
	}
	
	@RequestMapping(value = "/status/{name}", method = RequestMethod.POST)
	public @ResponseBody String postStatus(@PathVariable("name") String name, @RequestParam(value="status") String status, Model model) {
		getDynamoService().postStatus(status,name);
		return "true";
	}
	
	@RequestMapping(value = "/status/{name}", method = RequestMethod.DELETE)
	public @ResponseBody String deleteStatus(@PathVariable("name") String name, @RequestParam(value="status") String status, Model model) {
		getDynamoService().removePost(status,name);
		return "true";
	}
	
	@RequestMapping(value = "/job/{name}", method = RequestMethod.DELETE)
	public @ResponseBody String deletejob(@PathVariable("name") String name, @RequestParam(value="jobId") String jobId, Model model) {
		getDynamoService().removeJob(name,jobId);
		return "true";
	}
	//
	@RequestMapping(value = "/job/{name}", method = RequestMethod.GET)
	public @ResponseBody String getJobs(@PathVariable("name") String name,Model model) {
		List<JobPosting> jobs = getDynamoService().getActiveJobs(name);
		System.out.println(new Gson().toJson(jobs));
		return new Gson().toJson(jobs);

	}
	
	@RequestMapping(value = "/job/{name}", method = RequestMethod.POST)
	public @ResponseBody String postJob(@PathVariable("name") String name, @RequestParam(value="jobId") String jobId,@RequestParam(value="jobName") String jobName,@RequestParam(value="desc") String desc,@RequestParam(value="expiry") String expiry, Model model) {
		JobPosting jobPosting = new JobPosting();
		jobPosting.setCompanyName(name);
		jobPosting.setDescription(desc);
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		try {
			jobPosting.setExpiry(dateFormat.parse(expiry));
		} catch (ParseException e) {
			
		}
		jobPosting.setId(jobId);
		jobPosting.setJobName(jobName);
		getDynamoService().createJobPosting(jobPosting);
		return "true";
	}
	
	@RequestMapping(value = "/{name}", method = RequestMethod.PUT)
	public @ResponseBody String edit(@PathVariable("name") String name,@RequestParam(value="url") String url,@RequestParam(value="overview") String overview, Model model) {
		CompanyProfile companyProfile = getDynamoService().getCompanyProfile(name);
		companyProfile.setUrl(url);
		companyProfile.setOverview(overview);
		getDynamoService().createCompanyProfile(companyProfile);
		return "true";
	}
	
}
