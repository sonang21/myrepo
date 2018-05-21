package com.cslee.dqm;

import java.sql.*;

import com.cslee.db.dbpool.*;
import com.cslee.utils.*;

public class DBWork extends Thread {
	enum LOGTYPE { STATUS, ERROR };
	private LogFile m_oLogFile = null;

	private DBConnectionManager m_oConnMgr;
	private Connection m_oConn = null;
	private LogDB   m_oLogDB = null;
	private String  m_sComments = "";
	
	private boolean m_bHasResultSet = false;
	private boolean m_bHasError = false;
	private Exception m_oException = null;
	private ResultSet m_oResultSet  = null;
	private double m_nDuration = 0;
	private Object m_oResult = null;
	
	//private String m_sConnName = null;
	private String m_sSQL = null;
	//private Connection m_oConnection = null;
	
	
	public DBWork()
	{
		this.m_oLogFile = LogFileManager.getInstance().getLogFile();
	}
	public DBWork(String sConnName) 
	{ 
		this();
		this.m_oConnMgr = new DBConnectionManager(sConnName);
		this.m_oConn = m_oConnMgr.getConnection();
		//this.m_sConnName = sConnName;
	}
	public DBWork(String sConnName, String sSQL)
	{
		this(sConnName);
		//this.m_sConnName = sConnName;
		this.m_sSQL = sSQL;
	}
	public DBWork(String sConnName, String sSQL, LogDB oLogDB) 
	{
		this(sConnName, sSQL);
		this.m_oLogDB = oLogDB;
	}

	public DBWork(String sConnName, String sSQL, LogDB oLogDB, String sComments) 
	{
		this(sConnName, sSQL, oLogDB);
		this.m_sComments = sComments;
	}
	
	public void setConnection(String sConnName)
	{ 
		m_oConnMgr.freeConnection(m_oConn);
		this.m_oConnMgr = new DBConnectionManager(sConnName); 
	}
	public void dbClose() 
	{
		this.m_oConnMgr.freeConnection(m_oConn);
	}
	public void setSQL(String sSQL) { this.m_sSQL = sSQL; }
	
	public boolean isTableExists(String sTableName)
	{
		try 
		{
			executeSQL(m_oConn, "SELECT 1 FROM "+ sTableName + " WHERE 1=2");
			return true;
		}
		catch (Exception e)
		{
			return false;
		}
	}
	
	private void dbChangeStatus(String sStatus) 
	{
		if (this.m_oLogDB == null) return;
		this.m_oLogDB.changeStatus(sStatus);		
	}
	
	private void dbChangeError(String sErrCd, String sErrMsg)
	{
		if (this.m_oLogDB == null) return;
		if(this.m_sComments != null && ! this.m_sComments.isEmpty()) 
		{
			sErrMsg = "[" + this.m_sComments + "] " + sErrMsg;
		}
		this.m_oLogDB.changeError(sErrCd, sErrMsg);
	}

	public boolean hasError() {
		return this.m_bHasError;
	}
	public Exception getException() {
		return this.m_oException;
	}
	
	public ResultSet getResultSet() { return this.m_oResultSet; }
	public double getDuration() { return this.m_nDuration;	}
	public Connection getConnection() { return this.m_oConn; }
	
	public String getResultString(int idx) 
	{ 
		if(this.m_bHasResultSet) {
			try {
				if (this.m_oResultSet.next()) {
					return this.m_oResultSet.getString(idx);
				};
			} catch (SQLException e) {
				//Thread.currentThread().getStackTrace()[0].getMethodName();
				//this.m_oLogFile.logWrite(e.getStackTrace()[0].getMethodName());
				this.m_oLogFile.logWrite(e);
			}
		}
		return null;
	}
	public Object getResult(int idx) 
	{ 
		if(this.m_bHasResultSet) {
			try {
				if (this.m_oResultSet.next()) {
					this.m_oResult = this.m_oResultSet.getObject(idx);
					return this.m_oResult;
				};
			} catch (SQLException e) {
				//Thread.currentThread().getStackTrace()[0].getMethodName();
				//this.m_oLogFile.logWrite(e.getStackTrace()[0].getMethodName());
				this.m_oLogFile.logWrite(e);
			}
		}
		this.m_oResult = null;
		return null;
	}
	
	
	//public long getLong() { return (long) this.m_oResult; }
	//public Double getDouble() {	return (Double) this.m_oResult;	}
	public String toString() {
		String sResult = "";
		if (this.m_oResult != null) sResult = this.m_oResult.toString();
		
		return "Connection = " + this.m_oConnMgr.getName() + ", HasResult = " + this.m_bHasResultSet 
				+ ", Value=" + sResult + ", Duration = " + this.m_nDuration + " sec";
	}
	
	public void run() {
		runSQL();
	}
	public ResultSet runSQL() 
	{
		return this.runSQL(m_oConn, this.m_sSQL);
	}
	
	public ResultSet runSQL(Connection oConn, String strSQL) 
	{
		long lStartTime = System.currentTimeMillis();
        
		this.m_bHasError = false;
		this.m_oException = null;
		
		m_oLogFile.debugWrite(strSQL);
		
        try {
        	this.m_sSQL = strSQL;
        	this.m_oResultSet = executeSQL(oConn, this.m_sSQL);        	
            this.m_nDuration =  (System.currentTimeMillis() - lStartTime) /1000.0;
        	this.m_bHasResultSet = true;        	
            // Finalize process
        	this.dbChangeStatus("SQL END:" + this.m_oConnMgr.getName());
            return this.m_oResultSet;
        }
        catch (SQLException e)
        {   
        	this.m_bHasError = true;
        	this.m_oException = e;
        	this.m_bHasResultSet = false;        	
        	//String methodName = Thread.currentThread().getStackTrace()[1].toString();
        	this.m_oLogFile.debugWrite(m_oConnMgr.getName() + " : " + this.m_sSQL);
        	this.m_oLogFile.logWrite(e);
        	this.dbChangeError(String.valueOf(e.getErrorCode()), e.getMessage());
        }
        catch (Exception e)
        {   
        	this.m_bHasError = true;
        	this.m_oException = e;
        	this.m_bHasResultSet = false;        	
        	this.m_oLogFile.debugWrite(this.m_sSQL);
        	this.m_oLogFile.logWrite(e);
        	this.dbChangeError("9999", e.getMessage());
        }
        
        return null;
	}
	
	private ResultSet executeSQL(Connection oConn, String strSQL) throws Exception
	{
		if(oConn == null) return null;
		
		Statement  oStmt =  oConn.createStatement();
    	ResultSet oRs = oStmt.executeQuery(strSQL);        	
    	return oRs;
    }
	
	
	public static void main(String[] args) {
		DBWork test1 = new DBWork("default");
		DBWork test2 = new DBWork("default");
		DBWork test3 = new DBWork("default");
		
		System.out.println("=========================================================");
		System.out.println("= DBWorks Testing....");
		try {
			
			test1.setSQL("select 1000 from dual ");
			test2.setSQL("select count(*) from dm_adm.tm_rg_bassregstr where delete_at = 'N'");
			test3.setSQL("select 1 from dual");
			
			test1.start();
			test2.start();
			
			test1.join();
			
			System.out.println("W1 : " + test1.toString());
			test2.join();
			System.out.println("W2 : " + test2.toString());
			System.out.println("W3 : " + test3.toString());
			System.out.println("DUAL: " + test1.isTableExists("DUAL"));
			System.out.println("DUALX: " + test1.isTableExists("DUALX"));
			test1.dbClose();
			test2.dbClose();
			
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("---------------------------------------------------------");
		System.out.println("= DBWorks Test Completed.");
	}

}
