package com.cmpe282.lab3.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmpe282.lab3.model.Link;
import com.cmpe282.lab3.model.Node;
import com.cmpe282.lab3.model.Nodelink;
import com.cmpe282.lab3.recommend.mahout.Recommendation;
import com.cmpe282.lab3.service.RecommendationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
		Nodelink links = new Nodelink();
		String myJson = new String();
		try {
			
		   File file = new File(this.getClass().getClassLoader().getResource("recommendation.json").getFile());
		   FileOutputStream fstream = new FileOutputStream(file,false);
		   BufferedOutputStream out = new BufferedOutputStream(fstream);
           System.out.println("is found?"+ file.exists());

			String[] str = listOfRecommendations.get(0).getValue().split(" ");
			StringBuilder st = new StringBuilder();
			String[] temp;
			int i = 1;
			String name = "name";
			
            
			Node n1 = new Node();
		    n1.setName(listOfRecommendations.get(0).getKey());
		    n1.setGroup(i);
			
		    links.nodes.add(n1);
			
			for (String s : str) {
				i++;
				Node n = new Node();
				Link l = new Link();
				temp = s.split(":");
				n.setName(temp[0]);
				n.setGroup(i);

				l.setSource(i-1);
				l.setTarget(0);

				if (temp.length == 2) {
					int val = (int) (Double.parseDouble(temp[1]));
					if (val == 0) {
						val++;
					}
					l.setValue(val);
				}

				links.links.add(l);
				links.nodes.add(n);

			}

			ObjectMapper mapper = new ObjectMapper();

			myJson = mapper.writeValueAsString(links);
			//file.write(myJson);
		     //out.write(myJson.getBytes());
	           //Close the output stream
	           out.close();
			System.out.println(myJson);
		}

		catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		recommendation.addObject("recommendations", myJson);
		System.out.println("reco list size = " + listOfRecommendations.size());

		System.out.println(listOfRecommendations.get(0).getKey());

		return recommendation;
	}
	
	
	
	@RequestMapping(value = "/recommend/myjson", method = RequestMethod.GET)
	public @ResponseBody String getRecommendationJSON(Model model,
			HttpServletRequest req) {
		ModelAndView recommendation = new ModelAndView("recommendation");
		String userInSession = (String) req.getSession().getAttribute("user");
		List<Recommendation> listOfRecommendations = null;
		listOfRecommendations = getRecommendationService()
				.getCareerPathRecommendationsByJob(userInSession);
		Nodelink links = new Nodelink();
		String myJson = new String();
		try {
			
		   //File file = new File(this.getClass().getClassLoader().getResource("recommendation.json").getFile());
		  // FileOutputStream fstream = new FileOutputStream(file,false);
		   //BufferedOutputStream out = new BufferedOutputStream(fstream);
          // System.out.println("is found?"+ file.exists());

			String[] str = listOfRecommendations.get(0).getValue().split(" ");
			StringBuilder st = new StringBuilder();
			String[] temp;
			int i = 1;
			String name = "name";
			
            
			Node n1 = new Node();
		    n1.setName(listOfRecommendations.get(0).getKey());
		    n1.setGroup(i);
			
		    links.nodes.add(n1);
			
			for (String s : str) {
				i++;
				Node n = new Node();
				Link l = new Link();
				temp = s.split(":");
				n.setName(temp[0]);
				n.setGroup(i);

				l.setSource(i-1);
				l.setTarget(0);

				if (temp.length == 2) {
					int val = (int) (Double.parseDouble(temp[1]));
					if (val == 0) {
						val++;
					}
					l.setValue(val);
				}

				links.links.add(l);
				links.nodes.add(n);

			}

			ObjectMapper mapper = new ObjectMapper();

			myJson = mapper.writeValueAsString(links);
			//file.write(myJson);
		     //out.write(myJson.getBytes());
	           //Close the output stream
	          // out.close();
			System.out.println(myJson);
		}

		catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//recommendation.addObject("recommendations", myJson);
		System.out.println("reco list size = " + listOfRecommendations.size());

		System.out.println(listOfRecommendations.get(0).getKey());

		return myJson;
	}

}
