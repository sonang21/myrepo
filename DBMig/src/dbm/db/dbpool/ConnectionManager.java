package dbm.db.dbpool;

import java.sql.*;
import java.util.*;
import java.io.*;

import dbm.utils.*;

public abstract class ConnectionManager {
	private static LogFile m_logFile;
	protected DBConnectionPoolManager m_dbConnPoolMgr;
	protected String m_sConnectionName;
	protected String m_dbServer, m_dbName, m_port, m_userID, m_passwd;
	
	protected int m_nInitConnections, m_nMaxConnections, m_nWaitSeconds;
	
	private Properties m_dbProperties;
	private String m_sConfigFile;
	
	// this function is not used for this project. but may be used at a later time (for using simple configure file)
	public ConnectionManager(String sConnName)
	{
		try
		{
			m_sConfigFile = "./conf/jdbc_" + sConnName + ".properties";
			m_dbProperties = readProperties();
			m_dbServer = getProperty("dbServer");
			m_port = getProperty("port");
			m_userID = getProperty("userID");
			m_passwd = Encryption.decrypt(getProperty("passwd"));

			m_nInitConnections = Integer.parseInt(getProperty("initConnections"));
			m_nMaxConnections = Integer.parseInt(getProperty("maxConnections"));
			m_nWaitSeconds = Integer.parseInt(getProperty("waitSeconds"));
			
			m_logFile = LogFileManager.getInstance().getLogFile();
		}
		catch (IOException e)
		{
			m_logFile.logWrite(e);
		}
	}
	
	public Connection getConnection()
	{
		return (m_dbConnPoolMgr.getConnection(m_sConnectionName));
	}
	
	public String getName()
	{
		return m_sConnectionName;
	}
	
	public void freeConnection(Connection oConnection)
	{
		m_dbConnPoolMgr.freeConnection(m_sConnectionName, oConnection);
	}
	
	public void closeConnection(Connection oConnection)
	{
		m_dbConnPoolMgr.closeConnection(m_sConnectionName, oConnection);
	}
	
	private String getProperty(String sPropName) throws IOException 
	{
		return (m_dbProperties.getProperty(sPropName));
	}
	
	protected synchronized Properties readProperties() throws IOException
	{
		Properties oProps  = new Properties();
		FileInputStream in  = new FileInputStream(m_sConfigFile);
		oProps.load(in);
		return oProps;	
	}
	
	public int getDriverNumber()
	{
		return m_dbConnPoolMgr.getDriverCount();
	}
}
