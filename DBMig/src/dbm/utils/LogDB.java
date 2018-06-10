package dbm.utils;

import java.sql.*;
import java.util.Calendar;
import dbm.db.dbpool.DBConnectionManager;
//import java.util.Objects;

//import dbm.db.dbpool.*;
//import dbm.utils.*;


public class LogDB {
	public enum LogStatus { READY, RUNNING, END }
	public enum LogResult { SUCCESS, FAIL, ERROR}
	
	final static String m_sConnName = "LOGDB";
	private static DBConnectionManager m_oConnMgr;
	private Connection m_oConn = null;
	private LogFile  m_oLogFile = null;
	
	private String 	m_sLogId    = null;
	private String  m_sLogGroup = null;
	private String  m_sJobId = null;
	private String 	m_sJobNm = null;
	private String  m_sJobGroup = null;
	private String  m_sJobType = null;
	private String  m_sSourceTbl = null;
	private String  m_sTargetTbl = null;
	//private String  m_sStatus  = null;
	private LogStatus  m_status = LogStatus.READY;
	private Time    m_tStartTime = null;
	private Time    m_tEndTime = null;
	private LogResult  m_result = null;
	private long    m_lSourceCnt = -1;
	private long    m_lTargetCnt = -1;
	private long	m_lResultCnt;
	private String	m_sErrCode = null;
	private String  m_sErrMsg = null;
			
	private Time   m_tLogTime = null;
	private String m_sRemark = null;
	
	private String m_sLogTable = "TB_MIG_JOB_LOG";
	
	public String toString() 
	{
		return ("LogId = " + m_sLogId
				+ ", Job = " + m_sJobNm 
				+ ", Group = " + m_sLogGroup 
				+ ", Type = " + m_sJobType
			   );
		
	}
	
	public LogDB() {
		this.m_sLogId = LogDB.getLogUID();
		m_oConnMgr = new DBConnectionManager(m_sConnName);
		this.m_oLogFile = LogFileManager.getInstance().getLogFile();
	}
	
	public LogDB(String sLogGroup) 
	{	
		this();
		this.setLogGroup(sLogGroup);
	}

	public void setLogGroup(String sLogGroup) 
	{	
		this.m_sLogGroup = sLogGroup;
	}
	
	public void setLogJob(String sJobId, String sJobNm, String sJobGroup) {
		this.m_sJobId = sJobId;
		this.m_sJobNm = sJobNm;
		this.m_sJobGroup = sJobGroup;
	}
	public void setLogJob(String sJobId, String sJobNm, String sJobGroup, String sTargetTbl, String sSourceTbl)
	{
		this.setLogJob(sJobId, sJobNm, sJobGroup);
		this.setTables(sTargetTbl, sSourceTbl);
	}
	
	public void setTables(String sTargetTbl, String sSourceTbl) {
		this.m_sTargetTbl = sTargetTbl;
		this.m_sSourceTbl = sSourceTbl;
	}
	public void setTargetCount(long lTargetCount, long lSourceCount) {
		this.m_lTargetCnt = lTargetCount;
		this.m_lSourceCnt = lSourceCount;
	}
	public void setJobType(String sJobType) { this.m_sJobType = sJobType; }
	
	public void setError(String sErrCd, String sErrMsg){ this.m_sErrCode = sErrCd;	this.m_sErrMsg = sErrMsg; }
	
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
	
	private void setStatus(LogStatus status) 
	{
		// status는 현재 상태 이후의 것으로만 설정할 수 있음
		LogStatus chkStatus = LogStatus.values()[status.ordinal() - 1];
		if(status == LogStatus.END || this.m_status == chkStatus)  { 
			this.m_status = status;
			this.m_tLogTime = new Time(System.currentTimeMillis());
		}
		else {
			String sMsg = String.format("[setStatus]: Can't change status to [%s] from [%s](current status should be [%s])"
										, status
					                    , this.m_status
					                    , chkStatus);
			//System.out.println(sMsg);
			RuntimeException ex = new RuntimeException(sMsg);
			this.logExceptionEnd(ex,null);
			
			throw ex;

		}
	}

	private void setStatus(String sStatus) 
	{
		this.setStatus(LogStatus.valueOf(sStatus));
	}
	
	@SuppressWarnings("unused")
	private void setResult(String sResult) 
	{ 
		this.setResult(LogResult.valueOf(sResult));
	}
	
	private void setResult(LogResult result)
	{
		this.m_result = result;
		this.m_tEndTime = this.m_tLogTime;
	}
	
	public void setRemark(String sRemark) { this.m_sRemark = sRemark; }
	
	public String getLogId() { return this.m_sLogId; }
	private String getResult() {
		String sRet = null;
		if(this.m_result != null) {
			sRet = m_result.toString();
		}
		return sRet;
	}
	private boolean checkLogStart() {
		boolean bRet = true;
		String sMsg = "";
		if (m_sLogId == null) 		{ bRet = false; sMsg += "[LogId]"; 		}
		if (m_sJobId == null) 		{ bRet = false; sMsg += "[JobId]"; 		}
		if (m_sJobNm == null) 		{ bRet = false; sMsg += "[JobNm]"; 		}
		if (m_sTargetTbl == null) 	{ bRet = false; sMsg += "[TargetTbl]"; }
		// if (m_lTargetCnt < 0) 		{ bRet = false; sMsg += "[TargetCnt]"; 	}
		if(!bRet) { sMsg = "Some Values is not defined : " + sMsg; }
		
		if (m_status != LogStatus.READY) {
			bRet = false;
			sMsg += (sMsg=="" ? "": ", ") + "Log Status is not READY";
		}
		
		if (bRet) {
			return bRet;
		}
		else {
			throw new RuntimeException("[checkLogStart]:" + sMsg);
		}
	}
	public void logStart() throws Exception
	{
		if(checkLogStart()) {
			this.setStatus("RUNNING");
			this.m_tStartTime = this.m_tLogTime;
			this.logWrite();
		}
	}
	
//	public void changeStatus(String sStatus) 
//	{
//		this.setStatus(sStatus);
//		this.logWrite();
//	}
//	
//	public void changeStatus(String sStatus, String sRemark) 
//	{
//		this.setRemark(sRemark);
//		this.changeStatus(sStatus);
//	}
//	
//	public void changeStatus(String sStatus, String sResult, long lResCnt) 
//	{
//		this.setResult(sResult);
//		this.changeStatus(sStatus);
//		this.m_lResultCnt = lResCnt;
//	}
//
//	public void changeError(String sErrCd, String sErrMsg) 
//	{
//		this.setError(sErrCd, sErrMsg);
//		this.logWrite();
//	}
//	
//	public void changeError(Exception e, String sComments) 
//	{
//		this.setError(e, sComments);
//		this.logWrite();
//	}
	public void logEnd(LogResult result) 
	{
		this.setStatus(LogStatus.END);
		this.setResult(result);
		this.logWrite();
		m_oConnMgr.freeConnection(m_oConn);
	}
	
	public void logEnd(String sResult) 
	{
		LogResult rs;
		try {
			rs = LogResult.valueOf(sResult);
		}
		catch (Exception ex ) {
			String sMsg = "Result should be one of (";
			for (LogResult lr : LogResult.values())
			{
				sMsg += ("[" + lr.name() + "]");
			}
			sMsg += ")";
			this.logExceptionEnd(ex, sMsg);
			throw ex;						
		}
		this.logEnd(rs);		
	}

	public void logEnd(boolean bResult) 
	{
		if(bResult) { 
			logEnd(LogResult.SUCCESS); 
		} 
		else { 
			logEnd(LogResult.FAIL); 
		}
	}
	
	public void logEnd(long lResultCnt) {
		this.m_lResultCnt = lResultCnt;
		this.logEnd(this.m_lResultCnt == this.m_lTargetCnt);
	}

	public void logExceptionEnd(Exception e, String sComments)
	{
		//if(e instanceof SQLException) { this.setError(e, sComments); };
		this.setError(e, sComments);
		this.logEnd(LogResult.ERROR);
	}
	public void logErrorEnd(String sResult, String sErrCd, String sErrMsg)
	{
		this.setError(sErrCd, sErrMsg);
		this.logEnd(LogResult.ERROR);
	};
	
	private static String getLogUID()	{
		String sDateString;
		Calendar c = Calendar.getInstance();
		Time tmDateTime = new Time(System.currentTimeMillis());
		c.setTimeInMillis(tmDateTime.getTime());
		int yy = c.get(Calendar.YEAR) % 100; // for 2 digit of year
		int mm = c.get(Calendar.MONTH)+1;
		int dd = c.get(Calendar.DAY_OF_MONTH);
		int hh = c.get(Calendar.HOUR_OF_DAY);
		int mi = c.get(Calendar.MINUTE);
		int ss = c.get(Calendar.SECOND);
		int ms = c.get(Calendar.MILLISECOND);
		
		sDateString = String.format("%02d%02d%02d-%02d%02d%02d-%04d", yy,mm,dd,hh,mi,ss,ms /* Objects.hash(ms) */ );
		return sDateString;
	}
	
	private boolean logIdExists(String sLogId)
	{
		Connection oConn = m_oConnMgr.getConnection();
		boolean bReturn = false;
		try
		{
			String sSQL = "SELECT 1 FROM " + m_sLogTable + " WHERE LOG_ID=?";
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
	
	private boolean logWrite() 
	{
		return dbWrite(this.m_sLogId, this.m_sLogGroup
				     , this.m_sJobId, this.m_sJobNm, this.m_sJobGroup, this.m_sJobType 
				     , this.m_sTargetTbl, this.m_sSourceTbl
				     , this.m_status.toString(), this.m_tStartTime, this.m_tEndTime , this.getResult()
				     , this.m_lSourceCnt, this.m_lTargetCnt, this.m_lResultCnt
				     , this.m_sErrCode, this.m_sErrMsg
				     , this.m_tLogTime, this.m_sRemark);

	}
	private boolean dbWrite(String sLogId, String sLogGroup
			              , String sJobId, String sJobNm, String sJobGroup, String sJobType
			              , String sTargetTbl, String sSourceTbl
			              , String sStatus, Time tStartTime, Time tEndTime, String sResult
			              , long lSourceCnt, long lTargetCnt, long lResultCnt
			              , String sErrCode, String sErrMsg
			              , Time tLogTime, String sRemark)
	{
		String sSQL = null; // "INSERT INTO TB_DQM_RULES VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		Connection oConn = m_oConnMgr.getConnection();
		try {
			PreparedStatement oStmt = null; // = oConn.prepareStatement(sSQL);
			int nIdx = 1;
			
			if(sErrMsg != null && sErrMsg.length() > 800) { sErrMsg = sErrMsg.substring(1, 800); }
			
			if(logIdExists(sLogId))
			{
				sSQL = "UPDATE " +  m_sLogTable + " SET " 
						+ "  LOG_GROUP	 = ?"
						+ ", JOB_ID      = ?"
						+ ", JOB_NM		 = ?"
						+ ", JOB_GROUP    = ?"
						+ ", JOB_TYPE    = ?"
						+ ", TARGET_TBL  = ?"
						+ ", SOURCE_TBL  = ?"
						+ ", STATUS      = ?"
						+ ", START_TIME	 = ?"
						+ ", END_TIME	 = ?"
						+ ", RESULT		 = ?"
						+ ", SOURCE_CNT  = ?"
						+ ", TARGET_CNT  = ?"
						+ ", RESULT_CNT  = ?"
						+ ", ERR_CODE    = ?"
						+ ", ERR_MSG     = ?"
						+ ", LOG_TIME    = ?"
						+ ", REMARK      = ?"
						+ " WHERE LOG_ID = ?";
				oStmt = oConn.prepareStatement(sSQL);
//				oStmt.setString(nIdx++, sRuleId);
//				oStmt.setDate(nIdx++, dtLogDtm);
				oStmt.setString(nIdx++, sLogGroup);
				oStmt.setString(nIdx++, sJobId);
				oStmt.setString(nIdx++, sJobNm);
				oStmt.setString(nIdx++, sJobGroup);
				oStmt.setString(nIdx++, sJobType);
				oStmt.setString(nIdx++, sTargetTbl);
				oStmt.setString(nIdx++, sSourceTbl);
				oStmt.setString(nIdx++, sStatus);
				
				oStmt.setTime(nIdx++, tStartTime);
				oStmt.setTime(nIdx++, tEndTime);
				
				oStmt.setString(nIdx++, sResult);
				
				oStmt.setLong(nIdx++, lSourceCnt);
				oStmt.setLong(nIdx++, lTargetCnt);
				oStmt.setLong(nIdx++, lResultCnt);
				
				oStmt.setString(nIdx++, sErrCode);
				oStmt.setString(nIdx++, sErrMsg);
				
				oStmt.setTime(nIdx++, tLogTime);
				
				oStmt.setString(nIdx++, sRemark);
				oStmt.setString(nIdx++, sLogId);
			}
			else 
			{
				sSQL = "INSERT INTO " + m_sLogTable 
						+ "( LOG_ID, LOG_GROUP"
						+ ", JOB_ID, JOB_NM, JOB_GROUP, JOB_TYPE, TARGET_TBL, SOURCE_TBL" 
						+ ", STATUS, START_TIME, END_TIME, RESULT, SOURCE_CNT, TARGET_CNT, RESULT_CNT" 
						+ ", ERR_CODE, ERR_MSG, LOG_TIME, REMARK) "
						+ " VALUES(?, ?"
						      + ", ?, ?, ?, ?, ?, ?"
						      + ", ?, ?, ?, ?, ?, ?, ?"
							  + ", ?, ?, ?, ?)";
				oStmt = oConn.prepareStatement(sSQL);
				oStmt.setString(nIdx++, sLogId);
				oStmt.setString(nIdx++, sLogGroup);				
				oStmt.setString(nIdx++, sJobId);
				oStmt.setString(nIdx++, sJobNm);
				oStmt.setString(nIdx++, sJobGroup);
				oStmt.setString(nIdx++, sJobType);
				oStmt.setString(nIdx++, sTargetTbl);
				oStmt.setString(nIdx++, sSourceTbl);
				
				oStmt.setString(nIdx++, sStatus);
				oStmt.setTime(nIdx++, tStartTime);
				oStmt.setTime(nIdx++, tEndTime);
				oStmt.setString(nIdx++, sResult);
				oStmt.setLong(nIdx++, lSourceCnt);
				oStmt.setLong(nIdx++, lTargetCnt);
				oStmt.setLong(nIdx++, lResultCnt);
								
				oStmt.setString(nIdx++, sErrCode);
				oStmt.setString(nIdx++, sErrMsg);
				oStmt.setTime(nIdx++, tLogTime);
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
	
	@SuppressWarnings("unused")
	private boolean createLogTable() 
	{
//		boolean bResult = false;
		Connection oConn = m_oConnMgr.getConnection();
		String sSQL = "CREATE TABLE " + this.m_sLogTable
				+ "( LOG_ID 	VARCHAR2(30)  NOT NULL"
				+ ", LOG_GROUP 	VARCHAR2(20)  NULL"
				+ ", JOB_ID     VARCHAR2(10)  NOT NULL"
				+ ", JOB_NM		VARCHAR2(100) NOT NULL"
				+ ", JOB_GROUP  VARCHAR2(20)  "
				+ ", JOB_TYPE   VARCHAR2(20)  "
				+ ", TARGET_TBL VARCHAR2(100)"
				+ ", SOURCE_TBL VARCHAR2(100)"
				+ ", STATUS		VARCHAR2(10)"
				+ ", START_TIME DATE"
				+ ", END_TIME   DATE"
				+ ", RESULT     VARCHAR2(10)"
				+ ", SOURCE_CNT NUMBER"
				+ ", TARGET_CNT NUMBER"
				+ ", RESULT_CNT NUMBER"
				+ ", ERR_CODE   VARCHAR2(10)"
				+ ", ERR_MSG    VARCHAR2(500)"
				+ ", LOG_TIME   DATE"
				+ ", REMARK     VARCHAR2(200)"
				+ ", CONSTRAINT PK_" + this.m_sLogTable.substring(3) + " PRIMARY KEY (LOG_ID)"
				+ ")";
				 // + DBConfig.getErrorTablePrefixColumns();
		try {

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
	
	public static void main(String[] args) throws Exception {
		System.out.println("LogDB Test Start....");
		LogDB oLogDb = new LogDB("TESTGROUP");
		
		//oLogDb.createLogTable();
		oLogDb.setLogJob("T001", "TestJob", "TestGroup","TestTBL", "-");
		
		
		oLogDb.logStart();
		oLogDb.setTargetCount(10, 100);
		//oLogDb.setStatus("RUNNING");
		//oLogDb.logEnd("FAIL");
		Thread.sleep(3000);
		oLogDb.logEnd(10);

		//System.out.println(oLogDb.logWrite());
		System.out.println(".... LogDB Test End");
		
	}
	

}
