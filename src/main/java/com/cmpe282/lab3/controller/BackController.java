package com.cmpe282.lab3.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.service.DynamoService;
import com.cmpe282.lab3.service.Service;

@Controller
public class BackController {
private Service service;
	
	public Service getService() {
		return service;
	}

	@Autowired
	public void setService(Service service) {
		this.service = service;
	}

	@RequestMapping(value = "/home/{email}", method = RequestMethod.GET)
	public String userHome(@PathVariable("email") String email, Model model) {
		//noSql data to be fetched
		
		User user = null;
		String view = "home";
		try {
			user = getService().getUser(email);
			model.addAttribute("user", user);
			
			//dynamoService.getCompanyProfile("");
			view="profile";
			//System.out.println(user.getFirstName()+ " " + user.getLastName());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			view = "error";
		}
		return view;
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signup(@ModelAttribute("user") User user, BindingResult result, Model model) {
		String retView = null;
		try{
		getService().insertUser(user);
			retView = "redirect:/home";
		}catch(SQLException e){
			e.printStackTrace();
			retView = "error";
		}
		return retView;
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String signin(@ModelAttribute("user") User user, BindingResult result, Model model, HttpServletRequest req) {
		String retView = null;
		User usr = null;
		String email = user.getEmail();
		String password = user.getPassword();
		//System.out.println("user:"+email + " password:"+password);
		try{
			usr = getService().getUser(email);
			if(!"".equals(password) && password.equals(usr.getPassword())) {
				req.getSession().setAttribute("user", email);
				retView = "redirect:/home/" + email;
			}
			
		}catch(SQLException e){
			e.printStackTrace();	
			retView = "error";
		}
		return retView;
	}
	
	@RequestMapping(value = "/jobs", method = RequestMethod.GET)
	public ModelAndView jobPosting() {
		ModelAndView model = new ModelAndView("jobs");
		
		Map<String, String> joblist = new HashMap<String, String>();
		joblist.put("1","job1");
		joblist.put("2","job2");
		model.addObject("joblist", joblist);
		return model;
	}
}
