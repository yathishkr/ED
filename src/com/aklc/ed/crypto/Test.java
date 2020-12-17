package com.aklc.ed.crypto;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class Test {

	public static void main(String[] args) throws Exception {

		// READ
		File f1 = new File("C:/result/2.txt");
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(f1)));
		
		File f2 = new File("C:/result/3.txt");
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f2)));

		
		String curLine = "";
		while ((curLine = br.readLine()) != null) {
			String decryptedLine = AES.decrypt(curLine, "1234");
			bw.write(decryptedLine);
			bw.newLine();
		}

		br.close();
		bw.close();
		System.out.println("DONE");

	}

}
