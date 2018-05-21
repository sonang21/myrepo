

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.ResultSet;
//import java.sql.SQLException;
import java.sql.Statement;

//import java.util.ArrayList;
import java.util.Properties;

public class DerbyInf {
    private String m_driver = "org.apache.derby.jdbc.EmbeddedDriver";
    private String m_protocol = "jdbc:derby:";
    
    private Connection m_conn = null;
    
    public static void main(String[] args)
    {
    	DerbyInf db = new DerbyInf();
    	System.out.println("start...");
    	db.connect();
    	System.out.println("connect ok");
    	
    	db.init();
    	System.out.println("init ok");
    	db.close();
    	System.out.println("close ok");
    	//new SimpleApp().go(args);
        //System.out.println("SimpleApp finished");
    }
    
    public Statement getStatement() {
    	Statement stmt = null;
    	if (isConnect()) {
    		try {
    			stmt = m_conn.createStatement();
    		} catch (Exception e) {
    			System.err.println(e.getMessage());
    		}
    	}
    	return stmt;
    }
    
    public PreparedStatement getPreparedStatement(String sql) {
    	PreparedStatement pstmt = null;
    	if (isConnect()) {
    		try {
    			pstmt = m_conn.prepareStatement(sql);
    		} catch (Exception e) {
    			System.err.println(e.getMessage());
    		}
    	}
    	return pstmt;
    }
    
    
    private void loadDriver() {
        try {
            Class.forName(m_driver).newInstance();
            System.out.print("\nLoaded the Derby driver");
        } catch (ClassNotFoundException cnfe) {
            System.err.print("\nUnable to load the JDBC driver " + m_driver);
            System.err.print("\nPlease check your CLASSPATH.");
            cnfe.printStackTrace(System.err);
        } catch (InstantiationException ie) {
            System.err.print(
                        "\nUnable to instantiate the JDBC driver " + m_driver);
            ie.printStackTrace(System.err);
        } catch (IllegalAccessException iae) {
            System.err.print(
                        "\nNot allowed to access the JDBC driver " + m_driver);
            iae.printStackTrace(System.err);
        }
    }
    
    public boolean connect() {
    	boolean rval = true;
        Properties props = new Properties(); // connection properties
        props.put("user", "dba");
        props.put("password", "dba");

      
        //String dbName = "derbyDB"; // the name of the database
        String dbName = "filedb"; // the name of the database
        loadDriver();
        System.out.println("\nDriver is loaded.");
        try {
        	m_conn = DriverManager.getConnection(m_protocol + dbName + ";create=true", props);
            System.out.println("\nConnected to and created database " + dbName);
        } catch (Exception e) {
        	System.err.println(e.getMessage());
        	rval = false;
        }
        return rval;
    }
    
    public boolean close() {
    	boolean reval = true;
    	try {
    		if (isConnect()) m_conn.close();
    		System.out.println("\nConnection closed.");
    	} catch (Exception e) {
    		System.err.println(e.getMessage());
    		reval = false;
    	}
    	return reval;
    }
    
    public boolean isConnect() {
    	if (m_conn == null) {
    		return false;
    	} else {
    		return true;
    	}
    }
    
    public void init() {
    	if (! isConnect()) {
    		if(! connect()) return;
    	}
    	String obj_name = "";
    	try {
	    	Statement stmt = m_conn.createStatement();
	    	StringBuffer sb = new StringBuffer();
	    	ResultSet rs;
	    	obj_name = "FN_SIMILAR";
	    	rs = stmt.executeQuery("select 1 from sys.sysaliases where alias = '"+obj_name+"'");
	    	if (rs.next()) {
	    		System.out.println("Droping function " + obj_name);
	    		stmt.execute("drop function " + obj_name);
	    		rs.close();
	    		System.out.println("Function " + obj_name + " is droped.");
	    	}
	    	System.out.println("Creating funtion " + obj_name);
    		sb.append("create function " + obj_name + "(p1 varchar(1000), p2 varchar(1000), p3 integer) ");
    		sb.append("returns integer                                           ");
    		sb.append("  parameter style java no sql language java                    ");
    		sb.append("  external name 'DerbyFunction.similar'                        ");
    	    stmt.execute(sb.toString());
	        sb.delete(0, sb.length());
	    	System.out.println("Funtion " + obj_name + " is created.");
		    //-------------------------
	    	obj_name = "FN_SIMILAR2";
	    	rs = stmt.executeQuery("select 1 from sys.sysaliases where alias = '"+obj_name+"'");
	    	if (rs.next()) {
	    		System.out.println("Droping function " + obj_name);
	    		stmt.execute("drop function " + obj_name);
	    		rs.close();
	    		System.out.println("Function " + obj_name + " is droped.");
	    	}
	    	System.out.println("Creating funtion " + obj_name);
    		sb.append("create function " + obj_name + "(p1 varchar(1000), p2 varchar(1000), p3 integer) ");
    		sb.append("returns varchar(100)                                           ");
    		sb.append("  parameter style java no sql language java                    ");
    		sb.append("  external name 'DerbyFunction.similar2'                        ");
    	    stmt.execute(sb.toString());
	        sb.delete(0, sb.length());
	    	System.out.println("Funtion " + obj_name + " is created.");
	    	//--------------------------------
	    	
	    	System.out.println("\nDatabase initial objects are created!!");
	    	stmt.close();
    	}
    	catch (Exception e) {
    		System.err.println(e.getMessage());
    	}
    }
    
    public void createTable(String tableName) {
    	if (! isConnect()) {
    		if(! connect()) return;
    	}
    	try {
	    	Statement stmt = m_conn.createStatement();
	    	StringBuffer sql = new StringBuffer();
	    	/*
	    	sql.append(" create table tb_file_saved (                       ");
	    	sql.append("   id bigint                                       ");
	    	sql.append(" , name varchar(200)                                ");
	    	sql.append(" , path varchar(1000)                               ");
	    	sql.append(" , size bigint                                     ");
	    	sql.append(" , mdate date                                       ");
	    	sql.append(" , sid bigint                                      ");
	    	sql.append(" , sname varchar(200)                               ");
	    	sql.append(" , spath varchar(1000)                              ");
	    	sql.append(" , ssys  varchar(100)                               ");
	    	sql.append(" , constraint pk_file_saved primary key(name, path))");
	    	stmt.execute(sql.toString());
            sql.delete(0, sql.length());
	    	*/
	    	
	    	sql.append(" create table " + tableName + " (          ");
	    	sql.append("   id bigint                               ");
	    	sql.append(" , name varchar(200)                       ");
	    	sql.append(" , path varchar(1000)                      ");
	    	sql.append(" , pname varchar(200)                     ");
	    	sql.append(" , size bigint                             ");
	    	sql.append(" , mdate date                              ");
	    	sql.append(" , constraint pk_" + tableName + " primary key(name, path))");
	    	stmt.execute(sql.toString());

	    	System.out.println("\nTable "+ tableName + " is created!!");
	    	stmt.close();
    	}
    	catch (Exception e) {
    		System.err.println(e.getMessage());
    	}
    }
    public void dropTable(String tableName) {
    	if (! isConnect()) {
    		if(! connect()) return;
    	}
    	try {
	    	Statement stmt = m_conn.createStatement();
	    	stmt.execute("drop table " + tableName);

	    	System.out.println("\nTable "+ tableName + " is droped!!");
	    	stmt.close();
    	}
    	catch (Exception e) {
    		System.err.println(e.getMessage());
    	}
    }
    
}
