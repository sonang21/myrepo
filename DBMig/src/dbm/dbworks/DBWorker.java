package dbm.dbworks;

import java.sql.*;
import java.text.*;

import dbm.utils.*;

import dbm.db.dbpool.*;

@SuppressWarnings({"unused"})
public class DBWorker extends Thread {
	enum LOGTYPE { STATUS, ERROR };
	enum STATUS  { NEW, START, END, ERROR};
	enum CMDTYPE { QUERY, DML, DDL };
	private static int m_nRunCount = 0;
	private LogFile m_oLogFile = null;

	private DBConnectionManager m_oConnMgr;
	private Connection m_oConn = null;
	private LogDB   m_oLogDB = null;
	private String  m_sComments = "";
	
	private boolean m_bHasResultSet = false;
	private boolean m_bHasError = false;
	private ResultSet m_oResultSet  = null;
	private int m_nEffectedRows  = -1;
	private boolean m_bResult  = false;
	private Object m_oResult = null;
	private int m_nRows = 0;
	
	private STATUS m_Status = STATUS.NEW;
	private Exception m_oException = null;
	private double m_nDuration = 0;
	
	private String m_sCmdSQL = null;
	private CMDTYPE m_cmdType = CMDTYPE.QUERY;
	//private Connection m_oConnection = null;
	private String m_sJobId = null;
	private String m_sJobNm = null;
	private String m_sJobGroup = null;
	private String m_sJobType = null;
	private int    m_nPriority = 1;
	private String m_sJobDesc = null;
	private String m_sTargetTbl = null;
	private String m_sSourceTbl = null;
	private String m_sLogGroup = null;
	
	
	public DBWorker()
	{
		this.m_oLogFile = LogFileManager.getInstance().getLogFile();
	}
	public DBWorker(String sConnName) 
	{ 
		this();
		this.m_oConnMgr = new DBConnectionManager(sConnName);
		this.m_oConn = m_oConnMgr.getConnection();
		//this.m_sConnName = sConnName;
	}
	public DBWorker(String sConnName, String sSQL)
	{
		this(sConnName);
		//this.m_sConnName = sConnName;
		this.m_sCmdSQL = sSQL;
	}
	
	public void setJobInfo(String sJobId, String sJobNm, String sTargetTbl, String sSourceTbl) {
		this.m_sJobId = sJobId;
		this.m_sJobNm = sJobNm;
		this.m_sTargetTbl = sTargetTbl;
		this.m_sSourceTbl = sSourceTbl;
	}
	
	public void setJobGroup(String sJobGroup) { this.m_sJobGroup = sJobGroup; }
	public void setLogGroup(String sLogGroup) { this.m_sLogGroup = sLogGroup; }
	
	public void setJobTypeDesc(String sJobType, String sJobDesc) {
		this.m_sJobType = sJobType;
		this.m_sJobDesc = sJobDesc;
	}
	
//	public STATUS getStatus() {
//		return m_Status;
//	}
	public static synchronized void plusRunCount() {
		m_nRunCount ++;
	}
	
	public static synchronized void minusRunCount() {
		if(m_nRunCount > 0) m_nRunCount --;
	}
	public static synchronized int getRunCount() {
		return m_nRunCount;
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
	public void setSQL(String sSQL, CMDTYPE cmdType) { 
		this.m_sCmdSQL = sSQL; 
		this.m_cmdType = cmdType;
	}
//	public void setSQL(String sSQL, String sSQLType) { 
//		this.m_sCmdSQL = sSQL; 
//		this.m_cmdType = CMDTYPE.valueOf(sSQLType);
//	}
	
	public boolean isTableExists(String sTableName)
	{
		try 
		{
			executeQuery(m_oConn, "SELECT 1 FROM "+ sTableName + " WHERE 1=2");
			return true;
		}
		catch (Exception e)
		{
			return false;
		}
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
	
	public void setComment(String sComment) {
		this.m_sComments = sComment;
	}
	//public long getLong() { return (long) this.m_oResult; }
	//public Double getDouble() {	return (Double) this.m_oResult;	}
	public String toString() {
		String sResult = "";
		if (this.m_oResult != null) sResult = this.m_oResult.toString();
		
		return String.format("Connection = %s, HasResult = %s, Value = %s, Rows = %10d, Duration = %7.3f"
				            , this.m_oConnMgr.getName(), this.m_bHasResultSet, sResult, this.m_nRows, this.m_nDuration);
	}
	
	// thread start() will run(), join() wait for run() completed
	public void run() {
		//runSQL();
		this.m_Status = STATUS.START;
		
		DBWorker.plusRunCount();
		
		///////////////////////////////
		//runTest();
		///////////////////////////////
		runSQL();
		
		DBWorker.minusRunCount();
		if (this.m_Status == STATUS.START) {
			this.m_Status = STATUS.END;
		}
		
		
	}
	
	public void runTest() {
		if(m_oConn == null) return;
		
		long lStartTime = System.currentTimeMillis();
		
		Statement oStmt = null;
		
		try {
			oStmt = m_oConn.createStatement();
			oStmt.setFetchSize(1000);
			m_nRows = 0;
			ResultSet oRs = oStmt.executeQuery(this.m_sCmdSQL);
			while (oRs.next()) {
				m_nRows ++;
				if (m_nRows % 10000 == 0) {
					this.m_nDuration =  (System.currentTimeMillis() - lStartTime) /1000.0;
					System.out.println( String.format("%3s : %10d Rows fetched....%7.0f rows/sec", this.m_sComments, m_nRows, m_nRows / this.m_nDuration));
				}
			}
			
			System.out.println( m_sComments + " : " + String.valueOf(m_nRows) + " Rows fetched.. completed!!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(oStmt != null) {
				try {
					oStmt.cancel();
					oStmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		this.m_nDuration =  (System.currentTimeMillis() - lStartTime) /1000.0;
	}
	
	public ResultSet runSQL() 
	{
		return this.runSQL(m_oConn, this.m_sCmdSQL, this.m_cmdType);
	}
	
	public ResultSet runSQL(Connection oConn, String strSQL, CMDTYPE cmdType) 
	{
		
		this.m_bHasError = false;
		this.m_oException = null;
		
		m_oLogFile.debugWrite(strSQL);
		m_oLogDB = new LogDB(this.m_sLogGroup);
		m_oLogDB.setLogJob(m_sJobId, m_sJobNm, m_sJobGroup, m_sTargetTbl, m_sSourceTbl);
		m_oLogDB.setTables(m_sTargetTbl, m_sSourceTbl);
		m_oLogDB.setTargetCount(1, 1);
		
		this.m_sCmdSQL = strSQL;
    	
        try {
        	long lStartTime = System.currentTimeMillis();
            
        	if(cmdType == CMDTYPE.QUERY) {
        		this.m_oResultSet = executeQuery(oConn, this.m_sCmdSQL);        	
                	
        	} else if(cmdType == CMDTYPE.DML) {
        		this.m_nRows = executeUpdate(oConn, this.m_sCmdSQL);
        	} else if(cmdType == CMDTYPE.DDL) {
        		this.m_bResult = execute(oConn, this.m_sCmdSQL);
        	}
        	
        	this.m_nDuration =  (System.currentTimeMillis() - lStartTime) /1000.0;
            
        	System.out.println("DEBUG:" + String.valueOf(this.m_oResultSet==null));
        	//System.out.println("DEBUG:" + String.valueOf(this.m_oResultSet.next()));
        	
            this.m_bHasResultSet = true;        	
            // Finalize process
        	//this.dbChangeStatus("SQL END:" + this.m_oConnMgr.getName());
            return this.m_oResultSet;
        }
        catch (SQLException e)
        {   
        	this.m_bHasError = true;
        	this.m_oException = e;
        	this.m_bHasResultSet = false;        	
        	//String methodName = Thread.currentThread().getStackTrace()[1].toString();
        	this.m_oLogFile.debugWrite(m_oConnMgr.getName() + " : " + this.m_sCmdSQL);
        	this.m_oLogFile.logWrite(e);
        	//this.dbChangeError(String.valueOf(e.getErrorCode()), e.getMessage());
        }
        catch (Exception e)
        {   
        	this.m_bHasError = true;
        	this.m_oException = e;
        	this.m_bHasResultSet = false;        	
        	this.m_oLogFile.debugWrite(this.m_sCmdSQL);
        	this.m_oLogFile.logWrite(e);
        	//this.dbChangeError("9999", e.getMessage());
        }
        
        return null;
	}
	
	private ResultSet executeQuery(Connection oConn, String strSQL) throws Exception
	{
		if(oConn == null) return null;
		
		Statement  oStmt =  oConn.createStatement();
    	ResultSet oRs = oStmt.executeQuery(strSQL);        	
    	return oRs;
    }
	
	private int executeUpdate(Connection oConn, String strSQL) throws Exception
	{
		if(oConn == null)  return -1;
		
		Statement  oStmt =  oConn.createStatement();
    	int nRows = oStmt.executeUpdate(strSQL);        	
    	return nRows;
    }
	
	private boolean execute(Connection oConn, String strSQL) throws Exception
	{
		if(oConn == null)  return false;
		
		Statement  oStmt =  oConn.createStatement();
    	boolean bRet = oStmt.execute(strSQL);        	
    	return bRet;
    }
	
//	@SuppressWarnings("unused")
	public static void main(String[] args) {
		int nRows = 0;
		int i = 0;
		DecimalFormat df = new DecimalFormat("#,###");
		
		DBWorker[] dbWork = new DBWorker[1];
		
		for (i=0; i < dbWork.length; i++) {
			dbWork[i] = new DBWorker("ES_TEST");			
		}
		
//		DBWorker test1 = new DBWorker("DMPDB");
//		DBWorker test2 = new DBWorker("DMPDB");
//		DBWorker test3 = new DBWorker("DMPDB");
//		DBWorker test4 = new DBWorker("DMPDB");
//		DBWorker test5 = new DBWorker("DMPDB");
//		DBWorker test6 = new DBWorker("DMPDB");
//		DBWorker test7 = new DBWorker("DMPDB");
//		DBWorker test8 = new DBWorker("DMPDB");
//		DBWorker test9 = new DBWorker("DMPDB");
//		
		System.out.println("=========================================================");
		System.out.println("= DBWorkers Testing....");
		try {
			for(i=0; i < dbWork.length; i++) {
				dbWork[i].setComment("W" + String.valueOf(i));
			}
//			test1.setComment("W1");
//			test2.setComment("W2");
//			test3.setComment("W3");
//			test4.setComment("W4");
//			test5.setComment("W5");
//			test6.setComment("W6");
//			test7.setComment("W7");
//			test8.setComment("W8");
//			test9.setComment("W9");
			String sSQL1 = "select ID\r\n" + 
					"     , modelno\r\n" + 
					"     , pl_no\r\n" + 
					"     , modelno_group\r\n" + 
					"     , DECODE(NVL(MODELNO_GROUP,0),0,0,1) AS MODELNO_GROUP_FLAG\r\n" + 
					"     /* */ " +
					"     , UDF_CATEGORY_ALL(CATEGORY) AS category\r\n" + 
					"     , CASE\r\n" + 
					"         WHEN SERVICE_GUBUN = 1 THEN UDF_CATEGORY_SUB(CATEGORY,4)\r\n" + 
					"         ELSE UDF_CATEGORY_SUB(CATEGORY,2)\r\n" + 
					"       END AS CG\r\n" + 
					"     , UDF_CATEGORY_SUB(CATEGORY,2) AS CAT1\r\n" + 
					"     , UDF_CATEGORY_SUB(CATEGORY,4) AS CAT2\r\n" + 
					"     , UDF_CATEGORY_SUB(CATEGORY,6) AS CAT3\r\n" + 
					"     , UDF_CATEGORY_SUB(CATEGORY,8) AS CAT4\r\n" + 
					"     /***/ " +         
					"     , ca_code\r\n" + 
					"     , ca_dept_mcode\r\n" + 
					"     , ca_dept_code\r\n" + 
					"     , ca_dept_dcode\r\n" + 
					"     , ca_lcode_ran\r\n" + 
					"     , ca_mcode_ran\r\n" + 
					"     , ca_scode_ran\r\n" + 
					"     , ca_dcode_ran\r\n" + 
					"     , shop_code\r\n" + 
					"     , shop_name\r\n" + 
					"     , shop_name_code\r\n" + 
					"     , modelnm\r\n" + 
					"     , modelnm2\r\n" + 
					"     , factory\r\n" + 
					"     , brand\r\n" + 
					"     , popular\r\n" + 
					"     , popular2\r\n" + 
					"     , sale_cnt\r\n" +
					"     /* */ " +         
					"     , CASE\r\n" + 
					"         WHEN SERVICE_GUBUN = 1 THEN UDF_MODEL_FACTORY_ALL(REPLACE(MODELNM || ' ' || FACTORY, '-', ''))\r\n" + 
					"         ELSE ''\r\n" + 
					"       END AS model_factory\r\n" +
					"     /***/ " +         
					"     , minprice\r\n" + 
					"     , maxprice\r\n" + 
					"     , minprices\r\n" + 
					"     , C_DATE\r\n" + 
					"     , mallcnt\r\n" + 
					"     , DECODE(NVL(MALLCNT,0),0,0,1) AS MALLCNT_FLAG\r\n" + 
					"     , spec\r\n" + 
					"     , openexpectflag\r\n" + 
					"     , condiname\r\n" +
					"     /* * " +         
					"     , KEYWORD\r\n" + 
					"     /***/ " +         
					"     , keyword2\r\n" + 
					"     , BRANDCODE1\r\n" + 
					"     , BRANDCODE2\r\n" + 
					"     , SPECOPT\r\n" + 
					"     , bookflag\r\n" + 
					"     , useflag\r\n" + 
					"     , weight\r\n" + 
					"     , minprice3\r\n" + 
					"     , minprice2\r\n" + 
					"     , maxprice3\r\n" + 
					"     , mobile_flag\r\n" + 
					"     , minprice4\r\n" + 
					"     , store_flag\r\n" + 
					"     , bbs_num\r\n" + 
					"     , zum_check\r\n" + 
					"     , service_gubun\r\n" + 
					"     , minprice5\r\n" + 
					"     , ext_condi_flag\r\n" +
					"     /* * " +         
					"     , MODELNM || ' ' || FACTORY || ' \r\n" + 
					"       ' || SPEC || ' ' || KEYWORD || ' ' || KEYWORD2 || ' ' || CONDINAME AS to_all\r\n" +
					"     /***/ " +         
					"  from (select ID\r\n" + 
					"             , modelno\r\n" + 
					"             , pl_no\r\n" + 
					"             , modelno_group\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN service_gubun='2'\r\n" + 
					"           AND store_flag='1'\r\n" + 
					"           AND ca_dept_code IS NOT NULL THEN RTRIM(category || ' ' || ca_dept_code)\r\n" + 
					"                         ELSE category\r\n" + 
					"                       END AS category\r\n" + 
					"             , ca_code\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),3,8)='000000'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),3,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,4)\r\n" + 
					"                       END AS ca_dept_mcode\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),5,8)='0000'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),5,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,6)\r\n" + 
					"                       END AS ca_dept_code\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),7,8)='00'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),7,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,8)\r\n" + 
					"                       END AS ca_dept_dcode\r\n" + 
					"             , ca_lcode_ran\r\n" + 
					"             , ca_mcode_ran\r\n" + 
					"             , ca_scode_ran\r\n" + 
					"             , ca_dcode_ran\r\n" + 
					"             , shop_code\r\n" + 
					"             , shop_name\r\n" + 
					"             , shop_name_code\r\n" + 
					"             , modelnm\r\n" + 
					"             , modelnm2\r\n" + 
					"             , factory\r\n" + 
					"             , brand\r\n" + 
					"             , popular\r\n" + 
					"             , popular2\r\n" + 
					"             , sale_cnt\r\n" + 
					"             , model_factory\r\n" + 
					"             , minprice\r\n" + 
					"             , maxprice\r\n" + 
					"             , replace(minprices, ' ', '    ') as minprices\r\n" + 
					"             , C_DATE\r\n" + 
					"             , mallcnt\r\n" + 
					"             , replace(replace(spec,',',' '),'/',' ') spec\r\n" + 
					"             , openexpectflag\r\n" + 
					"             , replace(condiname, ' ', '    ') as condiname\r\n" + 
					"     /*  */ " +         
					"             , CASE\r\n" + 
					"                         WHEN socialprice=0 THEN keyword\r\n" + 
					"                         ELSE keyword || ' ' || UDF_SOCIAL_GOODSNM(modelno_group,modelno)\r\n" + 
					"                       END AS KEYWORD\r\n" + 
					"     /****/ " +         
					"             , keyword2\r\n" + 
					"             , BRANDCODE1\r\n" + 
					"             , BRANDCODE2\r\n" + 
					"             , SPECOPT\r\n" + 
					"             , bookflag\r\n" + 
					"             , useflag\r\n" + 
					"             , weight\r\n" + 
					"             , minprice3\r\n" + 
					"             , minprice2\r\n" + 
					"             , maxprice3\r\n" + 
					"             , mobile_flag\r\n" + 
					"             , minprice4\r\n" + 
					"             , store_flag\r\n" + 
					"             , bbs_num\r\n" + 
					"             , zum_check\r\n" + 
					"             , service_gubun\r\n" + 
					"             , minprice5\r\n" + 
					"             , ext_condi_flag\r\n" + 
					"          FROM tmp_es_price_data_31\r\n" + 
					"         WHERE mod_no = 1 ) ";
			String sSQL2 = "select /*+ parallel(8) */ ID\r\n" + 
					"     , modelno\r\n" + 
					"     , pl_no\r\n" + 
					"     , modelno_group\r\n" + 
					"     , DECODE(NVL(MODELNO_GROUP,0),0,0,1) AS MODELNO_GROUP_FLAG\r\n" + 
					"     /* * " +
					"     , UDF_CATEGORY_ALL(CATEGORY) AS category\r\n" + 
					"     , CASE\r\n" + 
					"         WHEN SERVICE_GUBUN = 1 THEN UDF_CATEGORY_SUB(CATEGORY,4)\r\n" + 
					"         ELSE UDF_CATEGORY_SUB(CATEGORY,2)\r\n" + 
					"       END AS CG\r\n" + 
					"     , UDF_CATEGORY_SUB(a.CATEGORY,2) AS CAT1\r\n" + 
					"     , UDF_CATEGORY_SUB(a.CATEGORY,4) AS CAT2\r\n" + 
					"     , UDF_CATEGORY_SUB(a.CATEGORY,6) AS CAT3\r\n" + 
					"     , UDF_CATEGORY_SUB(a.CATEGORY,8) AS CAT4\r\n" + 
					"     /***/ " +        
                    "     , B.CATALL " +
					"     , CASE\r\n" + 
					"         WHEN SERVICE_GUBUN = 1 THEN B.CAT4 \r\n" + 
					"         ELSE B.CAT1\r\n" + 
                    "       END AS CG\r\n" +                      
					"     , CAT1, CAT2, CAT3, CAT4" +
                    "     , ca_code\r\n" + 
					"     , ca_dept_mcode\r\n" + 
					"     , ca_dept_code\r\n" + 
					"     , ca_dept_dcode\r\n" + 
					"     , ca_lcode_ran\r\n" + 
					"     , ca_mcode_ran\r\n" + 
					"     , ca_scode_ran\r\n" + 
					"     , ca_dcode_ran\r\n" + 
					"     , shop_code\r\n" + 
					"     , shop_name\r\n" + 
					"     , shop_name_code\r\n" + 
					"     , modelnm\r\n" + 
					"     , modelnm2\r\n" + 
					"     , factory\r\n" + 
					"     , brand\r\n" + 
					"     , popular\r\n" + 
					"     , popular2\r\n" + 
					"     , sale_cnt\r\n" +
					"     /* */ " +         
					"     , CASE\r\n" + 
					"         WHEN SERVICE_GUBUN = 1 THEN UDF_MODEL_FACTORY_ALL(REPLACE(MODELNM || ' ' || FACTORY, '-', ''))\r\n" + 
					"         ELSE ''\r\n" + 
					"       END AS model_factory\r\n" +
					"     /***/ " +         
					"     , minprice\r\n" + 
					"     , maxprice\r\n" + 
					"     , minprices\r\n" + 
					"     , C_DATE\r\n" + 
					"     , mallcnt\r\n" + 
					"     , DECODE(NVL(MALLCNT,0),0,0,1) AS MALLCNT_FLAG\r\n" + 
					"     , spec\r\n" + 
					"     , openexpectflag\r\n" + 
					"     , condiname\r\n" +
					"     /* * " +         
					"     , KEYWORD\r\n" + 
					"     /***/ " +         
					"     , keyword2\r\n" + 
					"     , BRANDCODE1\r\n" + 
					"     , BRANDCODE2\r\n" + 
					"     , SPECOPT\r\n" + 
					"     , bookflag\r\n" + 
					"     , useflag\r\n" + 
					"     , weight\r\n" + 
					"     , minprice3\r\n" + 
					"     , minprice2\r\n" + 
					"     , maxprice3\r\n" + 
					"     , mobile_flag\r\n" + 
					"     , minprice4\r\n" + 
					"     , store_flag\r\n" + 
					"     , bbs_num\r\n" + 
					"     , zum_check\r\n" + 
					"     , service_gubun\r\n" + 
					"     , minprice5\r\n" + 
					"     , ext_condi_flag\r\n" +
					"     /* * " +         
					"     , MODELNM || ' ' || FACTORY || ' \r\n" + 
					"       ' || SPEC || ' ' || KEYWORD || ' ' || KEYWORD2 || ' ' || CONDINAME AS to_all\r\n" +
					"     /***/ " +         
					"  from (select ID\r\n" + 
					"             , modelno\r\n" + 
					"             , pl_no\r\n" + 
					"             , modelno_group\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN service_gubun='2'\r\n" + 
					"           AND store_flag='1'\r\n" + 
					"           AND ca_dept_code IS NOT NULL THEN RTRIM(category || ' ' || ca_dept_code)\r\n" + 
					"                         ELSE category\r\n" + 
					"                       END AS category\r\n" + 
					"             , ca_code\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),3,8)='000000'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),3,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,4)\r\n" + 
					"                       END AS ca_dept_mcode\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),5,8)='0000'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),5,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,6)\r\n" + 
					"                       END AS ca_dept_code\r\n" + 
					"             , CASE\r\n" + 
					"                         WHEN SUBSTR(RTRIM(ca_dept_code),7,8)='00'\r\n" + 
					"            OR SUBSTR(RTRIM(ca_dept_code),7,8) IS NULL THEN ''\r\n" + 
					"                         ELSE SUBSTR(RTRIM(ca_dept_code),0,8)\r\n" + 
					"                       END AS ca_dept_dcode\r\n" + 
					"             , ca_lcode_ran\r\n" + 
					"             , ca_mcode_ran\r\n" + 
					"             , ca_scode_ran\r\n" + 
					"             , ca_dcode_ran\r\n" + 
					"             , shop_code\r\n" + 
					"             , shop_name\r\n" + 
					"             , shop_name_code\r\n" + 
					"             , modelnm\r\n" + 
					"             , modelnm2\r\n" + 
					"             , factory\r\n" + 
					"             , brand\r\n" + 
					"             , popular\r\n" + 
					"             , popular2\r\n" + 
					"             , sale_cnt\r\n" + 
					"             , model_factory\r\n" + 
					"             , minprice\r\n" + 
					"             , maxprice\r\n" + 
					"             , replace(minprices, ' ', '    ') as minprices\r\n" + 
					"             , C_DATE\r\n" + 
					"             , mallcnt\r\n" + 
					"             , replace(replace(spec,',',' '),'/',' ') spec\r\n" + 
					"             , openexpectflag\r\n" + 
					"             , replace(condiname, ' ', '    ') as condiname\r\n" + 
					"     /*  */ " +         
					"             , CASE\r\n" + 
					"                         WHEN socialprice=0 THEN keyword\r\n" + 
					"                         ELSE keyword || ' ' || UDF_SOCIAL_GOODSNM(modelno_group,modelno)\r\n" + 
					"                       END AS KEYWORD\r\n" + 
					"     /****/ " +         
					"             , keyword2\r\n" + 
					"             , BRANDCODE1\r\n" + 
					"             , BRANDCODE2\r\n" + 
					"             , SPECOPT\r\n" + 
					"             , bookflag\r\n" + 
					"             , useflag\r\n" + 
					"             , weight\r\n" + 
					"             , minprice3\r\n" + 
					"             , minprice2\r\n" + 
					"             , maxprice3\r\n" + 
					"             , mobile_flag\r\n" + 
					"             , minprice4\r\n" + 
					"             , store_flag\r\n" + 
					"             , bbs_num\r\n" + 
					"             , zum_check\r\n" + 
					"             , service_gubun\r\n" + 
					"             , minprice5\r\n" + 
					"             , ext_condi_flag\r\n" + 
					"          FROM tmp_es_price_data_31  \r\n" +                
					"         WHERE mod_no = 5 ) A"
					+ " left join tmp_es_cate_31 b  on (b.category = A.category) ";
			System.out.println(sSQL2);
			dbWork[0].setSQL(sSQL2, CMDTYPE.QUERY);
			
//			test1.setSQL("select * from dbenuri.asis_tbl_pricelist subpartition(PL_NO_1) where rownum <= 50000");
//			test2.setSQL("select * from dbenuri.asis_tbl_pricelist subpartition(PL_NO_2) where rownum <= 90000");
//			test3.setSQL("select * from dbenuri.asis_tbl_pricelist subpartition(PL_NO_3) where rownum <= 10000");
//			test4.setSQL("select * from dbenuri.asis_tbl_pricelist subpartition(PL_NO_4) where rownum <= 100000");
			
//			test1.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) =  8");
//			test2.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) = 16");
//			test3.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) = 14");
//			test4.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) = 19");
//			test5.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) =  3");
//			test6.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) between  1 and  2");
//			test7.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) between  4 and  7");
//			test8.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) between  9 and 13");
//			test9.setSQL("select * from pricelist where $PARTITION.PFN_PRICELIST(pl_vcode) in (15, 17, 18)");
			
			for(i=0; i < dbWork.length; i++) {
				dbWork[i].start();
			}
			
//			test1.start();
//			test2.start();
//			test3.start();
//			test4.start();
//			test5.start();
//			test6.start();
//			test7.start();
//			test8.start();
//			test9.start();
			
			
			while (true) {
				
				Thread.sleep(3000);
				nRows = 0;
				for(i=0; i < dbWork.length; i++) {
					if(dbWork[i].m_Status == STATUS.END) System.out.println(dbWork[i].m_sComments + " : " + dbWork[i].toString());  
					nRows += dbWork[i].m_nRows;
				}
//				if (test1.m_Status == STATUS.END) System.out.println("WW1 : " + test1.toString());
//				if (test2.m_Status == STATUS.END) System.out.println("WW2 : " + test2.toString());
//				if (test3.m_Status == STATUS.END) System.out.println("WW3 : " + test3.toString());
//				if (test4.m_Status == STATUS.END) System.out.println("WW4 : " + test4.toString());
//				if (test5.m_Status == STATUS.END) System.out.println("WW5 : " + test5.toString());
//				if (test6.m_Status == STATUS.END) System.out.println("WW6 : " + test6.toString());
//				if (test7.m_Status == STATUS.END) System.out.println("WW7 : " + test7.toString());
//				if (test8.m_Status == STATUS.END) System.out.println("WW8 : " + test8.toString());
//				if (test9.m_Status == STATUS.END) System.out.println("WW9 : " + test9.toString());
//				nRows = test1.m_nRows;
//				nRows += test2.m_nRows;
//				nRows += test3.m_nRows;
//				nRows += test4.m_nRows;
//				nRows += test5.m_nRows;
//				nRows += test6.m_nRows;
//				nRows += test7.m_nRows;
//				nRows += test8.m_nRows;
//				nRows += test9.m_nRows;
				
				System.out.println(String.format("MAIN : Threads => %s, TotalRows => %s", DBWorker.getRunCount(), df.format(nRows)));
				if (DBWorker.getRunCount() < 1) break;
			}
			
			for(i=0; i < dbWork.length; i++) {
				dbWork[i].join();
			}
//			test1.join();
//			test2.join();
//			test3.join();
//			test4.join();
//			test5.join();
//			test6.join();
//			test7.join();
//			test8.join();
//			test9.join();
			
			for(i=0; i < dbWork.length; i++) {
				System.out.println(String.format("%s : %s", dbWork[i].m_sComments, dbWork[i].toString()));
			}
//			System.out.println("W1 : " + test1.toString());
//			System.out.println("W2 : " + test2.toString());
//			System.out.println("W3 : " + test3.toString());
//			System.out.println("W4 : " + test4.toString());
//			System.out.println("W5 : " + test5.toString());
//			System.out.println("W6 : " + test6.toString());
//			System.out.println("W7 : " + test7.toString());
//			System.out.println("W8 : " + test8.toString());
//			System.out.println("W9 : " + test9.toString());
//			System.out.println("DUAL: " + test1.isTableExists("DUAL"));
//			System.out.println("DUALX: " + test1.isTableExists("DUALX"));
			
			for(i=0; i < dbWork.length; i++) {
				dbWork[i].dbClose();
			}
//			test1.dbClose();
//			test2.dbClose();
//			test3.dbClose();
//			test4.dbClose();
//			test5.dbClose();
//			test6.dbClose();
//			test7.dbClose();
//			test8.dbClose();
//			test9.dbClose();
			
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("---------------------------------------------------------");
		System.out.println("= DBWorkers Test Completed.");
	}

}
