package com.cmpe282.lab3.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.recommend.mahout.Recommendation;
import com.cmpe282.lab3.service.RecommendationService;

@Controller
public class RecommendationController {

	private RecommendationService recommendationService;

	public RecommendationService getRecommendationService() {
		return recommendationService;
	}

	@Autowired
	public void setRecommendationService(
			RecommendationService recommendationService) {
		this.recommendationService = recommendationService;
	}

	@RequestMapping(value = "/recommend/career-path", method = RequestMethod.GET)
	public ModelAndView careerPathByJobPosition(Model model,
			HttpServletRequest req) {
		ModelAndView recommendation = new ModelAndView("recommendation");
		String userInSession = (String) req.getSession().getAttribute("user");
		List<Recommendation> listOfRecommendations = null;
		listOfRecommendations = getRecommendationService()
				.getCareerPathRecommendationsByJob(userInSession);
		recommendation.addObject("recommendations", listOfRecommendations);
		System.out.println("reco list size = "+listOfRecommendations.size());
		return recommendation;
	}
}
