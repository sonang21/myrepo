package bts.utils.db;

import java.io.File;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.DriverPropertyInfo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Logger;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import bts.utils.db.Encryption;

@SuppressWarnings("unused")
public class DBConnection {
	
	public static enum DBMS_TYPE { ORACLE, MSSQL };
	private static Vector<String> _vsDriverList = new Vector<String>();
	
	private static String _sConfigFile;
	private String _sConnName = null;
	
	private String _sDBMS = null;
	private String _sDriver = null;
	private String _sDriverURL = null;
	private String _sURL = null;
	private String _sUser = null;
	private String _sPassword = null;
	
	private Connection _oConn = null;

	
	public DBConnection(String sConnectionName) {
		_sConfigFile = "./conf/DBConfig.xml";
		_sConnName = sConnectionName;
		setConnection(_sConnName);
	}
	
	public DBConnection(DBMS_TYPE dbType, String sURL, String sUser, String sPassword)
	{
		switch (dbType) {
		case ORACLE: _sDriver = "oracle.jdbc.driver.OracleDriver";
			break;
		case MSSQL: _sDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
			break;
		default: _sDriver = "";
			break;
		}
		_sURL = sURL;
		_sUser = sUser;
		_sPassword = sPassword;
	}

	public DBConnection(String sDriverClassName, String sDriverFileName, String sURL, String sUser, String sPassword)
	{
		_sDriver = sDriverClassName;
		_sDriverURL = sDriverFileName;
		_sURL = sURL;
		_sUser = sUser;
		_sPassword = sPassword;
	}
	
	
	public Connection getConnection() { return _oConn; }
	public String getConnectionName() { return _sConnName; }
	public void setConnectionName(String sConnectionName) { _sConnName = sConnectionName; }	
	
 
	private void loadDriver(String sDriverClassName, String sDriverFileName)
	{
		//System.out.println("loadDriver() start ....");
		if(_vsDriverList.contains(sDriverClassName)) {
			//System.out.println("loadDriver: [" + sDriverClassName + "] is already registered;");
			//DriverManager.drivers().forEach(s -> System.out.println("debug:" + s.toString()     ));
			return;
		}
		
		try {
			if(sDriverFileName == null || sDriverFileName.isEmpty()) {
				Class.forName(sDriverClassName);
				
			} else {
				//System.out.println("loadDriver().... frome file");
				File file = new File(sDriverFileName);
				URI uri = file.toURI();
				URLClassLoader clsLoader = new URLClassLoader(new URL[] {uri.toURL()});
				Class<?> jdbcClass = Class.forName(sDriverClassName, false, clsLoader);
				
				/**
				 *  deprecated java9
				 */
				//Class jdbcClass = loader.loadClass(sDriver);
				// Driver oDriver = (Driver) jdbcClass.newInstance();  // java 9 deprecated
				/**
				 * from java 9
				 */
				Driver oDriver = (Driver) jdbcClass.getConstructor().newInstance(); // from java9~
				DriverManager.registerDriver(new _Driver(oDriver));
			}
			
			_vsDriverList.addElement(sDriverClassName);
			//System.out.println("loadDriver()... ok");
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private void connect(String sURL, String sUser, String sPassword ) {
		try {
			if (_oConn != null) {
				if(! _oConn.isClosed()) _oConn.close();
				_oConn = null;
			}
			_oConn = DriverManager.getConnection(sURL, sUser, sPassword);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public Connection dbConnect() {
		loadDriver(_sDriver, _sDriverURL);
		connect(_sURL, _sUser, _sPassword);
		return _oConn;
	}
	
	public void setConnection(String sConnName) 
	{
		_sConnName = sConnName;
		_sDBMS 	= getConfig(sConnName, "dbms");
		_sDriver = getConfig(sConnName, "driver");
		_sDriverURL = getConfig(sConnName, "driver_file");
		_sURL = getConfig(sConnName, "url");
//		_sCheckQuery = getConfig(sConnName, "check_query");
		_sUser = getConfig(sConnName, "user");
		_sPassword = getConfig(sConnName, "pass");
		
		if (_sPassword == null) 
		{ 
			_sPassword = "";
		}
		else 
		{ 
			_sPassword = Encryption.decrypt(_sPassword);
		}
		
//		try {
//			m_nInitConnections = Integer.parseInt(getConfig(sConnName, "initConn"));
//			m_nMaxConnections = Integer.parseInt(getConfig(sConnName, "maxConn"));
//			m_nWaitSeconds = Integer.parseInt(getConfig(sConnName, "waitSec"));
//		}
//		catch (Exception e) 
//		{
//			m_logFile.logWrite("Connection : " + sConnName);
//			m_logFile.logWrite(e);
//			System.err.println("\nERROR: Connection fail : " + sConnName);
//			e.printStackTrace();
//			System.exit(1);
//		}
	}

	private static String getConfig(String sConnName, String sConfigName) {
		//return getConfig(sConnName, sConfigName, m_sConfigFile);
		return getXmlNodeValue("/configurations/connections/database[name='"+ sConnName +"']/" + sConfigName);
	}

	public static String getXmlNodeValue(String sNodePath) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(_sConfigFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    XPathExpression expr = xpath.compile(sNodePath + "/text()");
	
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
	
	
	
	public static void main(String args[]) {
		unitTest0001();
	}
	
	private static void unitTest0001() {
//		String sDriver = "oracle.jdbc.driver.OracleDriver";
//		String sDriverFile = ""; 
//		String sDriverFile = "C:\\2.MyDev\\workspace\\lib\\ojdbc6.jar";
//		String sURL = "jdbc:oracle:thin:@1.1.1.1:1521:ORCL";
		
		try {
//			Connection oConn = (new DBConnection(sDriver, sDriverFile, sURL, "dbenuri", "dbenuri#2018t")).dbConnect();
			Connection oConn = (new DBConnection("ENURI_TEST")).dbConnect();
//			Connection oConn2 = (new DBConnection(sDriver, sDriverFile, sURL, "dbadm", "dba1020")).dbConnect();
			Connection oConn2 = (new DBConnection("MPDB_TEST")).dbConnect();
			Statement oStmt = oConn.createStatement();
			ResultSet oRs = oStmt.executeQuery("select * from tab");
			while (oRs.next()) {
				System.out.println(oRs.getString(1));
			}
			
			oRs.close();
			oStmt.close();			
			oConn.close();	
			oConn2.close();
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}
	
	public static void test(String sTest) {
		System.out.println(String.valueOf(sTest==null || sTest.isEmpty()));
		System.out.println(sTest.isEmpty());
	}

}

class _Driver implements Driver
{
	private Driver _driver;
	//private String _sDriverName;
	
	_Driver(Driver driver) { 
		_driver = driver; 
		//_sDriverName = driver.getClass().getName();
	}
		
	@Override
	public String toString() { return "Custome _Driver : " + _driver.toString(); }
	
	@Override
	public boolean acceptsURL(String sURL) throws SQLException {return _driver.acceptsURL(sURL);}
	@Override
	public Connection connect(String sURL, Properties oProp) throws SQLException { return this._driver.connect(sURL, oProp);}
	@Override
	public int getMajorVersion() {return this._driver.getMajorVersion();}
	@Override
	public int getMinorVersion() {return this._driver.getMinorVersion();}
	@Override
	public DriverPropertyInfo[] getPropertyInfo(String sURL, Properties oProps)	throws SQLException {
		return this._driver.getPropertyInfo(sURL, oProps);
	}
	@Override
	public boolean jdbcCompliant() {return this._driver.jdbcCompliant();}
	@Override
	public Logger getParentLogger() throws SQLFeatureNotSupportedException {return this._driver.getParentLogger();}
}