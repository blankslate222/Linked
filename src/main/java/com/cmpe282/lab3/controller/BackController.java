package com.cmpe282.lab3.controller;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.service.Service;

@Controller
@SessionAttributes("user1")
public class BackController {
private Service service;
	
	public Service getService() {
		return service;
	}

	@Autowired
	public void setService(Service service) {
		this.service = service;
	}

	/**
	 * userHome:
	 * Display user profile.
	 * @param email
	 * @param model
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/home/{email}", method = RequestMethod.GET)
	public String userHome(@PathVariable("email") String email, Model model, @ModelAttribute("user1") User user) {
		//noSql data to be fetched
		
		//User user = null;
		String view = "home";
		//user = getService().getUser(email);
		model.addAttribute("user", user);
		
		//dynamoService.getCompanyProfile("");
		view="profile";
		//System.out.println(user.getFirstName()+ " " + user.getLastName());
		return view;
	}
	
	/**
	 * signup:
	 * insert user details and last login time in user table.
	 * redirect to user profile page
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signup(@ModelAttribute("user") User user, BindingResult result, Model model) {
		ModelAndView retView = new ModelAndView();
		try{
			Calendar cal = Calendar.getInstance();
			Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
			user.setLastLogin(timestamp);
			getService().insertUser(user);
			
			retView.addObject("user1", user);
			retView.setViewName("redirect:/home/" + user.getEmail());
		} catch (SQLException e) {
			e.printStackTrace();
			retView.setViewName("error");
		}
		return retView;
	}
	
	/**
	 * signin:
	 * validate user.
	 * Redirect to user profile page.
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public ModelAndView signin(@ModelAttribute("user") User user, BindingResult result, Model model) {
		ModelAndView retView = new ModelAndView();
		User usr = null;
		String email = user.getEmail();
		String password = user.getPassword();
		//System.out.println("user:"+email + " password:"+password);
		try{
			usr = getService().getUser(email);
			if(!"".equals(password) && password.equals(usr.getPassword())) {
				retView.addObject("user1", usr);
				retView.setViewName("redirect:/home/" + email);
			}
			
		}catch(SQLException e){
			e.printStackTrace();	
			retView.setViewName("error");
		}
		return retView;
	}
	
	/**
	 * jobPosting:
	 * 
	 * @return
	 */
	@RequestMapping(value = "/jobs", method = RequestMethod.GET)
	public ModelAndView jobPosting() {
		ModelAndView model = new ModelAndView("jobs");
		
		Map<String, String> joblist = new HashMap<String, String>();
		joblist.put("1","job1");
		joblist.put("2","job2");
		model.addObject("joblist", joblist);
		return model;
	}
	
	/***
	 * SignOut
	 * update lastLogin time, destroy session, go to signin page.
	 * @param model
	 * @param sessionStatus
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signOut(Model model, SessionStatus sessionStatus, @ModelAttribute("user1") User user) {
		String view = "signin";
		Calendar cal = Calendar.getInstance();
		Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
		try {
			getService().updateLastLogin(timestamp, user.getEmail()+".com");
			model.addAttribute("user", new User());
			sessionStatus.setComplete();
			
		} catch (SQLException e) {
			e.printStackTrace();
			view="error";
		}
		return view;
	}

}
