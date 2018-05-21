package com.cslee.dqm;

import java.sql.*;
import java.util.Calendar;

import com.cslee.db.dbpool.*;
import com.cslee.utils.*;


public class LogDB {
	final static String m_sConnName = "DQMS";
	private static DBConnectionManager m_oConnMgr;
	private Connection m_oConn = null;
	private LogFile  m_oLogFile = null;
	
	private String m_sLogId = null;
	private String m_sRuleId = null;
	private Time   m_tmLogDate = null;
	
    private String m_sVerifyDB = null;
    private String m_sVerifyTable = null;
    private String m_sVerifyColumn = null;
    
	private String m_sResult = null;
	private String m_sSqlResult1 = null;
	private String m_sSqlResult2 = null;
	private String m_sErrCd = null;
	private String m_sErrMsg = null;
	private String m_sStatus = null;
	private Time   m_tmStatusDtm = null;
	private Time   m_tmStartDtm = null;
	private Time   m_tmEndDtm = null;
	private String m_sRemark = null;
	
	private String m_sErrTable = "TB_DQM_ERR_DAT";
	
	public String toString() 
	{
		return ("LogId = " + m_sLogId + ", RuleId = " + m_sRuleId + ", DB = " + m_sVerifyDB + ", Table = " + m_sVerifyTable);
		
	}
	
	LogDB(String sRuleId) 
	{
		this.setLog(sRuleId);
		m_oConnMgr = new DBConnectionManager(m_sConnName);
		this.m_oLogFile = LogFileManager.getInstance().getLogFile();
	}
	
	LogDB(String sRuleId, String sVerifyDB, String sVerifyTable, String sVerifyColumn) 
	{
		this(sRuleId);
		this.setVerifyInfo(sVerifyDB, sVerifyTable, sVerifyColumn);
	}
	
	public void setLog(String sRuleId) 
	{
		this.m_sRuleId = sRuleId;
		this.m_tmLogDate = new Time(System.currentTimeMillis());
		this.m_sLogId = sRuleId + "_" + getDateString(m_tmLogDate);
	}
	
//	public void setLog(String sLogId, String sRuleId, Time tmLogDate, String sTargetTable) 
//	{
//		this.m_sLogId = sLogId;
//		this.m_sRuleId = sRuleId;
//		this.m_tmLogDate = tmLogDate; //new Date(System.currentTimeMillis());
//		this.m_sTargetTable = sTargetTable;
//	}
	
	public void setSqlResult1(String sSqlResult) { this.m_sSqlResult1 = sSqlResult; }
	public void setSqlResult2(String sSqlResult) { this.m_sSqlResult2 = sSqlResult; }
	public void setError(String sErrCd, String sErrMsg){	this.m_sErrCd = sErrCd;	this.m_sErrMsg = sErrMsg; }
	
	public void setError(Exception e, String sComments) 
	{
		String sErrCd = ""; 
		if(e instanceof SQLException) { sErrCd = String.valueOf(((SQLException)e).getErrorCode()); }
		if(sComments != null && ! sComments.isEmpty()) 
		{ 
			sComments = "[" + sComments + "] "; 
		}
		else 
		{
			sComments = "";
		}
		setError(sErrCd, sComments + e.getMessage());		
	}
	
	public void setStatus(String sStatus) 
	{
		this.m_sStatus = sStatus;
		this.m_tmStatusDtm = new Time(System.currentTimeMillis());
	}
	public void setResult(String sResult) 
	{ 
		this.setStatus("END");
		this.m_tmEndDtm  = this.m_tmStatusDtm;
		this.m_sResult = sResult;
	}
	
	public void setRemark(String sRemark) { this.m_sRemark = sRemark; }
	public void setVerifyInfo(String sVerifyDB, String sVerifyTable, String sVerifyColumn) 
	{ 
		this.m_sVerifyDB = sVerifyDB;
		this.m_sVerifyTable = sVerifyTable;
		this.m_sVerifyColumn = sVerifyColumn;
	}
	
	public String getLogId() { return this.m_sLogId; }
	public String getResult() { return this.m_sResult; }
	
	public void startLog() 
	{
		this.setStatus("START");
		this.m_tmStartDtm = this.m_tmStatusDtm;
		this.logWrite();
	}
	
	public void changeStatus(String sStatus) 
	{
		this.setStatus(sStatus);
		this.logWrite();
	}
	
	public void changeStatus(String sStatus, String sRemark) 
	{
		this.setRemark(sRemark);
		this.changeStatus(sStatus);
	}
	
	public void changeStatus(String sStatus, String sSqlResult1, String sSqlResult2) 
	{
		this.setSqlResult1(sSqlResult1);
		this.setSqlResult2(sSqlResult2);
		this.changeStatus(sStatus);
	}
	
	public void changeSqlResult1(String sSqlResult1) 
	{
		this.setSqlResult1(sSqlResult1);
		this.logWrite();
	}

	public void changeSqlResult2(String sSqlResult2) 
	{
		this.setSqlResult2(sSqlResult2);
		this.logWrite();
	}
	
	public void changeError(String sErrCd, String sErrMsg) 
	{
		this.setError(sErrCd, sErrMsg);
		this.logWrite();
	}
	
	public void changeError(Exception e, String sComments) 
	{
		this.setError(e, sComments);
		this.logWrite();
	}

	public void endLog(String sResult, String sRemark) 
	{
		this.setRemark(sRemark);
		this.setResult(sResult);
		this.logWrite();
		m_oConnMgr.freeConnection(m_oConn);
	}
	
	public void endLog(String sResult) 
	{
		this.endLog(sResult, "");
	}
	

	
	public void endLog(boolean bResult) 
	{
		if(bResult) { endLog("PASS"); } 
		else { endLog("FAIL"); }
	}
	
	public void endLog(Exception e, String sComments)
	{
		if(e instanceof SQLException) { this.setError(e, sComments); };
		this.endLog("ERROR");
	}
	public void endLog(String sResult, String sErrCd, String sErrMsg, String sRemark)
	{
		this.setError(sErrCd, sErrMsg);
		this.endLog(sResult, sRemark);
	};
	
	
	private static String getDateString(Time tmDateTime)	{
		String sDateString;
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(tmDateTime.getTime());
		int yy = c.get(Calendar.YEAR);
		int mm = c.get(Calendar.MONTH)+1;
		int dd = c.get(Calendar.DAY_OF_MONTH);
		int hh = c.get(Calendar.HOUR_OF_DAY);
		int mi = c.get(Calendar.MINUTE);
		int ss = c.get(Calendar.SECOND);
		sDateString = String.format("%04d%02d%02d%02d%02d%02d", yy,mm,dd,hh,mi,ss);
		return sDateString;
	}
	
	private boolean logIdExists(String sLogId)
	{
		Connection oConn = m_oConnMgr.getConnection();
		boolean bReturn = false;
		try
		{
			String sSQL = "SELECT 1 FROM TB_DQM_RULE_LOGS WHERE LOG_ID=?";
			PreparedStatement oStmt = oConn.prepareStatement(sSQL);
			oStmt.setString(1, sLogId);
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next()) 
			{
				bReturn = true;
			}
			oRs.close();
			oStmt.close();
		}
		catch (Exception e)
		{
			this.m_oLogFile.logWrite(e);
		}
		m_oConnMgr.freeConnection(oConn);
		return bReturn;
	}
	
	public boolean logWrite() 
	{
		return dbWrite(this.m_sLogId, this.m_sRuleId, this.m_tmLogDate, this.m_sResult, this.m_sSqlResult1, this.m_sSqlResult2
				     , this.m_sErrCd, this.m_sErrMsg, this.m_sStatus, this.m_tmStatusDtm, this.m_tmStartDtm, this.m_tmEndDtm, this.m_sRemark);
	}
	public boolean dbWrite(String sLogId, String sRuleId, Time dtLogDtm, String sResult, String sSqlResult1, String sSqlResult2
			             , String sErrCd, String sErrMsg, String sStatus, Time dtStatusDtm, Time dtStartDtm, Time dtEndDtm, String sRemark)
	{
		String sSQL = null; // "INSERT INTO TB_DQM_RULES VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		Connection oConn = m_oConnMgr.getConnection();
		try {
			PreparedStatement oStmt = null; // = oConn.prepareStatement(sSQL);
			int nIdx = 1;
			
			if(sErrMsg != null && sErrMsg.length() > 800) { sErrMsg = sErrMsg.substring(1, 800); }
			
			if(logIdExists(sLogId))
			{
//				sSQL = "UPDATE TB_DQM_VRFY_LOGS SET VRFY_RSLT=?, SQL_RSLT=?, SQL_N2_RSLT=?, ERR_CD=?, ERR_MSG=?, PROC_STTS=?, STTS_DTM=?, STRT_DTM=?, END_DTM=?, RMK=? WHERE LOG_ID=?";
				sSQL = "UPDATE TB_DQM_RULE_LOGS SET VRFY_RSLT=?, SQL_N1_RSLT=?, SQL_N2_RSLT=?, ERR_CD=?, ERR_MSG=?, PROC_STTS=?, STTS_DTM=?, STRT_DTM=?, END_DTM=?, RMK=? WHERE LOG_ID=?";
				oStmt = oConn.prepareStatement(sSQL);
//				oStmt.setString(nIdx++, sRuleId);
//				oStmt.setDate(nIdx++, dtLogDtm);
				oStmt.setString(nIdx++, sResult);
				oStmt.setString(nIdx++, sSqlResult1);
				oStmt.setString(nIdx++, sSqlResult2);
				oStmt.setString(nIdx++, sErrCd);
				oStmt.setString(nIdx++, sErrMsg);
				
				oStmt.setString(nIdx++, sStatus);
				oStmt.setTime(nIdx++, dtStatusDtm);
				oStmt.setTime(nIdx++, dtStartDtm);
				oStmt.setTime(nIdx++, dtEndDtm);
				oStmt.setString(nIdx++, sRemark);
				oStmt.setString(nIdx++, sLogId);
			}
			else 
			{
				sSQL = "INSERT INTO TB_DQM_RULE_LOGS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				oStmt = oConn.prepareStatement(sSQL);
				oStmt.setString(nIdx++, sLogId);
				oStmt.setString(nIdx++, sRuleId);
				oStmt.setTime(nIdx++, dtLogDtm);
				oStmt.setString(nIdx++, sResult);
				oStmt.setString(nIdx++, sSqlResult1);
				oStmt.setString(nIdx++, sSqlResult2);
				oStmt.setString(nIdx++, sErrCd);
				oStmt.setString(nIdx++, sErrMsg);
				oStmt.setString(nIdx++, sStatus);
				oStmt.setTime(nIdx++, dtStatusDtm);
				oStmt.setTime(nIdx++, dtStartDtm);
				oStmt.setTime(nIdx++, dtEndDtm);
				oStmt.setString(nIdx++, sRemark);
			}
			
			oStmt.execute();
			oConn.commit();
			oStmt.close();
			
			//oConn.close();
			m_oConnMgr.freeConnection(oConn);
		}
		catch(Exception e) 
		{
			m_oConnMgr.freeConnection(oConn);
			this.m_oLogFile.debugWrite(sSQL + ", LOG_ID=" + sLogId);
			this.m_oLogFile.logWrite(e);
			e.printStackTrace();
			return false;
		}

		return true;
	}
	
	private boolean executeSQL(Connection  oConn, String strSQL) throws Exception
	{
		boolean bReturn = false;
		if(oConn == null) return bReturn;
		Statement oStmt = oConn.createStatement();
		bReturn = oStmt.execute(strSQL);
    	oStmt.close();
    	return bReturn;
    }
	
	public boolean isTableExists(String sErrTableName)
	{
		boolean bResult = false;
		Connection oConn = m_oConnMgr.getConnection();
		try 
		{
			Statement oStmt = oConn.createStatement();
			oStmt.executeQuery("SELECT 1 FROM "+ sErrTableName + " WHERE 1=2");
			oStmt.close();
			bResult = true;
			
		}
		catch (Exception e)
		{
			bResult = false;
		}
		m_oConnMgr.freeConnection(oConn);
		return bResult;
	}
	public boolean compareResultSet(ResultSet oRs1, ResultSet oRs2)
	{
		boolean bResult = true;

		int nColCount = 0;
		int nRow = 0;
		
		String sRes1="*", sRes2 = "*";
		
		try 
		{
			nColCount = oRs1.getMetaData().getColumnCount();
			
			LOOP1:
			while(oRs1.next())
			{
				nRow ++;
				sRes1 = oRs1.getString(1);

				if(oRs2.next()) 
				{
					sRes2 = oRs2.getString(1);
					for(int i=1; i <= nColCount; i++)
					{
//						if(! oRs1.getObject(i).equals(oRs2.getObject(i)))
						m_oLogFile.debugWrite(String.format("Compare[%d,%d]: %s, %s", nRow, i, oRs1.getString(i), oRs2.getString(i)));
						
						if(oRs1.getString(i) == null && oRs2.getString(i) == null)
						{
							//compare is ok.. do nothing...
						}
						else if(! oRs1.getString(i).equals(oRs2.getString(i)))
						{
							m_oLogFile.debugWrite("... Compare : Different value !!");
							bResult = false;
							break LOOP1;
						}
					}
				}
				else
				{
					m_oLogFile.debugWrite("... Compare : Different count of rows!!");
					bResult = false;
					break LOOP1;
				}
				
			}
			
			if(nColCount > 1 && nRow > 1) 
			{
				while(oRs1.next());
				while(oRs2.next());
				sRes1 = String.valueOf(oRs1.getRow());
				sRes2 = String.valueOf(oRs2.getRow());
			}
		}
		catch(Exception e) 
		{
			m_oLogFile.debugWrite(e);
			bResult = false;
		}

		this.setSqlResult1(sRes1);
		this.setSqlResult2(sRes2);
		
		return bResult;
	}
	private boolean createErrTable(String sErrTableName, ResultSet oRs) 
	{
		String sSQL = "CREATE TABLE " + sErrTableName + "( LOG_ID VARCHAR2(30) NOT NULL, VRFY_ID VARCHAR2(10) NOT NULL, VRFY_DTM DATE NOT NULL, OBJ_NM VARCHAR2(30)"; // + DBConfig.getErrorTablePrefixColumns();
		String sColumn;
		String sType;
		int nPrecision;
		int nScale;
		Connection oConn = m_oConnMgr.getConnection();
		try 
		{
			ResultSetMetaData oRsmd = oRs.getMetaData();
			for(int i=0; i < oRsmd.getColumnCount(); i++)
			{
				sColumn =  oRsmd.getColumnName(i+1);
				sType = oRsmd.getColumnTypeName(i+1);
				nPrecision = oRsmd.getPrecision(i+1);
				nScale = oRsmd.getScale(i+1);
				if (sType.equalsIgnoreCase("STRING")) 
				{
					sType = "VARCHAR2";
					nPrecision = 4000;
					nScale = 0;
				} 
				else if(sType.equalsIgnoreCase("TIMESTAMP"))
				{
					nPrecision = 0;
					nScale = 0;
				}
				
				if(nPrecision > 0) 
				{
					if(nScale > 0)
					{
						sColumn += String.format("  %s(%d, %d)", sType, nPrecision, nScale);
					}
					else
					{
						sColumn += String.format("  %s(%d)", sType, nPrecision);
					}
				}
				else
				{
					sColumn += "  "+ sType;
				}
				sSQL += ", " + sColumn;
			}
			sSQL +=")";
			//System.out.println(sSQL);
			this.executeSQL(oConn, sSQL);
			m_oConnMgr.freeConnection(oConn);
		}
		catch (Exception e)
		{
			m_oConnMgr.freeConnection(oConn);
			this.m_oLogFile.debugWrite(sSQL);
			this.m_oLogFile.logWrite(e);
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public long insertErrResultSet(ResultSet oRs) {
		long nRows = 0;
		long lBatchSize = 100;
		int  nColLimit = 30;
		int  nColCount = 0;
		
		ResultSetMetaData oRsmd = null;
		Connection oConn = null;
		
		oConn = m_oConnMgr.getConnection();
		//String sCREATE_SQL = "CREATE TABLE"
		String sSQL = "INSERT INTO TB_DQM_ERR_DAT";
		String sColumns = " (LOG_ID, SEQ, RULE_ID, LOG_DTM, TG_DB_NM, TAB_NM, COL_NM";
		String sValues =  " VALUES(?, ?, ?, ?, ?, ?, ?";
		try 
		{
			oRsmd = oRs.getMetaData();
			nColCount = oRsmd.getColumnCount();
			for(int i = 0; i < nColCount && i < nColLimit ; i ++) 
			{
				sColumns += String.format(", VAL%02d", i+1);
				sValues += ", ?";
			}
			sColumns += ")";
			sValues += ")";
			sSQL = sSQL + sColumns + sValues;
			
			PreparedStatement oStmt = oConn.prepareStatement(sSQL);
			m_oLogFile.debugWrite(sSQL);

			// insert column names
            oStmt.setString(1, this.m_sLogId);
            oStmt.setLong(2, 0);
            oStmt.setString(3, this.m_sRuleId);
            oStmt.setTime(4, this.m_tmLogDate);
            oStmt.setString(5,  this.m_sVerifyDB);
            oStmt.setString(6, this.m_sVerifyTable);
            oStmt.setString(7, this.m_sVerifyColumn);
            
            for(int i = 0; i < nColCount && i < nColLimit ; i ++) 
			{
            	oStmt.setString(8+i, oRsmd.getColumnName(i+1));            	
			}
            oStmt.addBatch();
			
            
            while(oRs.next()) 
			{
				nRows++;
				
				 oStmt.setString(1, this.m_sLogId);
		         oStmt.setLong(2, nRows);
		         oStmt.setString(3, this.m_sRuleId);
		         oStmt.setTime(4, this.m_tmLogDate);
		         oStmt.setString(5,  this.m_sVerifyDB);
		         oStmt.setString(6, this.m_sVerifyTable);
		         oStmt.setString(7, this.m_sVerifyColumn);
		           
				for (int i=0; i < nColCount; i++)
				{
					//m_logFile.logWrite("%s, %s...", nRows, i);
					//oStmt.setObject(8+i, oRs.getObject(i+1));  //lst~4th columns is for system using(log info), data field is from 5th column  
					oStmt.setString(8+i, oRs.getString(i+1));  //lst~4th columns is for system using(log info), data field is from 5th column  
				}
				
				oStmt.addBatch();
				if ((nRows % lBatchSize) == 0) 
				{
					oStmt.executeBatch();
					oStmt.clearBatch();
					oConn.commit();
					m_oLogFile.debugWrite( "Running: [LogId="+ this.m_sLogId + ", Log Table=" + this.m_sErrTable + "] ... " + (nRows) + " Rows Inserted ...");
				}
				
			}
			
			if ((nRows % lBatchSize) != 0) 
			{
				oStmt.executeBatch();
				oStmt.clearBatch();
				oConn.commit();
			}
			m_oLogFile.debugWrite( "Compeleted: Log Table is[" + this.m_sErrTable + "], " + (nRows) + " rows inserted.");
			
			//this.close();
			m_oConnMgr.freeConnection(oConn);
		} catch (Exception e) {
			m_oConnMgr.freeConnection(oConn);
			this.m_oLogFile.logWrite(e);
			return -1000;
		}
		
		return nRows;
	}
	
	
	
	public long insertErrResultSet(String sErrTableName, ResultSet oRs) {
		long nRows = 0;
		long lBatchSize = 100;
		
		ResultSetMetaData oRsmd = null;
		Connection oConn = null;
		
		oConn = m_oConnMgr.getConnection();
		if (! this.isTableExists(sErrTableName)) 
		{
			this.createErrTable(sErrTableName, oRs);
		}
		
		//String sCREATE_SQL = "CREATE TABLE"
		String sSQL = "INSERT INTO " + sErrTableName + " VALUES(?, ?, ?, ? ";
		try 
		{
			oRsmd = oRs.getMetaData();
			for(int i = 0; i < oRsmd.getColumnCount() ; i ++) 
			{
				sSQL += ", ?";
			}
			sSQL += ")";
			
			PreparedStatement oStmt = oConn.prepareStatement(sSQL);
			m_oLogFile.debugWrite( sSQL);
			
			while(oRs.next()) 
			{
				nRows++;
				
				oStmt.setString(1, this.m_sLogId);
				oStmt.setString(2, this.m_sRuleId);
				oStmt.setTime(3, this.m_tmLogDate);
				oStmt.setString(4, this.m_sVerifyTable);
				
				for (int i=0; i < oRsmd.getColumnCount(); i++)
				{
					//m_logFile.logWrite("%s, %s...", nRows, i);
					oStmt.setObject(i+5, oRs.getObject(i+1));  //lst~4th columns is for system using(log info), data field is from 5th column  
				}
				
				oStmt.addBatch();
				if ((nRows % lBatchSize) == 0) 
				{
					oStmt.executeBatch();
					oStmt.clearBatch();
					oConn.commit();
					m_oLogFile.debugWrite( "Running: Log table is [" + sErrTableName + "], " + (nRows) + " rows inserted...");
				}
				
			}
			
			if ((nRows % lBatchSize) != 0) 
			{
				oStmt.executeBatch();
				oStmt.clearBatch();
				oConn.commit();
			}
			m_oLogFile.debugWrite( "Compeleted: Log Table is[" + sErrTableName + "], " + (nRows) + " rows inserted.");
			
			//this.close();
			m_oConnMgr.freeConnection(oConn);
		} catch (Exception e) {
			m_oConnMgr.freeConnection(oConn);
			this.m_oLogFile.logWrite(e);
		}
		
		return nRows;
	}
	
	
	
	
	
	public static void main(String[] args){
		LogDB oLogDb = new LogDB("TEST");
		oLogDb.setStatus("RUNNING");
		System.out.println(oLogDb.logWrite());
	}
	

}
