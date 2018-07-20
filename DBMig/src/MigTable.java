

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;
//import com.microsoft.sqlserver.jdbc.*;
//import dbm.dbworks.StandAloneTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.security.SecureRandom;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.DriverPropertyInfo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Scanner;
import java.util.Vector;
import java.util.logging.Logger;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
//import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;

//import dbm.db.dbpool.DBConnectionManager;

@SuppressWarnings({"unused"})
public class MigTable  {
	
	//usage : MigTable <xmlfile> <log_group>
	public static void main(String[] args) {
		if(args.length < 1) {
			args = new String[2];
			args[0] = "xmls/test_perf_pricelist.xml";
			args[1] = "debug";
		}
		migWork(args);
		
//		testJDBC();
	}
	
	public static void migWork(String[] args) {
		if(args.length < 1) {
			System.err.println("Usage : " + MigTable.class.getSimpleName() + " <xmlfile> [log_group_prefix]");
			return;
		}
		
		MigInfo migInfo = null;
		if(args.length > 0)	migInfo = new MigInfo(args[0]);
		if(args.length > 1) migInfo._sLogGroup = args[1];
		
		
		migInfo.toString();
		MigWorker[] migWorker = new MigWorker[migInfo._nThreadCount];
		try {
			
			long nTimeStart = System.currentTimeMillis();
			long nTimeCurrent = nTimeStart;
			long nTimeBefore = nTimeStart;
			double dElapsedSec = 0.0;
			double dTotalSec = 0.0;
			long nRowsCurrent = 0;
			long nRowsBefore = 0;
			
			for(int i=0; i < migInfo._nThreadCount; i++) {
				migWorker[i] = new MigWorker(migInfo);
				migWorker[i].start();
			}

			// 보고 간격(초)가 0 이상인 경우 보고간격 주기로 현황 출력
			//if(!migInfo._sInsertType.equalsIgnoreCase("bulk") && migInfo._nReportSec > 0) {
			if(migInfo._nReportSec > 0) {
				while (migInfo.getRunCount() > 0) {
					Thread.sleep(migInfo._nReportSec * 1000);
					nTimeCurrent = System.currentTimeMillis();
					dElapsedSec =  (nTimeCurrent - nTimeBefore) /1000.0;
					dTotalSec = (nTimeCurrent - nTimeStart) / 1000.0;
					nRowsCurrent = 0;
					for(int i=0; i < migWorker.length; i++) {
						nRowsCurrent += migWorker[i].getResultCount();
					}
					System.out.format("Running.%s[%d]:[%,d] %,d Rows(%.1f%%), +%,d,  %,.1f rows/sec (%02d:%02d:%02d)\n"
							        , migInfo._insertType.name().substring(0, 2)
									, migInfo.getRunCount() 
									, migInfo._nSourceCount
									, nRowsCurrent
									, migInfo._nSourceCount > 0 ? (double) nRowsCurrent / migInfo._nSourceCount * 100.0 : 0.0 
									, nRowsCurrent-nRowsBefore, (nRowsCurrent-nRowsBefore) / dElapsedSec
									, (int) dTotalSec / 3600, (int) (dTotalSec % 3600) / 60, (int)(dTotalSec % 60)
								);

					nTimeBefore = nTimeCurrent;
					nRowsBefore = nRowsCurrent;
				}	
			}
			else {
				// wait for completing all threads
				for(int i=0; i < migInfo._nThreadCount; i++) {
					migWorker[i].join();
				}
			}
			
			dTotalSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			nRowsCurrent = 0;
			for(int i=0; i < migWorker.length; i++) {
				nRowsCurrent += migWorker[i].getResultCount();
			}

			System.out.println( String.format("## END : Target %,d => Result %,d Rows(%d), Sec: %.0f,  %,.1f rows/sec (%02d:%02d:%02.1f)"
									, migInfo._nSourceCount, nRowsCurrent
									, (nRowsCurrent - migInfo._nSourceCount)
									, dTotalSec, nRowsCurrent / dTotalSec
									, (int) dTotalSec / 3600, (int) (dTotalSec % 3600) / 60, (dTotalSec % 60.0)
									)
					
					);
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		//migWorker.work();
		//logstart, run, logend
	}
	
	private static void testJDBC() {
		String strSql = "SELECT value$ FROM sys.props$ WHERE name = 'NLS_CHARACTERSET'";
		try (
				Connection oConn = new DBConnection("ENURI_DB").dbConnect();
				ResultSet oRs = oConn.createStatement().executeQuery(strSql);
		) {
			if(oRs.next()) {
				System.out.println("testJDBC() : " + oRs.getString(1));
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
}

//====================================================================================================//

class MigInfo {
	public enum COUNT_OPTION { ALL, SUB, SKIP }; 
	// all : 원본 건수를 전체 건수와 개별 작업단위의 건수를 모두 쿼리함 (기본)
	// sub : 개별 작업에서만 건수를 쿼리함 : 전체 건수는 개별 작업의 건수를 합산
	// skip : 건수를 조회하지 않음 : 건수검증 별도 시행
	public enum INSERT_TYPE { INSERT, BATCH, BULK}; // insert==batch, bulk(ms-sql bulkcopy)
	public enum DB_TYPE { ORACLE, MSSQL }
	
	public String _sLogGroup = "null";
	public String _sJobId;
	public String _sJobName;
//	public String _sInsertType = "batch";
	public INSERT_TYPE _insertType = INSERT_TYPE.INSERT;

	public String _sSourceDB;
	public String _sTargetDB;
	//public String _sTargetDBType;
	public DB_TYPE _targetDBType;
	public DB_TYPE _sourceDBType;
	
	public String _sSourceTable;
	public String _sTargetTable;
	public String _sLogDB;
	public String _sSelectList;
	public String _sSelectCount;
	public COUNT_OPTION _countOption = COUNT_OPTION.ALL;
	public String _sWhereCondition;
	public String _sSplitCondition;

	public int _nBatchSize = 100; //5000; default
	public int _nFetchSize = 100; //5000; default
	public int _nReportSec = 10;  // 실행 보고 간격(초)

	public long _nSourceCount;

	public int _nThreadCount=0;
	private int _nRunCount = 0;
	private long _nTotalRows = 0; //500000;
	
//	private String _sMigConfigDir = "xmls";
	private String _sMigConfigFile = "";
	
	public MigInfo(String sXmlFile) {
//		_sMigConfigFile = _sMigConfigDir + "/" + sXmlFile;
		_sMigConfigFile = sXmlFile;
		getXmlConfig(_sMigConfigFile);
		_nSourceCount = getSourceCount();
	}
	
	//대상 원본 건수를 증가시킴 : 대상건수를 쿼리하지 않고, Worker에서 쿼리한 TargetCount를 합산할 때 사용
	public synchronized void addSourceCount(long nRows) {
		_nSourceCount += nRows;
	}

	//처리된 전체 행수를 입력값 만큼 증가시킴
	public synchronized void addTotalRows(long nRows) {
		_nTotalRows += nRows;
	}
	
	public long getTotalRows() { return _nTotalRows;}
	public int getRunCount() { return _nRunCount;}
	
	// 쓰레드의 생성 갯수를 증가시키고, 증가된 쓰레드 수를 반환함
	public synchronized int addRunCount() {
		_nRunCount ++;
		return _nRunCount;
	}

	public synchronized int reduceRunCount() {
		_nRunCount --;
		return _nRunCount;
	}
	
	// 생성할 쓰레드 수를 설정함(XML 설정값을 바꾸고자 할 경우)
	public void setThreadCount(int nThreadCount) {
		_nThreadCount = nThreadCount;
	}
	
	public String toString() {
		String sResult = String.format("\n\n============ MigInfo(%s) ============ \r\n" +
				"Insert Type  : %s, Threads = %d \r\n" +
				"JobId=%s, JobName=%s \r\n" +
				"Target DB    : %s (%s) \r\n" +
				"Target Table : %s \r\n" +
				"Source DB    : %s (%s) \r\n" +
				"Source Table : %s \r\n" +
				"== Select ==: %s \r\n" +
				"== Split   ==: %s \r\n=====================================" 
				, this.getClass().getSimpleName()
				, _insertType.name(), _nThreadCount
				, _sJobId, _sJobName
				, _sTargetDB, _targetDBType.toString()
				, _sTargetTable
				, _sSourceDB, _sourceDBType.toString()
				, _sSourceTable
				, _sSelectList.trim()
				, _sSplitCondition.trim());
		System.out.println(sResult);
		return sResult;

	}
	
	public String getXmlConfig(String sXmlFile) 
	{
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(sXmlFile);
		    
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
//		    XPathExpression expr = xpath.compile(sNodePath + "/text()");
		    Element element = (Element) xpath.evaluate("/migration", doc, XPathConstants.NODE);
		    _sJobId = element.getAttribute("jobid");
		    _sJobName = element.getAttribute("jobname").trim();
		    String sInsertType = element.getAttribute("type");
		    try {
		    	_insertType = INSERT_TYPE.valueOf(sInsertType.toUpperCase().trim());
		    }
		    catch (Exception ex) {
		    	System.err.format("INSERT_TYPE %s is invalid ... using default : INSERT\n", sInsertType);
		    	_insertType = INSERT_TYPE.INSERT;
		    }
		    _nThreadCount = Integer.valueOf(element.getAttribute("threads"));
		    _nBatchSize = Integer.valueOf(element.getAttribute("batchsize"));
		    _nFetchSize = Integer.valueOf(element.getAttribute("fetchsize"));
		    _nReportSec = Integer.valueOf(element.getAttribute("reportsec"));
		    
		    _sTargetDB =    ((Element)xpath.evaluate("/migration/target/dbname", doc, XPathConstants.NODE)).getTextContent().trim();
		    _sTargetTable = ((Element)xpath.evaluate("/migration/target/table", doc, XPathConstants.NODE)).getTextContent().trim();
		    String sDBType="";
		    try {
		    	sDBType = ((Element)xpath.evaluate("/migration/target/dbname", doc, XPathConstants.NODE)).getAttribute("type").trim();
		    	_targetDBType = DB_TYPE.valueOf(sDBType.toUpperCase());
		    }
		    catch (Exception ex ) {
		    	System.err.format("Target DB_TYPE %s is invalid ... using default : MSSQL\n", sDBType);
		    	_targetDBType = DB_TYPE.MSSQL;
		    }

		    _sSourceDB =    ((Element)xpath.evaluate("/migration/source/dbname", doc, XPathConstants.NODE)).getTextContent().trim();
		    _sSourceTable = ((Element)xpath.evaluate("/migration/source/table", doc, XPathConstants.NODE)).getTextContent().trim();
		    try {
		    	sDBType = ((Element)xpath.evaluate("/migration/source/dbname", doc, XPathConstants.NODE)).getAttribute("type").trim();
		    	_sourceDBType = DB_TYPE.valueOf(sDBType.toUpperCase());
		    }
		    catch (Exception ex ) {
		    	System.err.format("Source DB_TYPE %s is invalid ... using default : MSSQL\n", sDBType);
		    	_sourceDBType = DB_TYPE.MSSQL;
		    }

		    _sLogDB =       ((Element)xpath.evaluate("/migration/logdb", doc, XPathConstants.NODE)).getTextContent().trim();
		    
		    _sSelectCount    = ((Element)xpath.evaluate("/migration/count", doc, XPathConstants.NODE)).getTextContent().trim();
		    String sCountOption = ((Element)xpath.evaluate("/migration/count", doc, XPathConstants.NODE)).getAttribute("option");
		    try {
		    	_countOption = COUNT_OPTION.valueOf(sCountOption.toUpperCase().trim());
		    } catch (Exception ex) {
		    	System.err.format("Count Option %s is invalid ... using default : ALL\n", sCountOption);
		    	_countOption = COUNT_OPTION.ALL;
		    }		    
		    _sSelectList     = ((Element)xpath.evaluate("/migration/select", doc, XPathConstants.NODE)).getTextContent().trim();
		    _sWhereCondition = ((Element)xpath.evaluate("/migration/where", doc, XPathConstants.NODE)).getTextContent().trim();
		    _sSplitCondition = ((Element)xpath.evaluate("/migration/split", doc, XPathConstants.NODE)).getTextContent().trim();

//		    NodeList nodes = doc.getElementsByTagName("target").item(0).getChildNodes();
//		    for(int i=0, size = nodes.getLength(); i < size; i++) {
//		    	System.out.println("-- " + nodes.item(i).getNodeName());
//		    }
//	
//		    NodeList nodeList = doc.getElementsByTagName("migration");
//		    NamedNodeMap nodeMap = nodeList.item(0).getAttributes();
//		    for(int i=0, size=nodeList.getLength(); i<size; i++) {
//		    	for(int j=0; j < nodeList.item(i).getAttributes().getLength(); j++) {
//		    		System.out.println(nodeList.item(i).getAttributes().item(j).getNodeValue());
//		    	}
//	//	    	System.out.println(nodeList.item(i).getAttributes().item(0).getNodeValue());
//		    	System.out.println(String.format("node=%s, value=%s"
//		    			           , nodeList.item(i).getNodeName(), nodeList.item(i).getNodeValue()));
//		    }
		    
		}
		catch (Exception e) {
			System.err.println("getXmlConfig():ERROR: " + e.getMessage());
			e.printStackTrace();
			System.exit(1);
		}
		//System.out.println("debug:"+ connName + ","+ cfgName + "= NULL");
	    return null;

	}
	
	private long getSourceCount() {
		if (_countOption == COUNT_OPTION.SKIP ) {
			return -1;
		}
		else if(_countOption == COUNT_OPTION.SUB) {
			return 0;
		}
		
		long nSourceCount = -1;
		String sSqlCount = String.format("%s\r\n from %s\r\n %s", _sSelectCount, _sSourceTable , _sWhereCondition);
//		System.out.println("getSourceCount() : sql =  " + sSqlCount);
		try (
				Connection oConn = (new DBConnection(_sSourceDB)).dbConnect();
				Statement oStmt = oConn.createStatement();
		) {
			ResultSet oRs = oStmt.executeQuery(sSqlCount);
			if(oRs.next()) {
				nSourceCount = oRs.getLong(1);
			}
			oRs.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
//		System.out.println(String.format("getSourceCount() : count = %d rows", nSourceCount));
		
		return nSourceCount;		
	}

}

class MigWorker extends Thread {
	private MigInfo _migInfo;
	
	private long _nLogId;
	private int _nThreadNumber = 0;
	private int _nBatchSize = 100;
	private int _nFetchSize = 100;
	private long _nTargetCount = 0;
	private long _nResultCount = 0;
	private String _sResultCode = "";
	private String _sErrorCode = "";
	private String _sErrorMessage = "";

	BulkResultSet bulkRowSet;
	Connection _oConnSource;
	Connection _oConnTarget;
	
	public MigWorker(MigInfo migInfo) {
		_migInfo = migInfo;
		_nThreadNumber = _migInfo.addRunCount() - 1;
		_nBatchSize = _migInfo._nBatchSize;
		_nFetchSize = _migInfo._nFetchSize;
		System.out.println(String.format("MigWorker(%d) ..... created", _nThreadNumber));
	}
	public void dbConnect() {
		_oConnSource = new DBConnection(_migInfo._sSourceDB).dbConnect();
		_oConnTarget = new DBConnection(_migInfo._sTargetDB).dbConnect();
	}
	public void dbClose() {
		try {
			if(_oConnSource  != null) if(!_oConnSource.isClosed()) _oConnSource.close();
			if(_oConnTarget  != null) if(!_oConnTarget.isClosed()) _oConnTarget.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public void setThreadNumber(int nThreadNumber) {
		_nThreadNumber = nThreadNumber;
	}
	
	public long getResultCount() {
		if(bulkRowSet != null) { 
			return bulkRowSet.getRowCount();
		}
		else {
			return _nResultCount;
		}
	}
	
	@Override
	public void run() {
		System.out.println(String.format("MigWorker(%d) ..... run start", _nThreadNumber));
		dbConnect();
		logStart();
		
		if(_migInfo._insertType == MigInfo.INSERT_TYPE.BULK) {
			bulkInsert();
		}
		else {
			batchInsert();
		}
		_migInfo.reduceRunCount();

		logEnd();
		dbClose();
		
		System.out.println(String.format("MigWorker(%d) ..... run end", _nThreadNumber));
	}
	
	private void bulkInsert() {
		long nTimeStart = System.currentTimeMillis();
		long nSpotTimeBefore = nTimeStart ;
		double dElapsedSec = 0.0;

		String strSqlS = String.format("%s\r\n from %s\r\n %s\r\n %s\r\n"
				, _migInfo._sSelectList
				, _migInfo._sSourceTable
				, _migInfo._sWhereCondition 
				, _migInfo._sSplitCondition
						.replace("@TOTAL", String.valueOf(_migInfo._nThreadCount))
						.replace("@PART",  String.valueOf(_nThreadNumber))
		);
		
//		System.out.println("bulkInsert() SQL: " + strSqlS);

		try (
//				Connection oConnS = (new DBConnection(_migInfo._sSourceDB)).dbConnect();
//				Connection oConnT = (new DBConnection(_migInfo._sTargetDB)).dbConnect();
				Statement oStmtS = _oConnSource.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
//				Statement oStmtT = _oConnTarget.createStatement();
		) 
		{
			oStmtS.setFetchSize(_nFetchSize);
			
			System.out.println(String.format("Query Start (%d) .... ", _nThreadNumber));
			nSpotTimeBefore = System.currentTimeMillis();
			
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			bulkRowSet = new BulkResultSet(oRs, _migInfo._sourceDBType == MigInfo.DB_TYPE.ORACLE);
			
			dElapsedSec =  (System.currentTimeMillis() - nSpotTimeBefore) /1000.0;
			System.out.println(String.format("Fetch Start (%d) .... %.1f sec", _nThreadNumber, dElapsedSec));

			//SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(oConnT);
//			oConnT.setCatalog("ANALSTORE");
			
			SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(_oConnTarget);
			SQLServerBulkCopyOptions copyOptions = new SQLServerBulkCopyOptions();
			copyOptions.setKeepIdentity(true);
			copyOptions.setBatchSize(_nBatchSize);
			copyOptions.setTableLock(false);  // true 일때 동시 작업시 LOCK 경함 현상 발생
			copyOptions.setBulkCopyTimeout(0);

			bulkCopy.setBulkCopyOptions(copyOptions);
			
			bulkCopy.setDestinationTableName(_migInfo._sTargetTable);
			
			bulkCopy.clearColumnMappings();
			ResultSetMetaData oRsMeta = oRs.getMetaData();
			for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
//				bulkCopy.addColumnMapping(oRsMeta.getColumnName(i), oRsMeta.getColumnName(i).toLowerCase());
				bulkCopy.addColumnMapping(i, oRsMeta.getColumnName(i));
//				System.out.println("col mapping : " + oRsMeta.getColumnName(i) + " -> " + oRsMeta.getColumnName(i).toLowerCase());
			}
			
			try {
//				oStmtT.execute("DBCC TRACEON(7307)");
//				bulkCopy.writeToServer(oRs);
				bulkCopy.writeToServer(bulkRowSet);
				bulkCopy.close();
//				oStmtT.execute("DBCC TRACEOFF(7307)");
			}
			catch (Exception ex) {
				_sResultCode = "ERROR";
				_sErrorCode = ex.getClass().getSimpleName();
				_sErrorMessage =ex.getMessage();
				System.err.format("RUN(%d)에서 오류 발생 ######################\n", _nThreadNumber);
				System.err.println(bulkRowSet.toString());
				ex.printStackTrace();
			}
			
			_nResultCount = bulkRowSet.getRowCount(); //_nTargetCount;
			dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			System.out.format("# COMPLETE(%d): %d, %d Rows(%d), Sec: %.0f,  %.1f rows/sec\n"
					, _nThreadNumber
					, _nTargetCount, _nResultCount, (_nTargetCount - _nResultCount)
					, dElapsedSec, _nResultCount / dElapsedSec);
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	
	private void batchInsert() {
		System.out.format("batchInsert(%d) .... start\n", _nThreadNumber);
		long nTimeStart = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		//long nRows = 0;
		String sKeyValues[] = new String[_migInfo._nBatchSize];
		Statement oStmtS = null;
		ResultSet oRs = null;
		
		PreparedStatement oStmtT  = null;
		Statement oStmtCommit = null;
		
		Connection oConnS = _oConnSource;
		Connection oConnT = _oConnTarget;
		
		String strSqlS = String.format("%s\r\n from %s\r\n %s\r\n %s"
				, _migInfo._sSelectList
				, _migInfo._sSourceTable
				, _migInfo._sWhereCondition 
				, _migInfo._sSplitCondition
						.replace("@TOTAL", String.valueOf(_migInfo._nThreadCount))
						.replace("@PART",  String.valueOf(_nThreadNumber))
		);
		
		String strSqlT1 = "insert into " + _migInfo._sTargetTable + "(";
		String strSqlT2 = " values(";
		
		String strCommit = "commit write batch nowait"; //for oracle 
		
		if(_migInfo._targetDBType == MigInfo.DB_TYPE.MSSQL) {
			strCommit ="commit with (delayed_durability=on)"; // for mssql
		}
		
		try {
//			oConnS = (new DBConnection(_migInfo._sSourceDB)).dbConnect();
//			oConnT = (new DBConnection(_migInfo._sTargetDB)).dbConnect();
			oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(_nFetchSize);
			
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
				_nResultCount ++;
//				sKeyValues[(int)(_nResultCount -1) % _nBatchSize)] = oRs.getString(1);
				
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
				oStmtT.clearParameters();

				if(_nResultCount % _nBatchSize == 0 ) {
					oStmtT.executeBatch();
					oStmtT.clearBatch();
					oStmtT.clearParameters();
					oStmtCommit.execute(strCommit); // for oracle
//					oConnT.commit();
				}
//				if(_nResultCount % (100000) == 0) {
//					dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
//					System.out.println( String.format("RUN(%d) : %10d Rows ...%7.0f rows/sec", _nThreadNumber, _nResultCount, _nResultCount / dElapsedSec));
//				}
			}
			
			if((_nResultCount % _nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				oStmtT.clearParameters();
				oStmtCommit.execute(strCommit); // for oracle
//				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - nTimeStart) /1000.0;
			System.out.format("# COMPLETE(%d) : %d, %d Rows(%d), Sec: %.0f,  %.1f rows/sec\n"
					, _nThreadNumber
					, _nTargetCount,  _nResultCount, (_nTargetCount - _nResultCount)
					, dElapsedSec, _nResultCount / dElapsedSec);
//			_nTotalRows = _nTotalRows + _nRows;
			_migInfo.addTotalRows(_nResultCount);
			oStmtS.close();
			oStmtT.close();
			oStmtCommit.close();
		}
		catch (Exception ex) {
			_sResultCode = "ERROR";
			_sErrorCode = ex.getClass().getSimpleName();
			_sErrorMessage = ex.getMessage();

			System.err.format("RUN(%d)에서 오류 발생 ######################", _nThreadNumber);
			System.out.println("SRC SQL: " + strSqlS);
			try {
				System.err.print("컬럼(1)값 : ");
				if(oRs != null) for (int i=0; i< sKeyValues.length; i++) System.err.format("%s, ", sKeyValues[i]);
				System.err.println("");				
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			ex.printStackTrace();
			try {
				if(oStmtS != null) if(!oStmtS.isClosed()) oStmtS.close();
				if(oStmtT != null) if(!oStmtT.isClosed()) oStmtT.close();
				if(oStmtCommit != null) if(!oStmtCommit.isClosed()) oStmtCommit.close();
//				if(oConnS != null) if(!oConnS.isClosed()) oConnS.close();
//				if(oConnT != null) if(!oConnT.isClosed()) oConnT.close();
			}
			catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**
	 * skip 설정값이 all일 경우 생략, sub일 경우 MigInfo의 전체 소스 건수와 동일하게 설정
	 * @return
	 */
	private long getTargetCount() {
		if(_migInfo._countOption == MigInfo.COUNT_OPTION.SKIP) {
			_nTargetCount = -1;
		}
		else {
			
			if(_oConnSource == null) dbConnect();
			
			Connection oConn = _oConnSource;
			try (	
					//Connection oConn = (new DBConnection(_migInfo._sSourceDB)).dbConnect();
					Statement oStmt = oConn.createStatement();
			)
			{
				String sSQLCount = String.format("%s\r\n from %s\r\n %s\r\n %s"
						, _migInfo._sSelectCount, _migInfo._sSourceTable, _migInfo._sWhereCondition, _migInfo._sSplitCondition);
				sSQLCount = sSQLCount.replace("@TOTAL", String.valueOf(_migInfo._nThreadCount)).replace("@PART", String.valueOf(_nThreadNumber));
				// get Source table row count
//				System.out.println("getTargetCount() : SQL: " + sSQLCount);
				ResultSet oRs = oStmt.executeQuery(sSQLCount);
				if(oRs.next()) {
					_nTargetCount = oRs.getLong(1);
				}
				else {
					System.out.format("RUN(%d) ERROR at getTargetCount() : count sql no result\n", _nThreadNumber);
				}
				oStmt.close();
				oRs.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
				dbClose();
				System.exit(1);
			}
			
			if(_migInfo._countOption == MigInfo.COUNT_OPTION.SUB) {
				_migInfo.addSourceCount(_nTargetCount);
			}
		}
		return _nTargetCount;
	}
	
	private void logStart() {
		//System.out.println(String.format("logStart(%d) .....", _nThreadNumber));

		String sSQLId = "select sq_mig_log.nextval from dual";
		String sSQLP = "insert into tb_mig_log(log_id, log_group, job_id, job_name, target_table, source_table, source_cnt, target_cnt, status, start_time, log_time) "
				     + " values(?,?,?,?,?,?,?,?,'RUNNING', sysdate, sysdate)";
		Connection oConnL = null;
		Statement  oStmt = null;
		PreparedStatement oPStmt = null;
		
		try {
			oConnL = (new DBConnection(_migInfo._sLogDB)).dbConnect();
			oStmt = oConnL.createStatement();
			ResultSet oRs = oStmt.executeQuery(sSQLId);
			
			if(oRs.next()) {
				_nLogId = oRs.getLong(1);
			}
			else {
				System.out.format("RUN(%d)의  logStart()에서 오류 발생 : LogID 생성 오류", _nThreadNumber);
				oRs.close();
				oStmt.close();
				oConnL.close();
				this.dbClose();
				System.exit(1);
			}
			oRs.close();
			oStmt.close();

			getTargetCount();
			
			oPStmt = oConnL.prepareStatement(sSQLP);
			oPStmt.setLong(1,  _nLogId);
			oPStmt.setString(2, String.format("%s(%02d)", _migInfo._sLogGroup, _nThreadNumber));
			oPStmt.setString(3, _migInfo._sJobId);
			oPStmt.setString(4, _migInfo._sJobName);
			oPStmt.setString(5, _migInfo._sTargetTable);
			oPStmt.setString(6, _migInfo._sSourceTable);
			oPStmt.setLong(7,  _migInfo._nSourceCount);
			oPStmt.setLong(8,  _nTargetCount);
			//oPStmt.setString(7, "RUNNING");
			
			oPStmt.executeUpdate();
			
			oStmt.close();
			oPStmt.close();
			oConnL.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
			try {
				if (oStmt != null) if (! oStmt.isClosed()) oStmt.close(); 
				if (oPStmt != null) if (! oPStmt.isClosed()) oPStmt.close(); 
				if (oConnL != null) if (! oConnL.isClosed()) oConnL.close(); 
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	private void logEnd() {
		//System.out.println(String.format("logEnd(%d) .....", _nThreadNumber));
		String sSQLP = "update tb_mig_log set status = 'END' "
				+ ", res_code=?, result_cnt = ? "
				+ ", error_code=?, error_msg=? "
				+ ", end_time=sysdate, log_time=sysdate "
				+ ", source_cnt = ? " // count option sub인 경우 source_cnt를 최종 것으로 다시 반영해야함
				+ " where log_id=? ";
		Connection oConnL = null;
		PreparedStatement oPStmt = null;
		
		if(_sResultCode == "") {
			if(_sErrorCode != "") {
				_sResultCode = "ERROR";
			}
			// target count가 -1인 경우 건수 검증을 skip함, 0보다 크거나 같은 경우 건수 검증함
			else if(_nTargetCount >= 0 && _nTargetCount != _nResultCount) {
				_sResultCode = "FAIL";
			}
			else {
				_sResultCode = "SUCCESS";
			}
		}
		
		try {
			oConnL = (new DBConnection(_migInfo._sLogDB)).dbConnect();
			oPStmt = oConnL.prepareStatement(sSQLP);
			oPStmt.setString(1,  _sResultCode);
			oPStmt.setLong  (2, _nResultCount);
			oPStmt.setString(3, _sErrorCode);
			oPStmt.setString(4, _sErrorMessage);
			oPStmt.setLong  (5, _migInfo._nSourceCount);
			oPStmt.setLong  (6, _nLogId);
			
			oPStmt.executeUpdate();

			oPStmt.close();
			oConnL.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
			try {
				if (oPStmt != null) if (! oPStmt.isClosed()) oPStmt.close(); 
				if (oConnL != null) if (! oConnL.isClosed()) oConnL.close(); 
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}

class DBConnection {
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
	}
	
	public String getConnectionName() { return _sConnName; }
	public Connection getConnection() { return _oConn; }
	
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
	@SuppressWarnings("unused")
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

class Encryption
{
	//16bytes Key
	final static String DBM_SEC_KEY = "DBMSSecretKey091";
	
	public static String encrypt(String strClearText) 
	{
		try 
		{
			return encrypt(DBM_SEC_KEY, strClearText);
		} 
		catch (Exception e)
		{
			e.printStackTrace();
			return "";
		}
	}
	public static String decrypt(String strEncrptedText) 
	{
		try 
		{
			return decrypt(DBM_SEC_KEY, strEncrptedText);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return "";
		}
	}
	private static String encrypt(String strSeed, String strClearText) throws Exception 
	{
		//byte[] byteEncypted = encrypt(strSeed, strClearText.getbuff());
		//return byteToHex(byteEncrypted);
		
		String strAlgorithm = "AES";
		SecretKeySpec keySpec =  getSecretKeySpec(strSeed, strAlgorithm);
		Cipher secCipher = Cipher.getInstance(strAlgorithm);
		secCipher.init(Cipher.ENCRYPT_MODE, keySpec);
		byte[] byteEncrypted = secCipher.doFinal(strClearText.getBytes());
		
		return bytesToHex(byteEncrypted);		
	}
	
	private static String decrypt(String strSeed, String strEncryptedText) throws Exception 
	{
		String strAlgorithm = "AES";
		SecretKeySpec keySpec =  getSecretKeySpec(strSeed, strAlgorithm);
		Cipher secCipher = Cipher.getInstance(strAlgorithm);
		secCipher.init(Cipher.DECRYPT_MODE, keySpec);
		byte[] byteEnctyped = hexToBytes(strEncryptedText);
		
		byte[] byteDecrypted = secCipher.doFinal(byteEnctyped);
		return new String(byteDecrypted);
	}
	
	private static SecretKeySpec getSecretKeySpec(String strSeed, String strAlgorithm) throws Exception
	{
		return new SecretKeySpec(strSeed.getBytes(), strAlgorithm);		
	}
	
	// sometimes error occured.
	@SuppressWarnings("unused")
	private static SecretKeySpec getSecretKeySpec2(String strSeed, String strAlgorithm) throws Exception
	{
		byte[] bytSeed = strSeed.getBytes();
		KeyGenerator keyGen = KeyGenerator.getInstance(strAlgorithm);
		SecureRandom secRand = SecureRandom.getInstance("SHA1PRNG");
		secRand.setSeed(bytSeed);
		keyGen.init(128, secRand);
		SecretKey secKey = keyGen.generateKey();
		return new SecretKeySpec(secKey.getEncoded(), strAlgorithm);		
	}
	private final static String HEX = "0123456789ABCDEF";
	private static String bytesToHex(byte[] buff) 
	{
		if(buff == null) 
		{
			return "";
		}
		
		StringBuffer sb = new StringBuffer(buff.length *2);
		for(int i=0; i < buff.length; i++)
		{
			sb.append(HEX.charAt((buff[i] >> 4) & 0x0f)).append(HEX.charAt( buff[i] & 0x0f));
		}
		
		return sb.toString();
		/*
		 *
		 
		String strHex;
		for( int i=0 ; i < buff.length; i++) 
		{
			strHex = "0" + Integer.toHexString(0xff & buff[i]);
			sb.append(strHex.substring(strHex.length()-2));
		}
		*/
	}
	private static byte[] hexToBytes(String strHex) {
		byte[] bytesResult = new byte[strHex.length()/2];
		
		for(int i = 0; i < bytesResult.length; i++)
		{
			bytesResult[i] = Integer.valueOf(strHex.substring(i*2, i*2+2),16).byteValue();
		}
		
		return bytesResult;
	}

	@SuppressWarnings("unused")
	private static byte[] hexToBytes2(String strHex) {
		int nLen = strHex.length();
		byte[] bytesResult = new byte[nLen/2];
		
		for(int i = 0; i < nLen; i+=2)
		{
			bytesResult[i/2] = (byte)((Character.digit(strHex.charAt(i),  16) << 4) 
					                   + Character.digit(strHex.charAt(i+1), 16));
		}
		
		return bytesResult;
	}

	public static void main(String[] args) {
		if(args.length < 1) 
		{
			System.out.println("usage: java dbm.utils.Encryption [text to encrypt] or [-D text to decrypt]");
			System.out.print("Enter password :");
			
			Scanner scan= new Scanner(System.in);
			String str1 = scan.nextLine();
			scan.close();
			String str2 = encrypt(str1);
			System.out.println("[" + decrypt(str2) + "]");
			System.out.println(str2);
			return;
		}
		try {
			if (args[0].equalsIgnoreCase("-D")) 
			{
				String str1 = args[1];
				System.out.println(decrypt(str1));
			} 
			else 
			{
				String str1 = args[0];
				String str2 = encrypt(str1);
				System.out.println(decrypt(str2));
				System.out.println(str2);
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}

}