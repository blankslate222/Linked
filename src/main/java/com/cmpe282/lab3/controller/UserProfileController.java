package com.cmpe282.lab3.controller;

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
import com.cmpe282.lab3.model.Experience;
import com.cmpe282.lab3.model.UserProfile;
import com.cmpe282.lab3.service.DynamoService;
import com.cmpe282.lab3.service.UserProfileService;

@Controller
public class UserProfileController {

	private UserProfileService userProfileService;
	@Autowired
	private DynamoService dynamoService;
	
	public UserProfileService getUserProfileService() {
		return userProfileService;
	}

	@Autowired
	public void setUserProfileService(UserProfileService userProfileService) {
		this.userProfileService = userProfileService;
	}

	@RequestMapping(value = "/user-profile/build", method = RequestMethod.GET)
	public String createProfile(Model model, HttpServletRequest req) {
		UserProfile userProfile = new UserProfile();
		List<Experience> exp = userProfile.getExperience();
		exp.add(new Experience());
		exp.add(new Experience());

		model.addAttribute("userProfile", userProfile);
		return "userProfile";
	}

	@RequestMapping(value = "/user-profile/build", method = RequestMethod.POST)
	public String buildProfile(@ModelAttribute("userProfile") UserProfile upf,
			BindingResult result, Model model, HttpServletRequest req) {
		String email = "" + req.getSession().getAttribute("user");
		upf.setEmail(email);
		// System.out.println(upf.getExperience().size() > 0);
		getUserProfileService().saveUserProfile(upf);
		return "redirect:/user-profile/" + email;
	}

	@RequestMapping(value = "/user-profile/{email:.+}", method = RequestMethod.GET)
	public ModelAndView profilePage(@PathVariable("email") String email,
			Model model) {
		ModelAndView modelAndView = new ModelAndView("displayUserProfile");
		// System.out.println("path var email =" + email);
		UserProfile user = getUserProfileService().getUserProfile(email);
		// System.out.println(user.getSkills());
		modelAndView.addObject("userProfile", user);
		return modelAndView;
	}

	@RequestMapping(value = "/user-profile/update", method = RequestMethod.GET)
	public String updateProfileForm(Model model, HttpServletRequest req) {
		String email = (String) req.getSession().getAttribute("user");
		System.out.println("upd prof email sess" + email);
		UserProfile user = getUserProfileService().getUserProfile(email);
		model.addAttribute("userProfile", user);
		return "userProfile";
	}

	@RequestMapping(value = "/user-profile/update", method = RequestMethod.POST)
	public String updateProfile(
			@ModelAttribute("userProfile") UserProfile userProfile,
			BindingResult result, HttpServletRequest req) {
		String email = (String) req.getSession().getAttribute("user");
		System.out.println("upd prof email sess" + email);
		getUserProfileService().updateUserProfile(email, userProfile);
		return "redirect:/user-profile/" + email;
	}

	@RequestMapping(value = "/follow/user", method = RequestMethod.GET)
	public void followUser(
			@RequestParam(value = "email", required = true) String followedUser,
			HttpServletRequest req) {

		String followedUserEmail = followedUser;
		String userInSession = (String) req.getSession().getAttribute("user");
		UserProfile user = getUserProfileService().getUserProfile(userInSession);
		user.getUsersFollowed().add(followedUserEmail);
		getUserProfileService().saveUserProfile(user);

	}

	@RequestMapping(value = "/follow/company", method = RequestMethod.GET)
	public @ResponseBody String followCompany(
			@RequestParam("id") String company,
			HttpServletRequest req) {
		String email = (String) req.getSession().getAttribute("user");
		String companyid = company;
		System.out.println("company id"+company);
		UserProfile up = getUserProfileService().getUserProfile(email);
		up.getCompaniesFollowed().add(companyid);
		getUserProfileService().saveUserProfile(up);
		CompanyProfile cp = dynamoService.getCompanyProfile(companyid);
		int followers = cp.getNumberOfFollowers();
		followers++;
		cp.setNumberOfFollowers(followers);
		dynamoService.createCompanyProfile(cp);
		return "true";
		
	}
	
	@RequestMapping(value = "/follow/company/status", method = RequestMethod.GET)
	public @ResponseBody boolean followCompanyStatus(
			@RequestParam("id") String company,
			HttpServletRequest req) {
		String email = (String) req.getSession().getAttribute("user");
		String companyid = company;
		
		boolean up = getUserProfileService().getUserProfile(email).getCompaniesFollowed().contains(company);
		
		
		return up;
		
	}

}
