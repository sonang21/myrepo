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
	
	public static enum DBMS_TYPE { ORACLE, MSSQL, DB2, MYSQL, HIVE, OTHER };
	private static Vector<String> _vsDriverList = new Vector<String>();
	
	private static String _sConfigFile = "./conf/DBConfig.xml";
	private String _sConnName = null;
	private String _sDBMS = null;
	private String _sDriver = null;
	private String _sDriverURL = null;
	private String _sURL = null;
	private String _sUser = null;
	private String _sPassword = null;
	
	private Connection _oConn = null;
	private DBMS_TYPE _dbType;

	
	public DBConnection(String sConnectionName) {
		setConnectionConfig(sConnectionName);
//		System.out.println("Constructor: " + toString());
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
		_dbType = dbType;
	}
	
//	public DBConnection(String sDriverClassName, String sDriverFileName, String sURL, String sUser, String sPassword)
//	{
//		_sDriver = sDriverClassName;
//		_sDriverURL = sDriverFileName;
//		_sURL = sURL;
//		_sUser = sUser;
//		_sPassword = sPassword;
//	}
	
	
	public String getConnectionName() { return _sConnName; }
	public Connection getConnection() { return _oConn; }
	public void setConnectionName(String sConnectionName) { _sConnName = sConnectionName; }
	
	@Override
	public String toString() {
		return String.format("DBConnection: name=%s, dbms=%s, driver=%s, driverURL=%s, URL=%s, user=%s"
				, _sConnName, _sDBMS, _sDriver, _sDriverURL, _sURL, _sUser);
	}
	
 
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
			System.err.println("DBConnection.connect():" + this.toString() + "/" + sPassword);
			ex.printStackTrace();
		}
	}

	public Connection dbConnect() {
		if(_oConn != null) {
			dbClose();
		}
		loadDriver(_sDriver, _sDriverURL);
		connect(_sURL, _sUser, _sPassword);
		return _oConn;
	}
	
	public void dbClose() {
		if(_oConn != null ) {
			try {
				if(! _oConn.isClosed()) _oConn.close();
				_oConn = null;
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	
	public void setConnectionConfig(String sConnName) 
	{
		_sConnName = sConnName;
		_sDBMS 	= getConfigOf(sConnName, "dbms");
		try {
			_dbType = DBMS_TYPE.valueOf(_sDBMS);
		}
		catch ( Exception ex) {
			_dbType = DBMS_TYPE.OTHER;
		}
		
		_sDriver = getConfigOf(sConnName, "driver");
		_sDriverURL = getConfigOf(sConnName, "driver_file");
		_sURL = getConfigOf(sConnName, "url");
		_sUser = getConfigOf(sConnName, "user");
		_sPassword = getConfigOf(sConnName, "pass");
		
		if (_sPassword == null) 
		{ 
			_sPassword = "";
		}
		else 
		{ 
			_sPassword = Encryption.decrypt(_sPassword);
		}
	}

	/**
	 * configuration/connections/database에서 element name이 일치하는 노드를 찾아 해당 노드의 지정된 요소(sConfigName)의 값을 반환
	 * <database><name>dbname</name>... 형태로 지정된 요소
	 * @param sConnName
	 * @param sConfigName
	 * @return
	 */
	private static String getConfig(String sConnName, String sConfigName) {
		//return getConfig(sConnName, sConfigName, m_sConfigFile);
		return getXmlNodeValue("/configurations/connections/database[name='"+ sConnName +"']/" + sConfigName);
	}

	/**
	 * configuration/connections/database에서 속성 name이 일치하는 노드를 찾아 해당 노드의 지정된 요소(sConfigName)의 값을 반환
	 * <database name="dbname">... 형태로 지정된 요소
	 * @param sConnName
	 * @param sConfigName
	 * @return
	 */
	private static String getConfigOf(String sConnName, String sConfigName) {
		//return getConfig(sConnName, sConfigName, m_sConfigFile);
		return getXmlNodeValue("/configurations/connections/database[@name='"+ sConnName +"']/" + sConfigName);
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
	
	public DBMS_TYPE getDBType() {
		return _dbType;
	}
	
	
	
	public static void main(String args[]) {
		test003();
	}
	
	private static void test003() {
		System.out.println(DBConnection.getConfigOf("SYSLOGDB", "version"));
	}
	private static void test002() {
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
	
	public static void test001(String sTest) {
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