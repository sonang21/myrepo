package com.cslee.db.dbpool;

import java.sql.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.cslee.utils.*;

public class DBConnectionManager {
	private static String m_sConfigFile = "./conf/config.xml";
	private LogFile m_logFile;
	
	private DBConnectionPoolManager m_dbConnPoolMgr;
	private int m_nInitConnections, m_nMaxConnections, m_nWaitSeconds;
	
	
	
	private String m_sConnName = null;
	private String m_sDBMS = null;
	private String m_sDriver = null;
	private String m_sDriverURL = null;
	private String m_sURL = null;
	private String m_sCheckQuery = null;
	private String m_sUser = null;
	private String m_sPassword = null;
	
	
	public DBConnectionManager(String sConnName)
	{
		this.m_logFile = LogFileManager.getInstance().getLogFile();
		
		setProperties(sConnName);
		this.m_dbConnPoolMgr = DBConnectionPoolManager.getInstance();
		
		//this.m_dbConnPoolMgr.initialize(m_sConnName, m_sDriver, m_sURL, m_sUser, m_sPassword, m_nInitConnections, m_nMaxConnections, m_nWaitSeconds);
		this.m_dbConnPoolMgr.initialize(m_sConnName, m_sDriver, m_sDriverURL, m_sURL, m_sUser, m_sPassword, m_nInitConnections, m_nMaxConnections, m_nWaitSeconds);
	}
	
	public Connection getConnection()
	{
		return (m_dbConnPoolMgr.getConnection(m_sConnName));
	}
	
	public String getName()
	{
		return m_sConnName;
	}
	
	public void freeConnection(Connection oConn)
	{
		m_dbConnPoolMgr.freeConnection(m_sConnName, oConn);
	}
	
	public void closeConnection(Connection oConn)
	{
		m_dbConnPoolMgr.closeConnection(m_sConnName, oConn);
	}
	
	public int getDriverNumber()
	{
		return m_dbConnPoolMgr.getDriverCount();
	}
	
	public void setProperties(String sConnName) 
	{
		m_sConnName = sConnName;
		m_sDBMS 	= getConfig(sConnName, "dbms");
		m_sDriver = getConfig(sConnName, "driver");
		m_sDriverURL = getConfig(sConnName, "driver_file");
		m_sURL = getConfig(sConnName, "url");
		m_sCheckQuery = getConfig(sConnName, "check_query");
		m_sUser = getConfig(sConnName, "user");
		m_sPassword = getConfig(sConnName, "pass");
		
		if (m_sPassword == null) 
		{ 
			m_sPassword = "";
		}
		else 
		{ 
			m_sPassword = Encryption.decrypt(m_sPassword);
		}
		
		try {
			m_nInitConnections = Integer.parseInt(getConfig(sConnName, "initConn"));
			m_nMaxConnections = Integer.parseInt(getConfig(sConnName, "maxConn"));
			m_nWaitSeconds = Integer.parseInt(getConfig(sConnName, "waitSec"));
		}
		catch (Exception e) 
		{
			m_logFile.logWrite("Connection : " + sConnName);
			m_logFile.logWrite(e);
			System.err.println("\nERROR: Connection fail : " + sConnName);
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	private  String getConfig(String sConnName, String sConfigName) {
		//return getConfig(sConnName, sConfigName, m_sConfigFile);
		return getXmlNodeValue("/configurations/connections/database[name='"+ sConnName +"']/" + sConfigName, m_sConfigFile);
	}
	
	private static String getXmlNodeValue(String sNodePath, String sConfigFile) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(sConfigFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    XPathExpression expr 
		     = xpath.compile(sNodePath + "/text()");
	
		    Object result = expr.evaluate(doc, XPathConstants.NODESET);
		    NodeList nodes = (NodeList) result;
		    if (nodes.getLength() > 0) {
		    //for (int i = 0; i < nodes.getLength(); i++) {
		        //System.out.println(nodes.item(i).getNodeValue());
		        //System.out.println("debug:"+ connName + ","+ cfgName + "=" + nodes.item(0).getNodeValue());
		    	return nodes.item(0).getNodeValue();
		    }
		}
		catch (Exception e) {
			System.err.println("ERROR:" + e.getMessage());
		}
     //System.out.println("debug:"+ connName + ","+ cfgName + "= NULL");
	    return null;

	}
	
	public boolean checkConnection() {
		if (this.m_sCheckQuery == null || this.m_sCheckQuery.isEmpty()) return false;
		
		boolean bResult = false;
		Connection oConn = null;
		Statement oStmt = null;
		ResultSet oRs;
		try 
		{
			oConn = this.getConnection();
			oStmt = oConn.createStatement();
			oRs = oStmt.executeQuery(this.m_sCheckQuery);
			oRs.close();
			bResult = true;
		}
		catch(Exception e)
		{
			bResult = false;
			m_logFile.debugWrite(e);
		}
		return bResult;
	}
	
	public String toString() {
		String strOut = "DBConfig Class : \n"
				      + "\t m_sConfigFile = " + m_sConfigFile + "\n"
				      + "\t m_ConnNmae   = " + this.m_sConnName  + "\n" 
	                  + "\t m_sDBMS       = " + this.m_sDBMS      + "\n"
	                  + "\t m_sDriver     = " + this.m_sDriver    + "\n"
	                  + "\t m_sDriverURL  = " + this.m_sDriverURL + "\n"
	                  + "\t m_sURL        = " + this.m_sURL       + "\n"
	                  + "\t m_sUser       = " + this.m_sUser      + "\n";
//	                  + "\t m_sPass       = " + this.m_sPass      + "\n";
		return strOut;
	}
}
