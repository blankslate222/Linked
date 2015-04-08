package com.cmpe282.lab3.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cmpe282.lab3.model.User;
import com.cmpe282.lab3.service.Service;

@Controller
public class FrontController {

	private Service service;
	
	public Service getService() {
		return service;
	}

	@Autowired
	public void setService(Service service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest req) {
		System.out.println(req.getSession().getAttribute("user"));
		return "home";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Model model) {
		model.addAttribute("user", new User());
		return "signup";
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public String signin(Model model) {
		model.addAttribute("user", new User());
		return "signin";
	}
	
}
