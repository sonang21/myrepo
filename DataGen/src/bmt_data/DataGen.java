package bmt_data;

/*
 * SET CLASSPATH=E:\03.Data\Eclipse\Common\ojdbc6.jar;bmt_data;.
 * java bmt_data\DataGen create/insert TableName
 */

import java.sql.*;
//import java.util.Calendar;

public class DataGen {

	public static void main(String[] args) {
		boolean isTest = false;
		if(isTest) {
			test();
			return;
		} 
		if (args.length < 2) {
			System.out.println("USAGE: java -cp bin bmt_data.DataGen TableName create/insert [target_name]");
		}
		String table_name = args[0];
		String target_name = "default";
		if (args.length == 3) {
			target_name = args[2];
		}
		String xmlFile = ".\\xml\\tb_"+table_name+".xml";

		System.out.println(xmlFile);
		
		if (args[1].equalsIgnoreCase("create")) {
			TableColumns.genTableXml(table_name, xmlFile, target_name);
		} else if (args[1].equalsIgnoreCase("insert")){
			insertDB(xmlFile, target_name);
		} else {
			System.out.println("USAGE: java -cp bin bmt_data.DataGen TableName create/insert [target_name] ");
		}
		
	}
	public static void test() {
		/*
		String table_name = "재고번호제원";
		String xmlFile = "E:\\03.Data\\Eclipse\\bmt_data\\bin\\xml\\tb_"+table_name+".xml";
		insertDB(xmlFile);
		*/
	}
	
	public static void insertDB(String filename, String target_name) {
		TableColumns tc  = new TableColumns(filename);
		
		LocalConf dbcfg = new LocalConf(target_name);
		//String driver = dbcfg.getDriver();
		//String url = dbcfg.getURL();
		//String user = dbcfg.getUser();
		//String pass = dbcfg.getPass();

		try {
			//Class.forName(driver);
			//Connection conn = DriverManager.getConnection(url, user,pass);
			Connection conn = dbcfg.getConnection();

			tc.insertDB(conn);
			
			conn.close();
		//} 
		//catch(ClassNotFoundException e) {
		//	System.err.println("[ERROR] run:ClassNotFoundException: " + e.getMessage());
		}
		catch(SQLException e){
			System.err.println("[ERROR] run:SQLException " + e.getMessage());
			
		}
		finally {
		
		}
		
	}

	public static void test1() {
		String [] list = {"A","B","C","E","FFF"};
		DataColumn col = new DataColumn("TEST", DataColumn.DATA_TYPE.STRING, list , true);
		col.setFormat("AF...%d");
		for (int i=0; i < 200; i++) {
			col.nextValue();
			System.out.println(col.getString());
		}
	}
	public static void test2() {
		TableColumns tc = new TableColumns("src\\기본제원.xml");
		tc.printSpec();
		while(tc.nextValue()) {
			tc.printValues();
		}
	}
	
	
	
}


