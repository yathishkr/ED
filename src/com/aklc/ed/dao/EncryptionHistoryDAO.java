package com.aklc.ed.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aklc.ed.model.EncryptionHistory;
import com.aklc.ed.util.DBConnection;

public class EncryptionHistoryDAO {

	public void write(EncryptionHistory model) throws Exception {
		Connection con = null;
		try {
			con = DBConnection.connect();
			Statement st = con.createStatement();
			st.execute("insert into encryptionhistory values ('" + model.getEmail() + "', '"
					+ model.getEncryption_type() + "', '" + model.getEntry_time() + "') ");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
	}

	public List<EncryptionHistory> read(String email) throws Exception {
		Connection con = null;
		List<EncryptionHistory> result = new ArrayList<EncryptionHistory>();
		try
		{	
			con = DBConnection.connect();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from encryptionhistory where email='"+email+"' ");
			while (rs.next())
			{
				EncryptionHistory model = new EncryptionHistory();
				model.setEmail(rs.getString("email"));
				model.setEncryption_type(rs.getString("encryption_type"));
				model.setEntry_time(rs.getTimestamp("entry_time"));
				result.add(model);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		finally
		{
			con.close();
		}
		return result;
	}

}






