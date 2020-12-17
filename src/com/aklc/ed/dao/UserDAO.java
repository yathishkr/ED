package com.aklc.ed.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.aklc.ed.model.User;
import com.aklc.ed.util.DBConnection;

public class UserDAO {

	public String getPassword(String email) throws Exception {
		Connection con = null;
		String password = "";
		try {
			con = DBConnection.connect();
			ResultSet rs = con.createStatement().executeQuery("select password from user where email='" + email + "' ");
			rs.next();
			password = rs.getString("password");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return password;
	}

	public User getUserInformation(String email) throws Exception {
		User model = new User();
		Connection con = null;
		try {
			con = DBConnection.connect();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from user where email='" + email + "' ");
			rs.next();
			String fname = rs.getString("firstname");
			String lname = rs.getString("lastname");
			String gender = rs.getString("gender");
			String mobile = rs.getString("mobile");
			String address = rs.getString("address");

			model.setEmail(email);
			model.setFirstname(fname);
			model.setLastname(lname);
			model.setGender(gender);
			model.setMobile(mobile);
			model.setAddress(address);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return model;
	}

	public void createAccount(User u) throws Exception {

		Connection con = null;
		try {
			con = DBConnection.connect();

			Statement st = con.createStatement();
			st.execute("insert into user values ('" + u.getEmail() + "', '" + u.getPassword() + "', '"
					+ u.getFirstname() + "', '" + u.getLastname() + "', '" + u.getGender() + "', '" + u.getMobile()
					+ "', '" + u.getAddress() + "') ");
			con.close();
		} catch (Exception e) {
			System.out.println("Something went wrong: " + e.getMessage());
			throw e;
		} finally {
			con.close();
		}

	}

	public boolean login(String email, String password) throws Exception {
		Connection con = null;
		try {
			con = DBConnection.connect();

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(
					"select count(*) from user where email='" + email + "' and password='" + password + "' ");
			rs.next();
			int check = rs.getInt(1);
			if (check == 0)
				return false;
			else
				return true;

		} catch (Exception e) {
			System.out.println("Something went wrong: " + e.getMessage());
			throw e;
		} finally {
			con.close();
		}

	}

	public void editProfile(User u) throws Exception {
		Connection con = null;
		try {
			con = DBConnection.connect();

			Statement st = con.createStatement();
			st.execute("update user set firstname='" + u.getFirstname() + "', lastname='" + u.getLastname()
					+ "', gender='" + u.getGender() + "', mobile='" + u.getMobile() + "', address='" + u.getAddress()
					+ "' where email='" + u.getEmail() + "' ");

		} catch (Exception e) {
			System.out.println("Something went wrong: " + e.getMessage());
			throw e;
		} finally {
			con.close();
		}
	}

	public boolean changePassword(String email, String currentPassword, String newPassword) throws Exception {
		Connection con = null;
		try {

			boolean check = login(email, currentPassword);
			con = DBConnection.connect();
			if (check) {

				Statement st = con.createStatement();
				st.execute("update user set password='" + newPassword + "' where email='" + email + "' ");
				return true;
			} else {
				System.out.println("Current Password is incorrect");
				return false;
			}

		} catch (Exception e) {
			System.out.println("Something went wrong: " + e.getMessage());
			throw e;
		} finally {
			con.close();
		}

	}

	public void deleteProfile(String email) throws Exception {
		Connection con = null;
		try {
			con = DBConnection.connect();

			Statement st = con.createStatement();
			st.execute("delete from user where email='" + email + "' ");
			con.close();
		} catch (Exception e) {
			System.out.println("Something went wrong: " + e.getMessage());
			throw e;
		}

	}

	// This method will read the data from the 'user' table
	public static void main(String arg[]) throws Exception {
		UserDAO dao = new UserDAO();
		User user = new User();
		user.setEmail("anil@gmail.com");
		user.setPassword("1234");
		user.setFirstname("Anil");
		user.setLastname("Kumar");
		user.setGender("Male");
		user.setMobile("9999999999");
		user.setAddress("Bangalore");
		dao.createAccount(user);
	}
}
