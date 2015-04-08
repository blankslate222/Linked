package com.cmpe282.lab3.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;

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

		User usr = new User();

		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, email);
		rs = ps.executeQuery();

		if (rs.next()) {
			usr.setId(rs.getInt("id"));
			usr.setEmail(rs.getString("email"));
			usr.setPassword(rs.getString("password"));
			usr.setFirstName(rs.getString("firstName"));
			usr.setLastName(rs.getString("lastName"));
			usr.setLastLogin(rs.getDate("lastLogin"));

			ps.close();
			rs.close();
			conn.close();
		}
		return usr;
	}

	public void insertUser(User user) throws SQLException {
		
		Connection conn = null;
		PreparedStatement ps = null;
		int insert = 0;
		
		String sql = "insert into user(email, password, firstName, lastName) values(?,?,?,?)";
		
		conn = dataSource.getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, user.getEmail());
		ps.setString(2, user.getPassword());
		ps.setString(3, user.getFirstName());
		ps.setString(4, user.getLastName());
		
		insert = ps.executeUpdate();
		
		ps.close();
		conn.close();
	}
	
	public void updateLastLogin(String email) throws SQLException {
		
	}
}
