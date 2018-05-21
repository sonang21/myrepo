package dbm.db.dbpool;

import java.io.File;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.sql.*;
import java.util.*;

import dbm.utils.*;

public class DBConnectionPoolManager {
	static private DBConnectionPoolManager m_instance;
	private static LogFile m_logFile;
	
	private Vector<String> m_sDriverList = new Vector<String>();
	private Vector<String> m_sDriverFileList = new Vector<String>();
	private Hashtable<String, DBConnectionPool> m_htPools = new Hashtable<String, DBConnectionPool>();
	
	static synchronized public DBConnectionPoolManager getInstance() 
	{
		if(m_instance == null) 
		{
			m_instance = new DBConnectionPoolManager();
			m_logFile = LogFileManager.getInstance().getLogFile();
		}
		return m_instance;
	}
	
	//default constructor
	private DBConnectionPoolManager() {}
	
	public void freeConnection(String sConnName, Connection oConnection)
	{
		DBConnectionPool oPool = (DBConnectionPool) m_htPools.get(sConnName);
		if(oPool != null)
		{
			oPool.freeConnection(oConnection);
		}
		else
		{	
			m_logFile.debugWrite("DBConnectionPoolManager.freeConnection: failt to get Pool : " + sConnName);
			
		}
		
		m_logFile.debugWrite("One connection of "+ sConnName + " was freed.");
	}
	
	public void closeConnection(String sConnName, Connection oConnection)
	{
		DBConnectionPool oPool = (DBConnectionPool) m_htPools.get(sConnName);
		if(oPool != null)
		{
			oPool.closeConnection(oConnection);
		}
		else
		{	
			m_logFile.debugWrite("DBConnectionPoolManager.closeConnection: failt to get Pool : " + sConnName);
			
		}
		
		m_logFile.debugWrite("One connection of "+ sConnName + " was closed and removed.");
	}
	
	public Connection getConnection(String sConnName)
	{
		DBConnectionPool oPool = (DBConnectionPool) m_htPools.get(sConnName);
		if(oPool != null)
		{
			return oPool.getConnection(10);
		}
		else
		{
			m_logFile.debugWrite("DBConnectionPoolManager.getConnection: Can't get Connection pool:" + sConnName);
		}
		
		return null;
	}
	
	private void createPools(String sConnName, String sURL, String sUser, String sPassword
			               , int nInitConn, int nMaxConn, int nWaitSeconds)
	{
		DBConnectionPool oPool = new DBConnectionPool(sConnName, sURL, sUser, sPassword, nInitConn, nMaxConn, nWaitSeconds);
		
		m_htPools.put(sConnName,  oPool);
		
		m_logFile.debugWrite("Pool was created(1) :" + sConnName);
	}
	
	private void createPools(String sConnName, String sDriver, String sDriverFile, String sURL, String sUser, String sPassword
            , int nInitConn, int nMaxConn, int nWaitSeconds)
	{
		DBConnectionPool oPool = new DBConnectionPool(sConnName, sDriver, sDriverFile, sURL, sUser, sPassword, nInitConn, nMaxConn, nWaitSeconds);
		
		m_htPools.put(sConnName,  oPool);
		
		m_logFile.debugWrite("Pool was created(2) :" + sConnName);
	}
	
	
	public void initialize(String sConnName, String sDriver, String sURL, String sUser, String sPassword
			              , int nInitConn, int nMaxConn, int nWaitSeconds)
	{
		if(m_htPools.get(sConnName) != null ) 
		{
			m_logFile.debugWrite("DBConnectionPoolManager.initailize: "+ sConnName +" is already initialized.");
			return;
		}
		else 
		{
			loadDriver(sDriver);
			createPools(sConnName, sURL, sUser, sPassword, nInitConn, nMaxConn, nWaitSeconds);
		}
	}
	
	public void initialize(String sConnName, String sDriver, String sDriverFile, String sURL, String sUser, String sPassword
            , int nInitConn, int nMaxConn, int nWaitSeconds)
	{
		if(m_htPools.get(sConnName) != null ) 
		{
			m_logFile.debugWrite("DBConnectionPoolManager.initailize: "+ sConnName +" is already initialized.");
			return;
		}
		else 
		{
			loadDriver(sDriver, sDriverFile);
			createPools(sConnName, sDriver, sDriverFile, sURL, sUser, sPassword, nInitConn, nMaxConn, nWaitSeconds);
		}
	}

	
	private void loadDriver(String sDriverClassName)
	{
		try 
		{
			Class.forName(sDriverClassName);
			
			m_sDriverList.addElement(sDriverClassName);
			m_logFile.debugWrite("Registered JDBC Driver : " + sDriverClassName);
		}
		catch (Exception e) 
		{
			m_logFile.debugWrite(this.toString());
			m_logFile.logWrite(e);
			e.printStackTrace();
		}
	}
	
	private void loadDriver(String sDriverClassName, String sDriverFileName)
	{
		try {
			if(m_sDriverFileList.contains(sDriverFileName)) {
				m_logFile.debugWrite("loadDriver: [" + sDriverClassName + "] is already registered, DriverFile = " + sDriverFileName);
				return;
			}
			
			File file = new File(sDriverFileName);
			URI uri = file.toURI();
			URLClassLoader clsLoader = new URLClassLoader(new URL[] {uri.toURL()});
			
			Class<?> jdbcClass = Class.forName(sDriverClassName, false, clsLoader);
			
			//Class jdbcClass = loader.loadClass(sDriver);
			// Driver oDriver = (Driver) jdbcClass.newInstance();  // java 9 deprecated
			Driver oDriver = (Driver) jdbcClass.getConstructor().newInstance(); // from java9~
			
			DriverManager.registerDriver(new JdbcDriver(oDriver));
			
			m_sDriverList.addElement(sDriverClassName);
			m_sDriverFileList.addElement(sDriverFileName);
			m_logFile.debugWrite("Registered JDBC Driver : " + sDriverClassName + ", " + sDriverFileName);
			
		} catch (Exception e) {
			m_logFile.debugWrite(this.toString());
			m_logFile.logWrite(e);
			e.printStackTrace();
		}
		
	}
	
	public Hashtable<String, DBConnectionPool> getPools() 
	{
		return m_htPools;
	}
	
	public int getDriverCount()
	{
		return m_sDriverList.size();
	}
	
	public static void main(String[] args) 
	{
		
	}
}
