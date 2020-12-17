package com.aklc.ed.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aklc.ed.dao.UserDAO;
import com.aklc.ed.model.User;
import com.aklc.ed.notification.SendSMS;

public class UserServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String req_type = req.getParameter("req_type");
		if (req_type.equals("register")) {
			// 1. Read the input
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			String fname = req.getParameter("fname");
			String lname = req.getParameter("lname");
			String gender = req.getParameter("gender");
			String mobile = req.getParameter("mobile");
			String address = req.getParameter("address");

			// 2. Create an Account
			UserDAO dao = new UserDAO();
			User u = new User();
			u.setEmail(email);
			u.setPassword(password);
			u.setFirstname(fname);
			u.setLastname(lname);
			u.setGender(gender);
			u.setMobile(mobile);
			u.setAddress(address);

			try {
				dao.createAccount(u);
				SendSMS.trigger(u.getMobile(), "Your Profile has been created in ED Portal");
				resp.sendRedirect("register.jsp?msg=Registration Successful");
			} catch (Exception e) {
				resp.sendRedirect("register.jsp?msg=Registration Failed");
			}

		} else if (req_type.equals("login")) {
			// Step 1: read email and password
			String email = req.getParameter("email");
			String password = req.getParameter("password");

			// Step 2: verify
			UserDAO dao = new UserDAO();
			boolean res = false;

			try {
				res = dao.login(email, password);
				if (res) {
					User model = dao.getUserInformation(email);
					req.getSession().setAttribute("model", model);
					req.getSession().setAttribute("loggedin", "yes");
					SendSMS.trigger(model.getMobile(), "Login Successful to ED Portal");					
					resp.sendRedirect("welcome.jsp?msg=You have been logged in");
				} else {
					resp.sendRedirect("login.jsp?msg=Invalid Credentials");
				}

			} catch (Exception e) {
				resp.sendRedirect("login.jsp?msg=Sorry something went wrong while validating your credentials");
			}

			// Step 3: Response

		} else if (req_type.equals("logout")) {
			req.getSession().invalidate();
			resp.sendRedirect("login.jsp?msg=Successfully logged out");

		} else if (req_type.equals("updateprofile")) {

			// 1. Read the input
			String email = req.getParameter("email");
			String fname = req.getParameter("fname");
			String lname = req.getParameter("lname");
			String gender = req.getParameter("gender");
			String mobile = req.getParameter("mobile");
			String address = req.getParameter("address");

			// 2. Create an Account
			UserDAO dao = new UserDAO();
			User u = new User();
			u.setEmail(email);
			u.setFirstname(fname);
			u.setLastname(lname);
			u.setGender(gender);
			u.setMobile(mobile);
			u.setAddress(address);

			try {
				dao.editProfile(u);
				req.getSession().removeAttribute("model");
				req.getSession().setAttribute("model", u);

				resp.sendRedirect("updateprofile.jsp?msg=Profile Update Successful");
			} catch (Exception e) {
				resp.sendRedirect(
						"updateprofile.jsp?msg=Something went wrong while updating your profile. Try again later");
			}

		} else if (req_type.equals("deleteprofile")) {

			UserDAO dao = new UserDAO();
			User model = (User) req.getSession().getAttribute("model");
			try {
				dao.deleteProfile(model.getEmail());
				resp.sendRedirect("login.jsp?msg=Profile Deleted");
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect("login.jsp?msg=Profile can't be deleted due to some server issues");
			}

		} else if (req_type.contentEquals("changepassword")) {

			String email = req.getParameter("email");
			String currentPassword = req.getParameter("currentPassword");
			String newPassword = req.getParameter("newPassword");

			UserDAO dao = new UserDAO();
			try {
				boolean check = dao.changePassword(email, currentPassword, newPassword);
				if (check) {
					resp.sendRedirect("changepassword.jsp?msg=Password changed Successfully");
				} else {
					resp.sendRedirect("changepassword.jsp?msg=Your current password is wrong");
				}

			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect("changepassword.jsp?msg=Something went wrong");
			}

		}

	}

}
