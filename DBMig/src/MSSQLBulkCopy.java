

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;
//import com.microsoft.sqlserver.jdbc.*;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

//import dbm.dbworks.StandAloneTest;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

//import dbm.db.dbpool.DBConnectionManager;

@SuppressWarnings({"unused"})
public class MSSQLBulkCopy extends Thread {
	private long   _nLogId;
	private String _sLogGroup;
	private String _sJobName;

	private String _sSourceDB;
	private String _sTargetDB;
	
	private String _sSourceTable;
	private String _sTargetTable;
	
	private long _nSourceCount;
	private long _nTargetCount;
	
//	private static int _nTotalCount=0;
	private static int _nThreadCount=0;
	private static int _nRunCount = 0;
	private static int _nWorkingCount = 0;
	private int _nThreadNumber = 0;

	private static int _nBatchSize = 125; //5000;
	private static int _nFetchSize = 125; //5000;
	private static long _nTotalRows = 0; //500000;
	private long        _nRows = 0;
	
	private String _sDBConfigFile = "conf/DBConfig.ini";
	
	
	public static void main2(String[] args) {
		
		
	}
	public static void main(String[] args) throws Exception {
		int nTotalCnt = 1;
		int nThreadNum = -1;
		
		//테스트 코드 강제 실행을 위한 세팅 
		if(args.length < 1) {
			args = new String[1]; args[0] = "4";
		}
		
		
		if (args.length > 0) {
			System.out.println(args[0]);
			//check args is number
			if(args[0].chars().allMatch(Character::isDigit))  {
				nTotalCnt = Integer.valueOf(args[0]);
				if(args.length == 2) {
					nThreadNum = Integer.valueOf(args[1]);
				}
			}
			else if(args[0].equalsIgnoreCase("all"))
			{
				nTotalCnt = 8;
				nThreadNum = -1;
			}
			else {
				System.out.println("Usage : MSSQLBulkCopy [threadCount|all] [threadNumber]");
				return;
			}
		}
		else {
			System.out.println("Usage : MSSQLBulkCopy [threadCount|all] [threadNumber]");
			return;
		}
		
		setThreadCount(nTotalCnt);
		MSSQLBulkCopy[] sample = new MSSQLBulkCopy[nTotalCnt];
		
		long nTimeStart = System.currentTimeMillis();
		
		for(int i=0; i < sample.length; i++) {
			sample[i] = new MSSQLBulkCopy("ENURI_DB", "DBENURI.TBL_GOODS"
					                    , "ANAL_DB" , "ANALSTORE.dbo.tbl_goods");
			sample[i].setThreadNumber(nThreadNum < 0 ? i : nThreadNum);
			sample[i].start();
			Thread.sleep(100);
		}
		
		long nTimeCurrent = nTimeStart;
		long nTimeBefore = nTimeStart;
		double dElapsedSec = 0.0;
		double dTotalSec = 0.0;
		long nRowsCurrent = 0;
		long nRowsBefore = 0;
		//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
		
		while (getRunCount() > 0) {
			Thread.sleep(5000);
			nTimeCurrent = System.currentTimeMillis();
			dElapsedSec =  (nTimeCurrent - nTimeBefore) /1000.0;
			dTotalSec = (nTimeCurrent - nTimeStart) / 1000.0;
			nRowsCurrent = 0;
			for(int i=0; i < sample.length; i++) {
				nRowsCurrent += sample[i].getRowCount();
			}
			System.out.format("[%02d:%02d:%02d](%d/%d):Total %,d Rows, %,d/%.0fs, %.1f /tsec, %.1f /sec\n"
					//, df.format(new Date(nTimeCurrent))
					, (int)(dTotalSec / 3600), (int)(dTotalSec % 3600) / 60, (int)(dTotalSec % 60)
					, getWorkingCount(), getRunCount()
					, nRowsCurrent, nRowsCurrent-nRowsBefore, dElapsedSec
					, nRowsCurrent / dTotalSec
					, (nRowsCurrent-nRowsBefore) / dElapsedSec
					)
			;
			nTimeBefore = nTimeCurrent;
			nRowsBefore = nRowsCurrent;
		}
		
		// wait for completing all threads
//		for(int i=0; i < sample.length; i++) {
//			sample[i].join();
//		}
//		
		dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
		System.out.format("## END : total %d Rows, Sec: %.0f(%02d:%02d:%02d),  %.1f rows/sec \n"
				, _nTotalRows, dElapsedSec
				, (int) dElapsedSec / 3600, (int) (dElapsedSec %3600) / 60, (int) (dElapsedSec % 60)
				, _nTotalRows / dElapsedSec
				);
		
		
	}
	public MSSQLBulkCopy(String sSourceDB, String sSourceTable, String sTargetDB, String sTargetTable) {
		setSource(sSourceDB, sSourceTable);
		setTarget(sTargetDB, sTargetTable);
	}
	
	public static void setThreadCount(int nThreadCount) {
		_nThreadCount = nThreadCount;
	}
	public void setThreadNumber(int nThreadNumber) {
		this._nThreadNumber = nThreadNumber;
	}
	
	public void setSource(String sDB, String sTable) {
		_sSourceDB = sDB;
		_sSourceTable = sTable;
	}
	public void setTarget(String sDB, String sTable) {
		_sTargetDB = sDB;
		_sTargetTable = sTable;
	}
	public void run() {
		addRunCount(1);
//		bulkCopy();
//		batchInsert();
		batchUpdate();
		addRunCount(-1);
		addWorkingCount(-1);
	}
	
	public long getRowCount() { return _nRows; }
	
	public static int getRunCount() { return _nRunCount; }
	public static int getWorkingCount() { return _nWorkingCount; }
	
	
//	@SuppressWarnings("unused")
	public void bulkCopy() {
		long nTimeStart = System.currentTimeMillis();
		long nSpotTimeBefore = nTimeStart ;
		long nSpotTimeCurr;
		double dElapsedSec = 0.0;
		double dLapSec = 0.0;
		long nRows=0;
		
//		String sConnS = "jdbc:sqlserver://X.X.X.X:port;"
//				        + "databaseName=dbname;user=user;password=passwd";
//		String sConnT = "jdbc:sqlserver://x.x.x.x:port;"
//				        + "databaseName=dbname;user=user;password=passwd";
			
		//String strSqlS = "select * from " + _sSourceTable;
		String strSqlCount = "select count(*) \r\n" + 
				"FROM DBENURI.TBL_GOODS  A\r\n" + 
				"WHERE MOD(A.MODELNO, " +  _nThreadCount + ") = " + _nThreadNumber;

		String strSqlS = "SELECT A.MODELNO                                           modelno\r\n" + 
				"     , A.RECOMMEND                                         recommend\r\n" + 
				"     , A.MODELNM                                           modelnm\r\n" + 
				"     , A.FACTORY                                           factory\r\n" + 
				"     , null /*A.SPEC*/                                              spec\r\n" + 
				"     , A.C_DATE                                            c_date\r\n" + 
				"     , null /*A.IMGCHK*/                                            imgchk\r\n" + 
				"     , A.CONSTRAIN                                         constrain\r\n" + 
				"     , A.FLAG                                              flag\r\n" + 
				"     , A.REFID                                             refid\r\n" + 
				"     , A.MANUAL_LINK                                       manual_link\r\n" + 
				"     , A.LINKSERVICEFLAG                                   linkserviceflag\r\n" + 
				"     , A.G_SIZE                                            g_size\r\n" + 
//				"     , A.FUNC                                              func\r\n" + 
                "     , null                                              func\r\n" + 
				"     , A.KEYWORD                                           keyword\r\n" + 
				"     , A.JOBCODE                                           jobcode\r\n" + 
				"     , A.MODDATE                                           moddate\r\n" + 
				"     , A.OPENEXPECTFLAG                                    openexpectflag\r\n" + 
				"     , A.MODELNO_GROUP                                     modelno_group\r\n" + 
				"     , A.CONDINAME                                         condiname\r\n" + 
				"     , A.MODEL_SORT                                        model_sort\r\n" + 
				"     , A.NO                                                no\r\n" + 
				"     , A.REFERMODELNO                                      refermodelno\r\n" + 
				"     , A.FACTORY_ETC                                       factory_etc\r\n" + 
				"     , A.RSIFLAG                                           rsiflag\r\n" + 
				"     , A.P_PL_NO                                           p_pl_no\r\n" + 
				"     , A.P_IMGURL                                          p_imgurl\r\n" + 
				"     , A.P_IMGURLFLAG                                      p_imgurlflag\r\n" + 
				"     , A.REFSHOP                                           refshop\r\n" + 
				"     , A.BRAND                                             brand\r\n" + 
				"     , A.FUNC_IMG                                          func_img\r\n" + 
				"     , A.KEYWORD2                                          keyword2\r\n" + 
				"     , A.WEIGHT                                            weight\r\n" + 
				"     , A.HEIGHT                                            height\r\n" + 
				"     , A.SPEC_GROUP                                        spec_group\r\n" + 
				"     , A.P_IMGURL2                                         p_imgurl2\r\n" + 
				"     , A.KB_TITLE                                          kb_title\r\n" + 
				"     , A.IMGCHK2                                           imgchk2\r\n" + 
				"     , A.IMGCHK3                                           imgchk3\r\n" + 
				"     , A.MOBILE_FLAG                                       mobile_flag\r\n" + 
				"     , A.EXT_CONDI_FLAG                                    ext_condi_flag\r\n" + 
				"     , A.STANDARD                                          standard\r\n" + 
				"     , A.AMOUNT                                            amount\r\n" + 
				"     , A.CHANGE                                            change\r\n" + 
				"     , A.UNIT                                              unit\r\n" + 
				"     , A.CA_CODE                                           ca_code\r\n" + 
				"     , A.SUM_MODDATE                                       sum_moddate\r\n" + 
				"     , A.CATE_MODDATE                                      cate_moddate\r\n" + 
				"     , A.CHANGE_MODEDATE                                   change_modedate\r\n" + 
				"     , A.CHK_CSM_DATE                                      chk_csm_date\r\n" + 
				"     , A.CHK_CSM_FLAG                                      chk_csm_flag\r\n" + 
				"     , A.CHK_TRG_DATE                                      chk_trg_date\r\n" + 
				"     , A.CHK_TRG_FLAG                                      chk_trg_flag\r\n" + 
				"     , A.ORGN_DTM                                          orgn_dtm\r\n" + 
				"FROM DBENURI.TBL_GOODS  A\r\n" + 
				"WHERE MOD(A.MODELNO, " +  _nThreadCount + ") = " + _nThreadNumber;
				       
//		System.out.println(strSqlS);

//		InputStream  input = StandAloneTest.class.getClassLoader().getResourceAsStream("../conf/DBConfig.ini");

		try {
			InputStream  input = new FileInputStream(_sDBConfigFile);
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnS = prop.getProperty(_sSourceDB);
			String sConnT = prop.getProperty(_sTargetDB);
			
			System.out.println(String.format("start(%d) ---------------------------------------------", _nThreadNumber));
			Class.forName("oracle.jdbc.driver.OracleDriver"); // for Oracle
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // for mssql
			//DBConnectionManager oConMgrS = new DBConnectionManager(_sSourceDB);
			//DBConnectionManager oConMgrT = new DBConnectionManager(_sTargetDB);
			//Connection oConnS = oConMgrS.getConnection();
			//Connection oConnT = oConMgrT.getConnection();
			System.out.println(sConnS);
			System.out.println(sConnT);
			
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);

//			if (_nThreadNumber==0) {
//				Statement oStmtT = oConnT.createStatement();
//				oStmtT.execute("truncate table " + _sTargetTable);
//				oStmtT.close();
//			}

			//--------------------------------------------------------
			Statement oStmtCnt = oConnS.createStatement();
			ResultSet oRsCnt = oStmtCnt.executeQuery(strSqlCount);
			oRsCnt.next();
			nRows = oRsCnt.getLong(1);
			oRsCnt.close();
			oStmtCnt.close();
			//--------------------------------------------------------
			
			
			Statement oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY
					                                , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(_nFetchSize);
			
			System.out.println(String.format("Query Start (%d) .... ", _nThreadNumber));
			nSpotTimeBefore = System.currentTimeMillis();
			
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			
			dElapsedSec =  (System.currentTimeMillis() - nSpotTimeBefore) /1000.0;
			System.out.println(String.format("Fetch Start (%d) .... %.1f sec", _nThreadNumber, dElapsedSec));

			//SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(oConnT);
			oConnT.setCatalog("ANALSTORE");
			SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(sConnT);
			SQLServerBulkCopyOptions copyOptions = new SQLServerBulkCopyOptions();
			copyOptions.setKeepIdentity(true);
			copyOptions.setBatchSize(_nBatchSize);
			copyOptions.setTableLock(true);
			copyOptions.setBulkCopyTimeout(0);
			
			bulkCopy.setBulkCopyOptions(copyOptions);
			
			bulkCopy.setDestinationTableName(_sTargetTable);
			
			bulkCopy.clearColumnMappings();
			ResultSetMetaData oRsMeta = oRs.getMetaData();
			for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
				bulkCopy.addColumnMapping(oRsMeta.getColumnName(i), oRsMeta.getColumnName(i).toLowerCase());
//				System.out.println("col mapping : " + oRsMeta.getColumnName(i) + " -> " + oRsMeta.getColumnName(i).toLowerCase());
			}
			
			try {
				bulkCopy.writeToServer(oRs);
				bulkCopy.close();
			}
			catch (Exception ex) {
				System.out.println("######################################################");
				ex.printStackTrace();
			}

			
			dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			_nTotalRows = _nTotalRows + nRows;
			System.out.println( String.format("# COMPLETE(%d): total %d Rows, Sec: %.0f,  %.1f rows/sec", _nThreadNumber, nRows, dElapsedSec, nRows / dElapsedSec));
			
			oRs.close();
			oConnS.close();
			oConnT.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	
	public void batchInsert() {
		long nTimeStart = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		//long nRows = 0;
		String sKeyValues[] = new String[_nBatchSize];
		Statement oStmtS = null;
		ResultSet oRs = null;
		
		PreparedStatement oStmtT  = null;
		Statement oStmtCommit = null;
		
		Connection oConnS = null;
		Connection oConnT = null;
		
		String strSqlS = String.format("select /*+ parallel(4) */ * from %s where mod(modelno, %d) = %d ", _sSourceTable, _nThreadCount, _nThreadNumber) ;
		
		String strSqlT1 = "insert into " + _sTargetTable + "(";
		String strSqlT2 = " values(";
		
		System.out.println(String.format("Thread(%d) Start .....", _nThreadNumber));
		
		try {
			InputStream  input = new FileInputStream(_sDBConfigFile);
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnS = prop.getProperty(_sSourceDB);
			String sConnT = prop.getProperty(_sTargetDB);
			
			
			Class.forName("oracle.jdbc.driver.OracleDriver"); // for Oracle
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			oConnS = DriverManager.getConnection(sConnS);
			oConnT = DriverManager.getConnection(sConnT);
			
			oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(_nBatchSize);
			
			oRs = oStmtS.executeQuery(strSqlS);
			ResultSetMetaData oRsMeta = oRs.getMetaData(); 
			
			for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
				//System.out.print(String.valueOf(i) + " ");
//				System.out.println(String.format("%d\t%s", oRsMeta.getColumnType(i), oRsMeta.getColumnTypeName(i)));

				strSqlT1 = strSqlT1 + oRsMeta.getColumnName(i) + ",";
				strSqlT2 = strSqlT2 + "?,";
			}
			
			strSqlT1 = strSqlT1.substring(0, strSqlT1.length()-1) + ") " 
			           + strSqlT2.substring(0, strSqlT2.length() -1) + ")";
			
			oConnT.setAutoCommit(false);
			oStmtT = oConnT.prepareStatement(strSqlT1);
			oStmtCommit = oConnT.createStatement();
			
//			System.out.println("sql:" + strSqlT1);
			
			while(oRs.next()) {
				_nRows ++;
				sKeyValues[(int)(_nRows % _nBatchSize)] = oRs.getString(1);
				
				for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
					//System.out.print(String.valueOf(i) + " ");
					switch (oRsMeta.getColumnType(i)) {
						//case java.sql.Types.ARRAY : 							break;
						case java.sql.Types.BIGINT:  	oStmtT.setLong(i, oRs.getLong(i));                   break;
						case java.sql.Types.BINARY:  	oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.BIT:        oStmtT.setBoolean(i, oRs.getBoolean(i));            break;
						case java.sql.Types.BLOB:		oStmtT.setBlob(i, oRs.getBlob(i));                  break;
						case java.sql.Types.BOOLEAN:    oStmtT.setBoolean(i, oRs.getBoolean(i));	        break;
						case java.sql.Types.CHAR:       oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.CLOB:       oStmtT.setClob(i,  oRs.getClob(i));                 break;
						case java.sql.Types.DATE:       oStmtT.setDate(i, oRs.getDate(i));	                break;
						case java.sql.Types.DECIMAL:    oStmtT.setBigDecimal(i,  oRs.getBigDecimal(i));     break;
						case java.sql.Types.DOUBLE:     oStmtT.setDouble(i,  oRs.getDouble(i));             break;
						case java.sql.Types.FLOAT:      oStmtT.setFloat(i,  oRs.getFloat(i));               break;
						case java.sql.Types.INTEGER:	oStmtT.setInt(i, oRs.getInt(i));                    break;
						case java.sql.Types.LONGNVARCHAR:  oStmtT.setString(i,  oRs.getString(i));             break;
						case java.sql.Types.LONGVARBINARY: oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.LONGVARCHAR:   oStmtT.setString(i, oRs.getString(i));           break;
						case java.sql.Types.NCHAR:       oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.NCLOB:      oStmtT.setClob(i,  oRs.getClob(i));                 break;
						case java.sql.Types.NUMERIC:    oStmtT.setBigDecimal(i,  oRs.getBigDecimal(i));     break;
						case java.sql.Types.NVARCHAR:   oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.REAL:       oStmtT.setFloat(i,  oRs.getFloat(i));               break;
						//case java.sql.Types.ROWID:
						case java.sql.Types.SMALLINT:   oStmtT.setShort(i,  oRs.getShort(i));               break;
						//case java.sql.Types.SQLXML:
						case java.sql.Types.TIME:       oStmtT.setTime(i,  oRs.getTime(i));                 break;
						//case java.sql.Types.TIME_WITH_TIMEZONE: oStmtT.setTime(i,  oRs.getTime(i));                 break;
						case java.sql.Types.TIMESTAMP:  oStmtT.setTimestamp(i,  oRs.getTimestamp(i));                 break;
						//case java.sql.Types.TIMESTAMP_WITH_TIMEZONE: oStmtT.setTimestamp(i,  oRs.getTimestamp(i));                 break;
						case java.sql.Types.TINYINT:    oStmtT.setByte(i, oRs.getByte(i));                   break;
						case java.sql.Types.VARBINARY:  oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.VARCHAR:    oStmtT.setString(i, oRs.getString(i));              break; 
						default :
							System.err.println("[WARNNING] Undifined Type " + oRsMeta.getColumnTypeName(i));
							oStmtT.setString(i, oRs.getString(i));  
							break;
					}

				}
				oStmtT.addBatch();
				if(_nRows % _nBatchSize == 0 ) {
					oStmtT.executeBatch();
					oStmtT.clearBatch();
					oStmtCommit.execute("commit with (delayed_durability=on)"); // for sql server
//					oStmtCommit.execute("commit write batch nowait"); // for oracle
//					oConnT.commit();
				}
				if(_nRows % (100000) == 0) {
					dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
					System.out.println( String.format("RUN(%d) : %10d Rows ...%7.0f rows/sec", _nThreadNumber, _nRows, _nRows / dElapsedSec));
				}
			}
			
			if((_nRows % _nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				oStmtCommit.execute("commit with (delayed_durability=on)"); // for sql server
//				oStmtCommit.execute("commit write batch nowait"); // for oracle
//				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			System.out.println( String.format("# COMPLETE(%d) : total %d Rows, Sec: %.0f,  %.1f rows/sec"
					, _nThreadNumber, _nRows, dElapsedSec, _nRows / dElapsedSec));
//			_nTotalRows = _nTotalRows + _nRows;
			addTotalRows(_nRows);
			oStmtS.close();
			oStmtT.close();
			oStmtCommit.close();
		}
		catch (Exception ex) {
			System.err.println(String.format("RUN(%d)에서 오류 발생 ######################", _nThreadNumber));
			try {
				System.err.print("컬럼(1)값 : ");
				if(oRs != null) for (int i=0; i<_nBatchSize; i++) System.err.print(String.format("%s, ", sKeyValues[i]));
				System.err.println("");				
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			ex.printStackTrace();
			try {
				if(oStmtS != null) if(!oStmtS.isClosed()) oStmtS.close();
				if(oStmtT != null) if(!oStmtT.isClosed()) oStmtT.close();
				if(oStmtCommit != null) if(!oStmtCommit.isClosed()) oStmtCommit.close();
				if(oConnS != null) if(!oConnS.isClosed()) oConnS.close();
				if(oConnT != null) if(!oConnT.isClosed()) oConnT.close();
			}
			catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		//oConMgr.closeAll();
	}

	public void batchUpdate() {
		long nTimeStart = System.currentTimeMillis();
		double dElapsedSec = 0.0;

		String sKeyValues[] = new String[_nBatchSize];
		Statement oStmtS = null;
		ResultSet oRs = null;
		
		PreparedStatement oStmtT  = null;
		Statement oStmtCommit = null;
		
		Connection oConnS = null;
		Connection oConnT = null;
		//===============================================================
		// set global variable for test only
		_sSourceTable = "ELOC2001.dbo.pricelist";
		_sTargetTable = "ELOC2001.dbo.mig_pricelist";
		_sSourceDB = "MP_DB";
		_sTargetDB = "MP_DB";
		//===============================================================
		_sSourceDB = "ANAL_DB"; _sSourceTable = "ANALSTORE.dbo.perf_pricelist";
		
		String strSqlS = String.format( "select --top 1000000  \r\n" +
				"  pl_modelno\r\n" + 
				", pl_vcode\r\n" + 
				", pl_category\r\n" + 
				", pl_goodsnm\r\n" + 
				", pl_price\r\n" + 
				", pl_url\r\n" + 
				", pl_note\r\n" + 
				", pl_srvflag\r\n" + 
				", pl_status\r\n" + 
				", pl_soldoutflag\r\n" + 
				", pl_soldoutdate\r\n" + 
				", pl_rightnleft\r\n" + 
				", pl_multicomment\r\n" + 
				", pl_imgurl\r\n" + 
				", pl_coupon\r\n" + 
				", pl_airconfeetype\r\n" + 
				", pl_account_yn\r\n" + 
				", pl_esstockflag\r\n" + 
				", pl_instance_price\r\n" + 
				", pl_finalusedflag\r\n" + 
				", pl_goodsfactory\r\n" + 
				", pl_goodscode\r\n" + 
				", pl_imgurlflag\r\n" + 
				", pl_deliveryinfo\r\n" + 
				", pl_freeinterest\r\n" + 
				", pl_nochange\r\n" + 
				", pl_agree_month\r\n" + 
				", pl_homeflag\r\n" + 
				", pl_price_card\r\n" + 
				", option_flag2\r\n" + 
				", catalog_flag\r\n" + 
				", pl_cashback\r\n" + 
				", pl_tag_price\r\n" + 
				", pl_call_plan\r\n" + 
				", pl_in_fee_yn\r\n" + 
				", pl_ship_fee_yn\r\n" + 
				", pl_bond_fee\r\n" + 
				", pl_penality_fee\r\n" + 
				", PRICE_FLAG\r\n" + 
				", pl_delivery_lev\r\n" + 
				", pl_set_yn\r\n" + 
				", pl_store_flag\r\n" + 
				", pl_ca_code_dept\r\n" + 
				", pl_mobile_flag\r\n" + 
				", pl_deliveryinfo2\r\n" + 
				", pl_deliverytype2\r\n" + 
				", pl_copyplno\r\n" + 
				", pl_mobile_url\r\n" + 
				", pl_authdate\r\n" + 
				", pl_date\r\n" + 
				", pl_bbs_num\r\n" + 
				", pl_no as update_key \r\n"
				+ "from %s a with(nolock) where /* pl_vcode=536 and */ (pl_no %% %d) = %d "
				, _sSourceTable, _nThreadCount, _nThreadNumber) ;
		
		String strSqlT1 = "UPDATE " + _sTargetTable + " \r\n SET ";
		String strSqlT2 = "\r\n where pl_no = ? ";
		
		System.out.println(String.format("Thread(%d) Start .....", _nThreadNumber));
		
		try {
			InputStream  input = new FileInputStream(_sDBConfigFile);
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnS = prop.getProperty(_sSourceDB);
			String sConnT = prop.getProperty(_sTargetDB);
			
			
			Class.forName("oracle.jdbc.driver.OracleDriver"); // for Oracle
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			oConnS = DriverManager.getConnection(sConnS);
			oConnT = DriverManager.getConnection(sConnT);

////			 for test packetsize
//			SQLServerDataSource ds1 = new SQLServerDataSource();
//			ds1.setServerName("100.100.100.195");
//			ds1.setDatabaseName("ELOC2001");
//			ds1.setUser("migadm");
//			ds1.setPassword("mig1020");
//			ds1.setPacketSize(8192);
//			oConnS = ds1.getConnection();
			
//			SQLServerDataSource ds2 = new SQLServerDataSource();
//			ds2.setServerName("100.100.100.195");
//			ds2.setDatabaseName("ELOC2001");
//			ds2.setUser("migadm");
//			ds2.setPassword("mig1020");
//			ds2.setPacketSize(12288);
//			oConnT = ds2.getConnection();
						
			oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(_nFetchSize);
			
			oRs = oStmtS.executeQuery(strSqlS);
			ResultSetMetaData oRsMeta = oRs.getMetaData(); 
			
			//update key를 제외한 컬럼에 대해서 set 구문 작성
			int nColumnCount = oRsMeta.getColumnCount();
			for(int i=1; i <= nColumnCount -1 ; i++) {
//				System.out.println(String.format("%d\t%s", oRsMeta.getColumnType(i), oRsMeta.getColumnTypeName(i)));
				strSqlT1 = strSqlT1 + oRsMeta.getColumnName(i) + " = ?,";
			}
			
			strSqlT1 = strSqlT1.substring(0, strSqlT1.length()-1)  
			           + strSqlT2.substring(0, strSqlT2.length() -1) ;
			
			oConnT.setAutoCommit(false);
			oStmtT = oConnT.prepareStatement(strSqlT1);
			oStmtCommit = oConnT.createStatement();
			
			System.out.format("Thread(%d) fetch start ...\n", _nThreadNumber);
			addWorkingCount(1);
			
			while(oRs.next()) {
				_nRows ++;
				
				//save last column(update key) for debugging
				sKeyValues[(int)(_nRows % _nBatchSize)] = oRs.getString(nColumnCount); 
				
				for(int i=1; i <= nColumnCount; i++) {
					//System.out.print(String.valueOf(i) + " ");
					switch (oRsMeta.getColumnType(i)) {
						//case java.sql.Types.ARRAY : 							break;
						case java.sql.Types.BIGINT:  	oStmtT.setLong(i, oRs.getLong(i));                   break;
						case java.sql.Types.BINARY:  	oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.BIT:        oStmtT.setBoolean(i, oRs.getBoolean(i));            break;
						case java.sql.Types.BLOB:		oStmtT.setBlob(i, oRs.getBlob(i));                  break;
						case java.sql.Types.BOOLEAN:    oStmtT.setBoolean(i, oRs.getBoolean(i));	        break;
						case java.sql.Types.CHAR:       oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.CLOB:       oStmtT.setClob(i,  oRs.getClob(i));                 break;
						case java.sql.Types.DATE:       oStmtT.setDate(i, oRs.getDate(i));	                break;
						case java.sql.Types.DECIMAL:    oStmtT.setBigDecimal(i,  oRs.getBigDecimal(i));     break;
						case java.sql.Types.DOUBLE:     oStmtT.setDouble(i,  oRs.getDouble(i));             break;
						case java.sql.Types.FLOAT:      oStmtT.setFloat(i,  oRs.getFloat(i));               break;
						case java.sql.Types.INTEGER:	oStmtT.setInt(i, oRs.getInt(i));                    break;
						case java.sql.Types.LONGNVARCHAR:  oStmtT.setString(i,  oRs.getString(i));             break;
						case java.sql.Types.LONGVARBINARY: oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.LONGVARCHAR:   oStmtT.setString(i, oRs.getString(i));           break;
						case java.sql.Types.NCHAR:       oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.NCLOB:      oStmtT.setClob(i,  oRs.getClob(i));                 break;
						case java.sql.Types.NUMERIC:    oStmtT.setBigDecimal(i,  oRs.getBigDecimal(i));     break;
						case java.sql.Types.NVARCHAR:   oStmtT.setString(i, oRs.getString(i));              break;
						case java.sql.Types.REAL:       oStmtT.setFloat(i,  oRs.getFloat(i));               break;
						//case java.sql.Types.ROWID:
						case java.sql.Types.SMALLINT:   oStmtT.setShort(i,  oRs.getShort(i));               break;
						//case java.sql.Types.SQLXML:
						case java.sql.Types.TIME:       oStmtT.setTime(i,  oRs.getTime(i));                 break;
						//case java.sql.Types.TIME_WITH_TIMEZONE: oStmtT.setTime(i,  oRs.getTime(i));                 break;
						case java.sql.Types.TIMESTAMP:  oStmtT.setTimestamp(i,  oRs.getTimestamp(i));                 break;
						//case java.sql.Types.TIMESTAMP_WITH_TIMEZONE: oStmtT.setTimestamp(i,  oRs.getTimestamp(i));                 break;
						case java.sql.Types.TINYINT:    oStmtT.setByte(i, oRs.getByte(i));                   break;
						case java.sql.Types.VARBINARY:  oStmtT.setBinaryStream(i, oRs.getBinaryStream(i));  break;
						case java.sql.Types.VARCHAR:    oStmtT.setString(i, oRs.getString(i));              break; 
						default :
							System.err.println("[WARNNING] Undifined Type " + oRsMeta.getColumnTypeName(i));
							oStmtT.setString(i, oRs.getString(i));  
							break;
					}

				}
				oStmtT.addBatch();
				oStmtT.clearParameters();
				if(_nRows % _nBatchSize == 0 ) {
					oStmtT.executeBatch();
					oStmtT.clearBatch();
					oStmtCommit.execute("commit with (delayed_durability=on)"); // for sql server
//					oStmtCommit.execute("commit write batch nowait"); // for oracle
//					oConnT.commit();
				}
				// 중간 결과 표시
//				if(_nRows % (10000) == 0) {
//					dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
//					System.out.println( String.format("RUN(%2d) : %10d Rows ...%7.0f rows/sec", _nThreadNumber, _nRows, _nRows / dElapsedSec));
//				}
			}
			
			if((_nRows % _nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				oStmtCommit.execute("commit with (delayed_durability=on)"); // for sql server
//				oStmtCommit.execute("commit write batch nowait"); // for oracle
//				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			System.out.println( String.format("# COMPLETE(%d) : total %d Rows, Sec: %.0f,  %.1f rows/sec"
					, _nThreadNumber, _nRows, dElapsedSec, _nRows / dElapsedSec));
//			_nTotalRows = _nTotalRows + _nRows;
			addTotalRows(_nRows);
			oStmtS.close();
			oStmtT.close();
			oStmtCommit.close();
		}
		catch (Exception ex) {
			System.err.println(String.format("RUN(%d)에서 오류 발생 ######################", _nThreadNumber));
			try {
				System.err.print("컬럼KEY : ");
				if(oRs != null) for (int i=0; i<_nBatchSize; i++) System.err.print(String.format("%s, ", sKeyValues[i]));
				System.err.println("");				
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			ex.printStackTrace();
			try {
				if(oStmtS != null) if(!oStmtS.isClosed()) oStmtS.close();
				if(oStmtT != null) if(!oStmtT.isClosed()) oStmtT.close();
				if(oStmtCommit != null) if(!oStmtCommit.isClosed()) oStmtCommit.close();
				if(oConnS != null) if(!oConnS.isClosed()) oConnS.close();
				if(oConnT != null) if(!oConnT.isClosed()) oConnT.close();
			}
			catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		//oConMgr.closeAll();
	}

	private void logStart() {
		System.out.println("logStart() .....");
		
		long nTimeStart = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		//lon_nRowsws = 0;
		
		Connection oConnL = null;
		CallableStatement oStmtL  = null;
		
		String sLogSQL1 = "{? = UP_MLOG_CREATE(@job_name = ?, @target_table = ?, @source_table = ?, @log_group = ?)}";
		String sLogSQL2 = "{UP_MLOG_START(@log_id = ?, @source_cnt = ?, @target_cnt = ?)}";
		String sCntSQL = "";
		
		
		try {
			InputStream  input = new FileInputStream(_sDBConfigFile);
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnL = prop.getProperty("LOG_MSSQL");
			String sConnS = prop.getProperty("SRC_ORACLE");
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Class.forName("oracle.jdbc.driver.OracleDriver"); // for Oracle
			oConnL = DriverManager.getConnection(sConnL);
			
			oStmtL = oConnL.prepareCall(sLogSQL1);
			oStmtL.registerOutParameter(1, java.sql.Types.BIGINT);
			oStmtL.setString(2, _sJobName);
			oStmtL.setString(3, _sTargetTable);
			oStmtL.setString(4, _sSourceTable);
			oStmtL.setString(5, _sLogGroup);
			oStmtL.execute();
			_nLogId = oStmtL.getLong(1);
			oStmtL.close();
			
			oStmtL = oConnL.prepareCall(sLogSQL2);
			oStmtL.setLong(1, _nLogId);
			oStmtL.setLong(2, _nSourceCount);
			oStmtL.setLong(3, _nTargetCount);
			oStmtL.execute();		
			oStmtL.close();
			
			oConnL.close();
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
			try {
				if (oStmtL != null) if (! oStmtL.isClosed()) oStmtL.close(); 
				if (oConnL != null) if (! oConnL.isClosed()) oConnL.close(); 
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
		
	private void logEnd(long nResultCount, String sResultCode, String sErrorCode, String sErrorMessage) {
			System.out.println("logEnd() .....");
			
			long nTimeStart = System.currentTimeMillis();
			double dElapsedSec = 0.0;
			//long nRows = 0;
			
			Connection oConnL = null;
			CallableStatement oStmtL  = null;
			
			String sLogSQL1;
			if (sResultCode=="") {
				sLogSQL1 = "{ UP_MLOG_END(@logid = ?, @result_cnt = ?)}";
			}
			else {
				sLogSQL1 = "{ UP_MLOG_END(@logid = ?, @result_cnt = ?, @res_code = ?, @error_code = ?, @error_msg = ?)}";
			}

			try {
				InputStream  input = new FileInputStream(_sDBConfigFile);
				Properties prop = new Properties();
				prop.load(input);
				
				String sConnL = prop.getProperty("LOG_MSSQL");
				
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//				Class.forName("oracle.jdbc.driver.OracleDriver"); // for Oracle
				oConnL = DriverManager.getConnection(sConnL);
				
				oStmtL = oConnL.prepareCall(sLogSQL1);
				oStmtL.setLong(1, _nLogId);
				oStmtL.setLong(2, nResultCount);
				if(sResultCode != "") {
					oStmtL.setString(3, sResultCode);
					oStmtL.setString(4, sErrorCode);
					oStmtL.setString(5, sErrorMessage);
				}
				
				oStmtL.execute();
				oStmtL.close();
				oConnL.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
				try {
					if (oStmtL != null) if (! oStmtL.isClosed()) oStmtL.close(); 
					if (oConnL != null) if (! oConnL.isClosed()) oConnL.close(); 
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}

	}

	public synchronized void addRunCount(int i) {
		_nRunCount += i;
	}
	
	public synchronized void addWorkingCount(int i) {
		_nWorkingCount += i;
	}
	
	public synchronized void addTotalRows(long nRows)
	{
		_nTotalRows = _nTotalRows + nRows;
	}
}
