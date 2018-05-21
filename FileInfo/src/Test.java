import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
/*
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.Properties;
*/
public class Test {
	int m_tabCounter = 0;
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date = new Date();

	public void listFilesAndFolders(String folder) {
		File dir = new File(folder);
		
		if(!dir.exists() || !dir.isDirectory()) {
			System.out.println("Parameter is not a diretory");
			System.exit(1);
		}
		File[] files = dir.listFiles();
		if (files == null) {
			System.out.println("*** Can't read this Directory!!!");
			return;
		}
		try {
			for (int i=0; i < files.length; i++) {
				if(files[i].isDirectory()) {
					System.out.println(getTabs() + "- " + files[i].getName() + ": " + files[i].canRead());
					m_tabCounter ++;
					listFilesAndFolders(files[i].getAbsolutePath());
				}
				else {
					
					//System.out.println(getTabs() + files[i].getName()+":"+files[i].length()+":"+getDateString(files[i].lastModified()));
					System.out.println( files[i].getAbsolutePath() + ":" +files[i].length()+":"+getDateString(files[i].lastModified()));
				}
			}
			m_tabCounter--;
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	private String getTabs() {
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i< m_tabCounter; i++)
			buffer.append("\t");
		return buffer.toString();
	}
	
	public void listDrives() {
		File[] drives = File.listRoots();
		for (int i=0; i < drives.length ; i++) {
			System.out.println(drives[i]);
		}
	}
	
	private String getDateString(long date) {
		return dateFormat.format(date);
	}
	
	public static void main(String[] args) {
		Test test = new Test();
		test.listDrives();
		test.listFilesAndFolders("E:\\Temp");
	}
}
