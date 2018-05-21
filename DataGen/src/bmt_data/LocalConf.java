package bmt_data;

//import java.io.IOException;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;

import java.sql.Connection;
import java.sql.Driver;
//import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import java.io.File;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;

//import org.xml.sax.SAXException;

public class LocalConf {
	private String m_DBName;
	private String m_DBMS;
	private String m_Driver;
	private String m_DriverURL;
	private String m_URL;
	private String m_User;
	private String m_Pass;
	private String m_configFile = "./config.xml";
	
	LocalConf(String dbname) {
		m_DBName = dbname;
		m_DBMS = getConfig(dbname, "dbms");
		m_Driver = getConfig(dbname, "driver");
		m_DriverURL = getConfig(dbname, "driver_file");
		m_URL = getConfig(dbname, "url");
		m_User = getConfig(dbname, "user");
		m_Pass = getConfig(dbname, "pass");
	}
	public void  setConfigFile(String filename) { m_configFile = filename; }
	public String getDBName() { return m_DBName; };
	public String getDBMS()   { return m_DBMS; };
	public String getDriver() { return m_Driver; };
	public String getDriverURL() { return m_DriverURL; };
	public String getURL() { return m_URL; };
	public String getUser() { return m_User; };
	public String getPass() { return m_Pass; };
	
	
	public String getConfig(String dbname, String cfgName) {
		return getConfig(dbname, cfgName, m_configFile);
	}
	public static String getConfig(String dbname, String cfgName, String configFile) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		//String sReturnValue="";
		
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(configFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    XPathExpression expr 
		     = xpath.compile("//resource/database[name='"+ dbname +"']/" + cfgName + "/text()");
	
		    Object result = expr.evaluate(doc, XPathConstants.NODESET);
		    NodeList nodes = (NodeList) result;
		    if (nodes.getLength() > 0) {
		    //for (int i = 0; i < nodes.getLength(); i++) {
		        //System.out.println(nodes.item(i).getNodeValue());
		        return nodes.item(0).getNodeValue();
		    }
		}
		catch (Exception e) {
			System.err.println("ERROR:" + e.getMessage());
		}
	    return null;

	  }
	
	public Connection getConnection() {
		Connection conn = null;
		Driver driver = null;
		
		try {
			File file = new File(m_DriverURL);
			URI uri = file.toURI();
			URLClassLoader urlClassLoader = new URLClassLoader(new URL[] {uri.toURL()});
			Class<?> jdbcClass = urlClassLoader.loadClass(m_Driver);
			driver = (Driver) jdbcClass.getConstructor().newInstance();
			
			Properties props = new Properties();
			props.put("user",m_User);
			props.put("password", m_Pass);
			
			conn = driver.connect(m_URL, props);
		} catch (SQLException e) {
			System.err.println("ERROR:" + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;		
	}
	
	public static void main(String[] args) {
		LocalConf lc  = new LocalConf("default");
		Connection cn = lc.getConnection();
		System.out.println(cn.toString());
	}

}
