package com.cslee.db.dbpool;

import java.sql.*;
//import java.util.Properties;
import java.util.Vector;
import java.util.Date;

import com.cslee.utils.*;

@SuppressWarnings("unused")
public class DBConnectionPool {
	private LogFile m_logFile;

	private Vector<Connection> m_oFreeConnList = new Vector<Connection>();
	private int m_nCheckOut;
	private int m_nInitConnections;
	private int m_nMaxConnections;
	private int m_nWaitSeconds;
	
	private String m_sConnectionName;
	private String m_sURL;
	private String m_sUser;
	private String m_sPassword;
	private String m_sDriver;
	private String m_sDriverFile;

	public DBConnectionPool(  String sConnectionName
							, String sURL
			                , String sUser
			                , String sPassword
			                , int nInitConnections
			                , int nMaxConnections
			                , int nWaitSeconds
			               )
	{
		this.m_sConnectionName = sConnectionName;
		this.m_sURL = sURL;
		this.m_sUser = sUser;
		this.m_sPassword = sPassword;
		this.m_nInitConnections = nInitConnections;
		this.m_nMaxConnections = nMaxConnections;
		this.m_nWaitSeconds = nWaitSeconds;
		this.m_nCheckOut = 0;
		
		this.m_logFile = LogFileManager.getInstance().getLogFile();

		for( int i = 0; i < this.m_nInitConnections; i++)
		{
			this.m_oFreeConnList.addElement(this.newConnection());
		}
	}
	
	public DBConnectionPool(  String sConnectionName
			, String sDriver
			, String sDriverFile
			, String sURL
            , String sUser
            , String sPassword
            , int nInitConnections
            , int nMaxConnections
            , int nWaitSeconds
           )
	{
		this.m_sConnectionName = sConnectionName;
		this.m_sDriver = sDriver;
		this.m_sDriverFile = sDriverFile;
		this.m_sURL = sURL;
		this.m_sUser = sUser;
		this.m_sPassword = sPassword;
		this.m_nInitConnections = nInitConnections;
		this.m_nMaxConnections = nMaxConnections;
		this.m_nWaitSeconds = nWaitSeconds;
		this.m_nCheckOut = 0;
		
		this.m_logFile = LogFileManager.getInstance().getLogFile();
	
		for( int i = 0; i < this.m_nInitConnections; i++)
		{
			this.m_oFreeConnList.addElement(this.newConnection());
		}
	}
	
	public synchronized void freeConnection(Connection oConn)
	{
		m_nCheckOut--;
		m_oFreeConnList.addElement(oConn);
		//notify to thread waiting for connection
		this.notifyAll();
		m_logFile.debugWrite("DBConnectionPool.freeConnection: " + this.m_sConnectionName + ", chkout=" + m_nCheckOut + ", free=" + this.m_oFreeConnList.size());
	}
	
	public synchronized void closeConnection(Connection oConn)
	{
		m_nCheckOut--;
		try {
			oConn.close();
		} catch (Exception e) {
			m_logFile.logWrite(e);
		}
		//notify to thread waiting for connection
		this.notifyAll();
		m_logFile.debugWrite("DBConnectionPool.closeConnection: " + this.m_sConnectionName + ", m_nCheckOut=" + m_nCheckOut + ", free=" + this.m_oFreeConnList.size());
	}
	
	@SuppressWarnings("resource")
	public synchronized Connection getConnection()
	{
		Connection oConn = null;
		if(m_oFreeConnList.size() > 0)
		{
			oConn = (Connection) m_oFreeConnList.firstElement();
			m_oFreeConnList.removeElementAt(0);
			
			try 
			{
				if(oConn == null || oConn.isClosed()) 
				{
					m_logFile.debugWrite("Removed bad connection(name= " + this.m_sConnectionName + ")");
					oConn = getConnection();
				}
			}
			catch(SQLException e)
			{
				m_logFile.logWrite(e);
				oConn = getConnection();
			}
		}
		else if (m_nMaxConnections == 0 || m_nCheckOut < m_nMaxConnections)
		{
			m_logFile.debugWrite(String.format("DBConnectionPool.getConnection: %s, m_nMaxConnection = %d, m_nCheckOut = %d"
					                           , m_sConnectionName, m_nMaxConnections, m_nCheckOut));
			oConn = newConnection();
		}
		
		if (oConn != null)
		{
			m_nCheckOut ++;
		}
		//m_logFile.debugWrite("DB Pool getConnection: " + this.m_sConnectionName + ", " + m_nCheckOut + " / " + this.m_oFreeConnList.size() );
		return oConn;
	}
	
	public synchronized Connection getConnection(long nTimeoutSeconds) 
	{
		long nStartTime = (new Date()).getTime();
		Connection oConn;
		while ((oConn = getConnection()) == null)
		{
			try
			{
				m_logFile.debugWrite("DBConnectionPool: Waiting for getConnection...");
				wait(m_nWaitSeconds * 1000);
			}
			catch (InterruptedException e) {}
			
			if((new Date().getTime() - nStartTime) >= nTimeoutSeconds * 1000)
			{
				return null;
			}
		}
		
		//m_logFile.debugWrite("DB Pool getConnection(wait): " + this.m_sConnectionName + ", " + m_nCheckOut + " / " + this.m_oFreeConnList.size());

		return oConn;
	}
	
	private synchronized Connection newConnection() 
	{
		Connection oConn = null;
		try
		{
			if(m_sUser == null)
			{
				oConn = DriverManager.getConnection(m_sURL);
			}
			else
			{
				oConn = DriverManager.getConnection(m_sURL, m_sUser, m_sPassword);
			}
			
			m_logFile.debugWrite("Created a new connection in pool " + m_sConnectionName);
			
		}
		catch (SQLException e)
		{
			StringBuffer sb = new StringBuffer();
			sb.append("Cant't create a new connection for "+ m_sConnectionName);
			sb.append(", URL: " + m_sURL);
			sb.append(", USER: " + m_sUser);
			m_logFile.debugWrite(sb.toString());
			m_logFile.logWrite(e);
			
			return null;
		}
		
		return oConn;
	}
	
}
