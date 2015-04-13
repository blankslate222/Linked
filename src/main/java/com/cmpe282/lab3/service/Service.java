package com.cmpe282.lab3.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;

import com.cmpe282.lab3.model.JobPosting;
import com.cmpe282.lab3.model.User;

public class Service {

	private DataSource dataSource;

	public DataSource getDataSource() {
		return dataSource;
	}

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public User getUser(String email) throws SQLException {

		String sql = "Select * from user where email = ?";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		User usr = null;

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, email);
		rs = ps.executeQuery();

		if (rs.next()) {
			usr = new User();
			usr.setId(rs.getInt("id"));
			usr.setEmail(rs.getString("email"));
			usr.setPassword(rs.getString("password"));
			usr.setFirstName(rs.getString("firstName"));
			usr.setLastName(rs.getString("lastName"));
			usr.setLastLogin(rs.getTimestamp("lastLogin"));

			ps.close();
			rs.close();
			conn.close();
		}
		return usr;
	}

	public boolean insertUser(User user) throws SQLException {

		Connection conn = null;
		PreparedStatement ps = null;
		int insert = 0;
		if ("".equals(user.getEmail()) || "".equals(user.getFirstName())
				|| "".equals(user.getLastName())
				|| "".equals(user.getPassword())) {
			return false;
		}

		String sql = "insert into user(email, password, firstName, lastName, lastLogin) values(?,?,?,?,?)";

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, user.getEmail());
		ps.setString(2, user.getPassword());
		ps.setString(3, user.getFirstName());
		ps.setString(4, user.getLastName());
		ps.setTimestamp(5, user.getLastLogin());

		insert = ps.executeUpdate();

		ps.close();
		conn.close();
		return true;
	}

	// Update last login time of the user.
	public boolean updateLastLogin(Timestamp lastLogin, String email)
			throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;

		String sql = "update  user set lastLogin = ? where email =?";

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setTimestamp(1, lastLogin);
		ps.setString(2, email);
		int rows = ps.executeUpdate();
		if (rows > 0) {
			return true;
		} else {
			return false;
		}
	}

	// get last login time of the user.
	public String getLastLogin(String email) throws SQLException {

		Connection conn = null;
		PreparedStatement ps = null;

		String sql = "select * from user where email=?";

		conn = dataSource.getConnection();

		String lastLogin = null;
		ps = conn.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			lastLogin = rs.getString("lastLogin");
		}

		return lastLogin;
	}

	public void updateJob(String job, String company, String email) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;

		Calendar cal = Calendar.getInstance();
		Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
		
		String sql = "insert into job (jobId, companyName, applicationDate, userEmail) "+
		"values(?,?,?,?)";

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, job);
		ps.setString(2, company);
		ps.setTimestamp(3, timestamp);
		ps.setString(4, email);
		
		ps.executeUpdate();
		ps.close();
		conn.close();
	}
	
	public boolean jobApplyStatus(String job, String company, String email) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean status = false;
		String sql = "select * from job where jobId=? and companyName=? and userEmail=?";

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, job);
		ps.setString(2, company);
		
		ps.setString(3, email);
		
		ResultSet resultSet = ps.executeQuery();
		if(resultSet != null && resultSet.next()) {
			status = true;
		}
		resultSet.close();
		ps.close();
		conn.close();
		return status;
	}
	
	public List<String> getJobs(String email) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;

		
		String sql = "select * from job where  userEmail = ?";
		List<String> jobs=new ArrayList<String>();
		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, email);	
		//ps.executeQuery(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
		jobs.add(rs.getString("jobId"));
		}
		ps.close();
		conn.close();
		return jobs;
		}
}
