package com.cmpe282.lab3.controller;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.JobPosting;
import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.model.UserProfile;
import com.cmpe282.lab3.service.DynamoService;
import com.cmpe282.lab3.service.Service;
import com.cmpe282.lab3.service.UserProfileService;

@Controller
@SessionAttributes("user1")
public class BackController {
	private Service service;
	@Autowired
	private UserProfileService userProfileService;
	@Autowired
	private DynamoService dynamoService;

	public Service getService() {
		return service;
	}

	@Autowired
	public void setService(Service service) {
		this.service = service;
	}

	/**
	 * userHome: Display user profile.
	 * 
	 * @param email
	 * @param model
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/home/{email:.+}", method = RequestMethod.GET)
	public ModelAndView userHome(@PathVariable("email") String email,
			Model model, HttpServletRequest req) {
		ModelAndView modelView = null;
		if("Guest".equals((String)req.getSession().getAttribute("user"))){
			ModelAndView mv = new ModelAndView("signin");
			mv.addObject("user",new User());
			return mv;
		}
		String userinSession = (String) req.getSession().getAttribute("user");
		System.out.println("1 - user in sess" + userinSession);
		if ("".equals(userinSession) || "Guest".equals(userinSession)
				|| !email.equals(userinSession)) {
			System.out.println("2");
			return new ModelAndView("error");
		}
		// noSql data to be fetched
	      modelView = new ModelAndView("profile");
	        UserProfile upf = null;
	        User usr = null;
	        List<String> companies = null;
	        List<String> users = null;
	        List<String> statuses = new ArrayList<String>();
	        List<String> jobs = null;
	        try {
	            usr = getService().getUser(email);
	            upf = userProfileService.getUserProfile(email);
	            companies = upf.getCompaniesFollowed();
	            users = upf.getUsersFollowed();
	            jobs = getService().getJobs(email);
	            if(jobs == null) {
	            	jobs = new ArrayList<String>();
	            	jobs.add("You have not applied to any jobs yet");
	            }
	            if(users == null) {
	            	users = new ArrayList<String>();
	            	users.add("You are not following anybody");
	            }
	            if (companies == null) {
	                companies = new ArrayList<String>();
	                companies.add("You are not following any company");
	                statuses.add("No updates from the companies");
	            } 
	            else {
	                for (String company : companies) {
	                    
	                    List<String> posts = dynamoService.getStatusPosts(company);
	                    if(posts != null) {
	                        int n = posts.size();
	                        n = (n < 2) ? n : 2;
	                        for (int i = 0; i < n; i++) {
	                            statuses.add(posts.get(i)+"<b> - "+company+"</b>");
	                            //System.out.println(posts.get(i));
	                        }
	                    }
	                    
	                }
	            }
	            System.out.println("3");
	        } catch (NullPointerException e) {
			if (companies == null)
				companies = new ArrayList<String>();
			statuses.add("No updates from the companies");
			companies.add("You are not following any company");
			System.out.println("4");
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("5");
			e.printStackTrace();
			return new ModelAndView("error");
		}
		System.out.println("6");
		Set<String> set = new HashSet<String>(); 
		set = dynamoService.userRecommendations(upf.getLocation(), upf.getSkills().split(","));
		Set<String> subSet = new HashSet<String>();
		if(set != null && set.size() > 5) {
			List<String> list =  new ArrayList<String>(set);
			subSet = new LinkedHashSet<String>(list.subList(0, 5));
			modelView.addObject("reco", subSet);
		} else {
			modelView.addObject("reco", set);
		}
		
		modelView.addObject("user", usr);
		modelView.addObject("companies", companies);
		modelView.addObject("posts", statuses);
		modelView.addObject("users", users);
		modelView.addObject("jobs", jobs);
		// System.out.println(user.getFirstName()+ " " + user.getLastName());
		return modelView;
	}

	/**
	 * signup: insert user details and last login time in user table. redirect
	 * to user profile page
	 * 
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signup(@ModelAttribute("user") User user,
			BindingResult result, Model model, HttpServletRequest req) {
		ModelAndView retView = new ModelAndView();
		try {
			if (getService().getUser(user.getEmail()) != null){
				ModelAndView signup = new ModelAndView("signup");
				signup.addObject("user", new User());
				signup.addObject("msg","User already exists");
				return signup;
			}
			
			Calendar cal = Calendar.getInstance();
			Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
			user.setLastLogin(timestamp);
			if(!getService().insertUser(user)) {
				ModelAndView signup = new ModelAndView("signup");
				signup.addObject("user", new User());
				signup.addObject("msg","One or more fields are missing");
				return signup;
			}
			
			req.getSession().setAttribute("user", user.getEmail());
			req.getSession().setAttribute("name", user.getFirstName());
			req.getSession().setAttribute("lastLogin", user.getLastLogin());
			UserProfile defaultProfile = new UserProfile();
			defaultProfile.setEmail(user.getEmail());
			userProfileService.saveUserProfile(defaultProfile);
			retView.addObject("user1", user);
			retView.setViewName("redirect:/user-profile/build");
		} catch (SQLException e) {
			e.printStackTrace();
			retView.setViewName("error");
		}
		return retView;
	}

	/**
	 * signin: validate user. Redirect to user profile page.
	 * 
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public ModelAndView signin(@ModelAttribute("user") User user,
			BindingResult result, Model model, HttpServletRequest req) {
		ModelAndView retView = new ModelAndView();
		User usr = null;
		String email = user.getEmail();
		String password = user.getPassword();
		System.out.println("user:" + email + " password:" + password);
		try {
			usr = getService().getUser(email);
			if(usr == null) {
				ModelAndView mav =  new ModelAndView("signin");
				mav.addObject("user", new User());
				mav.addObject("msg", "Sign up before logging in");
				
				return mav;
			}
			if (!"".equals(password) && password.equals(usr.getPassword())) {
				retView.addObject("user1", usr);
				
				req.getSession().setAttribute("user", email);
				req.getSession().setAttribute("name", usr.getFirstName());
				req.getSession().setAttribute("lastLogin", usr.getLastLogin());
				
				System.out.println("set session to"
						+ req.getSession().getAttribute("user"));
				retView.setViewName("redirect:/home/" + email);
			}else{
				ModelAndView mv = new ModelAndView("signin");
				mv.addObject("user", new User());
				mv.addObject("msg", "Invalid login credentials");
				return mv;
			}

		} catch (SQLException e) {
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
		joblist.put("1", "job1");
		joblist.put("2", "job2");
		model.addObject("joblist", joblist);
		return model;
	}
	
	

	/***
	 * SignOut update lastLogin time, destroy session, go to signin page.
	 * 
	 * @param model
	 * @param sessionStatus
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signOut(Model model, SessionStatus sessionStatus,
			@ModelAttribute("user1") User user, HttpServletRequest req) {
		String view = "signin";
		Calendar cal = Calendar.getInstance();
		Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
		try {
			System.out.println(user.getEmail());
			getService().updateLastLogin(timestamp, user.getEmail());
			model.addAttribute("user", new User());
			req.getSession().setAttribute("user", "");
			req.getSession().invalidate();
			sessionStatus.setComplete();

		} catch (SQLException e) {
			e.printStackTrace();
			view = "error";
		}
		return view;
	}
	
	@RequestMapping(value = "/job/{id}", method = RequestMethod.GET)
	public ModelAndView jobPostingPage(@PathVariable("id") String name) {
ModelAndView model = new ModelAndView("jobResult");

		
		model.addObject(dynamoService.getJobPosting(name));
		return model;
	}
	
	@RequestMapping(value="/apply/job", method = RequestMethod.GET)
	public String updateJobApply(@RequestParam("jobId") String jobId, 
			@RequestParam("company") String company, Model model, HttpServletRequest req) {
		
		String email = ""+req.getSession().getAttribute("user");
		try {
			getService().updateJob(jobId, company, email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}
		return "home";
	}
	
	@RequestMapping(value="/apply/job/status", method = RequestMethod.GET)
	public @ResponseBody boolean jobApplyStatus(@RequestParam("jobId") String jobId, 
			@RequestParam("company") String company, Model model, HttpServletRequest req) {
		boolean status = false;
		String email = ""+req.getSession().getAttribute("user");
		try {
			status = getService().jobApplyStatus(jobId, company, email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return status;
	}


}
