

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
//import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

//import java.time.LocalDate;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;


public class DBObjectBackup {
	private static String _backupRootPath="";
	private static String _sBackupDateTime="";
	
	public static void main(String args[]) {
		if(args.length > 0) {
			System.out.println(args[0]);
			_backupRootPath = args[0];
		} else {
			_backupRootPath = new File("").getAbsolutePath();
		}
		
		// from jdk 8
		//_backupRootPath = _backupRootPath + File.separator + DateTimeFormatter.ofPattern("yyyyMMdd_HHmm").format(LocalDateTime.now());
		//sBackupTime = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(LocalDateTime.now());
		_backupRootPath = _backupRootPath + File.separator + (new SimpleDateFormat("yyyyMMdd_HHmm")).format(new Date());
		_sBackupDateTime = (new SimpleDateFormat("yyyyMMdd_HHmm")).format(new Date());
		
		mssqlDBSourceBackupAll();
		oracleDBSourceBackup(null); // null for all db
	}
	
	public static void mssqlDBSourceBackupAll() {
		System.out.println("mssqlDBSourceBackupAll() ..... Start");
		try {
			//InputStream  input = new FileInputStream("conf/DBConfig.ini");
			InputStream input = DBObjectBackup.class.getResourceAsStream("DBConfig.ini");
			Properties prop = new Properties();
			prop.load(input);
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String sConn = prop.getProperty("MPDB_TEST"); //"jdbc:sqlserver://1.1.1.1:1433;instanceName=inst;databaseName=db;user=user;password=pass;";
			Connection oConn = DriverManager.getConnection(sConn, "dbadm","dba1020");
			Statement oStmt = oConn.createStatement();
			ResultSet oRs = oStmt.executeQuery("select name from master.sys.databases where database_id > 6 order by name");
			while(oRs.next()) {
				mssqlDBSourceBackup(oRs.getString(1));
			}
			oRs.close();
			oStmt.close();
			oConn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println("mssqlDBSourceBackupAll() ..... Complete!");
	}
	
	public static void mssqlDBSourceBackup(String sDBName) {
		System.out.println("mssqlDBSourceBackup(" + sDBName + ")... Start");
		
		String sPath = _backupRootPath + File.separator + "MSSQL";
		//String sPath = "backDbSrc";
		String sFileName;
		
		File file = new File(sPath);
		if(!file.exists()) {
			System.out.println(file.mkdirs());
			System.out.println("Directory Created : " + sPath);
		}
		
		
		try {
			InputStream input = DBObjectBackup.class.getResourceAsStream("DBConfig.ini");
			Properties prop = new Properties();
			prop.load(input);
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String sConn = prop.getProperty("MPDB_TEST"); //"jdbc:sqlserver://1.1.1.1:1433;instanceName=ins;databaseName=DB;user=user;password=pass;";
			Connection oConn = DriverManager.getConnection(sConn, "dbadm","dba1020");
			
			
			Statement oStmt = oConn.createStatement();
			
			oConn.setCatalog(sDBName);
			String sSQL = "SELECT DB_NAME()  DB_NAME \r\n" + 
					      "     , CASE WHEN A.TYPE IN ('FN','FS','FT','IF','TF') THEN 'FUNCTION' \r\n" + 
					      "            WHEN A.TYPE = 'P'  THEN 'PROCEDURE' \r\n" + 
					      "            WHEN A.TYPE = 'TR' THEN 'TRIGGER' \r\n" + 
					      "            WHEN A.TYPE = 'V'  THEN 'VIEW' \r\n" + 
					      "            ELSE A.TYPE \r\n" + 
					      "       END  AS TYPE2 \r\n" + 
					      "     , C.NAME     SCHEMA_NAME \r\n" + 
					      "     , A.NAME     SOURCE_NAME \r\n" + 
					      "     , B.DEFINITION \r\n" + 
					      "     , A.TYPE     SOURCE_TYPE \r\n" + 
					      "     , A.TYPE_DESC \r\n" + 
					      "     , A.CREATE_DATE, A.MODIFY_DATE \r\n" +
					      "FROM SYS.OBJECTS A \r\n" + 
					      "     INNER JOIN SYS.SQL_MODULES B ON (B.OBJECT_ID = A.OBJECT_ID) \r\n" + 
					      "     INNER JOIN SYS.SCHEMAS     C ON (C.SCHEMA_ID = A.SCHEMA_ID) \r\n" + 
					      "WHERE A.TYPE IN ('FN','FS','FT','IF','TF','P','TR','V','U') \r\n" + 
					      "  AND A.IS_MS_SHIPPED = 0 \r\n" + 
					      "ORDER BY TYPE2, SCHEMA_NAME, SOURCE_NAME";
			ResultSet oRs = oStmt.executeQuery(sSQL);
			while(oRs.next()) {
				sFileName = sPath + File.separator + oRs.getString(1) + "_" + oRs.getString(2) + "_" + oRs.getString(3) + "." + oRs.getString(4) + ".sql";
				System.out.println("  ... " + sFileName);
				BufferedWriter writer = new BufferedWriter(new FileWriter(sFileName));
				
				writer.write("/* *************************************************************************\r\n");
				writer.write(" * NAME : " + oRs.getString(3) + "." + oRs.getString(4) + "\r\n");
				writer.write(" * TYPE : " + oRs.getString(2) + " (" + oRs.getString(7) + ")\r\n");
				writer.write(" * TIME : Create: " + oRs.getString(8) + "\r\n");
				writer.write(" *        Modify: " + oRs.getString(9) + "\r\n");
				writer.write(" *        Backup: " + _sBackupDateTime + "\r\n");
				writer.write(" ************************************************************************* */\r\n\r\n");
				writer.write(oRs.getString(5));
				writer.close();
			}
			oRs.close();
			oStmt.close();
			oConn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println("mssqlDBSourceBackup(" + sDBName + ")... End");
		
	}
	
	public static void oracleDBSourceBackup(String sDBName) {
		System.out.println("oracleDBSourceBackup(" + sDBName + ")... Start");
		
		String sPath = _backupRootPath + File.separator + "ORACLE";
		String sFileName;
		
		File file = new File(sPath);
		if(!file.exists()) {
			System.out.println(file.mkdirs());
			System.out.println("Directory Created : " + sPath);
		}
		
		
		try {
			InputStream input = DBObjectBackup.class.getResourceAsStream("DBConfig.ini");
			Properties prop = new Properties();
			prop.load(input);
			
			Class.forName("oracle.jdbc.OracleDriver");
			String sConn = prop.getProperty("ENURI_TEST"); //"jdbc:oracle:thin:@//1.1.1.1:1521/sid";
			Connection oConn = DriverManager.getConnection(sConn, "dbadm", "dba1020");
			
			
			Statement oStmt = oConn.createStatement();
			
			//oConn.setCatalog(sDBName);
			String sSQL = 
					"SELECT OWNER, OBJECT_TYPE , OBJECT_NAME, CREATED, LAST_DDL_TIME \r\n" + 
					"     , DBMS_METADATA.GET_DDL(OBJECT_TYPE=>REPLACE(A.OBJECT_TYPE, ' ', '_'), NAME=>A.OBJECT_NAME, SCHEMA=>A.OWNER) DDL \r\n" + 
					"  FROM DBA_OBJECTS A \r\n" + 
					" WHERE 1 = 1 \r\n" +
					((sDBName == null || sDBName.isEmpty()) ? 
				    "   AND A.OWNER IN (SELECT USERNAME FROM DBA_USERS WHERE USER_ID > 83) \r\n"
					: " and A.OWNER = '" + sDBName + "' \r\n" ) +
					"   --AND A.OWNER = 'DBADM' \r\n" +
					"   AND A.OBJECT_TYPE IN ('PACKAGE','PROCEDURE','FUNCTION', 'TRIGGER','VIEW', 'MATERIALIZED VIEW') \r\n" + 
					"   --AND A.OBJECT_TYPE IN ('TABLE','INDEX','SEQUENCE','PACKAGE','PROCEDURE','FUNCTION', 'TRIGGER','VIEW', 'MATERIALIZED VIEW') \r\n" + 
					" ORDER BY A.OWNER, A.OBJECT_TYPE, A.OBJECT_NAME";
			
			ResultSet oRs = oStmt.executeQuery(sSQL);
			while(oRs.next()) {
				sFileName = sPath + File.separator + oRs.getString(1) + "_" + oRs.getString(2) + "_" + oRs.getString(3) + ".sql";
				System.out.println("  ... " + sFileName);
				BufferedWriter writer = new BufferedWriter(new FileWriter(sFileName));
				
				writer.write("/* *************************************************************************\r\n");
				writer.write(" * NAME : " + oRs.getString(1) + "." + oRs.getString(3) + "\r\n");
				writer.write(" * TYPE : " + oRs.getString(2) + "\r\n");
				writer.write(" * TIME : Create: " + oRs.getString(4) + "\r\n");
				writer.write(" *        Modify: " + oRs.getString(5) + "\r\n");
				writer.write(" *        Backup: " + _sBackupDateTime + "\r\n");
				writer.write(" ************************************************************************* */\r\n\r\n");
				writer.write(oRs.getString(6));
				writer.close();
			}
			oRs.close();
			oStmt.close();
			oConn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println("oracleDBSourceBackup(" + sDBName + ")... End");
		
	}
	

}
