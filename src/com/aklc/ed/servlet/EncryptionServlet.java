package com.aklc.ed.servlet;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aklc.ed.crypto.AES;
import com.aklc.ed.dao.EncryptionHistoryDAO;
import com.aklc.ed.dao.UserDAO;
import com.aklc.ed.model.EncryptionHistory;
import com.aklc.ed.model.User;
import com.aklc.ed.notification.SendSMS;
import com.oreilly.servlet.MultipartRequest;

public class EncryptionServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String req_type = req.getParameter("req_type");
		UserDAO uDao = new UserDAO();
		EncryptionHistoryDAO ehDao = new EncryptionHistoryDAO();
		User uModel = (User) req.getSession().getAttribute("model");
		if (req_type.equals("plaintext")) {
			try {
				// Step 1: Read the plain text
				String plainText = req.getParameter("text");

				// Step 2: Perform the encryption
				String secret = uDao.getPassword(uModel.getEmail());
				String cipher = AES.encrypt(plainText, secret);

				// Step 3: Write the entry to the table
				EncryptionHistory eModel = new EncryptionHistory();
				eModel.setEmail(uModel.getEmail());
				eModel.setEncryption_type("PLAIN TEXT");
				eModel.setEntry_time(new Timestamp(System.currentTimeMillis()));
				ehDao.write(eModel);
				
				SendSMS.trigger(uModel.getMobile(), "Encryption on simple text Successful in ED Portal");


				// Step 4: Return the encrypted data
				resp.sendRedirect("encryption.jsp?cipher=" + cipher);
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect("encryption.jsp?msg=Something went wrong while performing encryption operation");
			}
		} else if (req_type.equals("textfile")) {

			try {

				MultipartRequest m = new MultipartRequest(req, "C:/upload");
				File folder = new File("C:/upload");
				File[] files = folder.listFiles();

				File f1 = files[0];
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(f1)));

				File f2 = new File("C:/result/" + f1.getName());
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f2)));

				String curLine = "";
				User model = (User) req.getSession().getAttribute("model");
				String secret = uDao.getPassword(model.getEmail());
				while ((curLine = br.readLine()) != null) {
					String decryptedLine = AES.encrypt(curLine, secret);
					bw.write(decryptedLine);
					bw.newLine();
				}

				br.close();
				bw.close();

				f1.delete();

				EncryptionHistory ehModel = new EncryptionHistory();
				ehModel.setEmail(model.getEmail());
				ehModel.setEncryption_type("TEXT FILE");
				ehModel.setEntry_time(new Timestamp(System.currentTimeMillis()));

				ehDao.write(ehModel);

				SendSMS.trigger(uModel.getMobile(), "Encryption on text file Successful in ED Portal");
				
				resp.setContentType("text/html");
				PrintWriter out = resp.getWriter();
				String filename = f2.getName();
				String filepath = "C:/result/";
				resp.setContentType("APPLICATION/OCTET-STREAM");
				resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

				FileInputStream fileInputStream = new FileInputStream(filepath + filename);

				int i;
				while ((i = fileInputStream.read()) != -1) {
					out.write(i);
				}
				fileInputStream.close();
				out.close();


			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect(
						"encryption.jsp?msg=Something went wrong while encrypting the file: " + e.getMessage());
			}
		}

	}

}
