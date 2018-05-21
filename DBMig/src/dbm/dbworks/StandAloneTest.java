package dbm.dbworks;

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Properties;

//import dbm.db.dbpool.DBConnectionManager;
@SuppressWarnings({"unused"})
public class StandAloneTest extends Thread {
	private String _sSourceDB;
	private String _sTargetDB;
	private String _sSourceTable;
	private String _sTargetTable;
	private static int _nThreadCount=0;
	private int _nThreadNumber;

	public static void main(String[] args) {
		//test01(args);
		testORA(args);
//		int nCnt = 1;
//		if (args.length > 0) {
//			System.out.println(args[0]);
//			nCnt = Integer.valueOf(args[0]);
//		}
//		StandAloneTest[] sample = new StandAloneTest[nCnt];
//		for(int i=0; i < sample.length; i++) {
//			sample[i] = new StandAloneTest("MPDB_TEST", "DBADM.dbo.tb_test_pl", "ANALSTORE", "ANALSTORE.dbo.tb_test_pl2");
//		}
//		for(int i=0; i < sample.length; i++) {
//			sample[i].start();
//		}
		
	}
	public StandAloneTest() {
		_nThreadCount ++;
		_nThreadNumber = _nThreadCount;
	}
	public StandAloneTest(String sSourceDB, String sSourceTable, String sTargetDB, String sTargetTable) {
		this();
		setSource(sSourceDB, sSourceTable);
		setTarget(sTargetDB, sTargetTable);
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
		bulkCopy();
	}
	
	public void bulkCopy() {
		int nBatchSize = 1;//50000;
		int nFetchSize = 1;//5000;
		long nRows = 10;//500000;
		long lStartTime = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		
//		String sConnS = "jdbc:sqlserver://x.x.x.x:port;"
//				        + "databaseName=dbname;user=user;password=pass";
//		String sConnT = "jdbc:sqlserver://x.x.x.x:port;"
//				        + "databaseName=dbname;user=user;password=pass";
		InputStream  input = StandAloneTest.class.getClassLoader().getResourceAsStream("./conf/DBConfig.ini");
		Properties prop = new Properties();

		try {
			prop.load(input);
			
			String sConnS = prop.getProperty("MPDB_TEST");
			String sConnT = prop.getProperty("ANALSTORE");
			String strSqlS = String.format("select top (%d) * from %s", nRows,_sSourceTable);

			System.out.println(String.format("start(%d) ---------------------------------------------", _nThreadNumber));
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			//DBConnectionManager oConMgrS = new DBConnectionManager(_sSourceDB);
			//DBConnectionManager oConMgrT = new DBConnectionManager(_sTargetDB);
			//Connection oConnS = oConMgrS.getConnection();
			//Connection oConnT = oConMgrT.getConnection();
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);
			
			if (_nThreadNumber==1) {
				Statement oStmtT = oConnT.createStatement();
				oStmtT.execute("truncate table " + _sTargetTable);
				oStmtT.close();
			}
			Statement oStmtS = null;
			//PreparedStatement oStmtT  = null;
			//oStmtS = oConnS.createStatement();
			oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY
					                      , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(nFetchSize);
			
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			
			//SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(oConnT);
			SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(sConnT);
			SQLServerBulkCopyOptions copyOptions = new SQLServerBulkCopyOptions();
			copyOptions.setKeepIdentity(true);
			copyOptions.setBatchSize(nBatchSize);
			copyOptions.setTableLock(false);
			copyOptions.setBulkCopyTimeout(0);

			bulkCopy.setBulkCopyOptions(copyOptions);
			
			bulkCopy.setDestinationTableName(_sTargetTable);
			
			bulkCopy.writeToServer(oRs);
			
			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			System.out.println( String.format("COMPLETE(%d): total %d Rows, Sec: %.0f,  %.1f rows/sec", _nThreadNumber, nRows, dElapsedSec, nRows / dElapsedSec));
			
			bulkCopy.close();
			oRs.close();
			oConnS.close();
			oConnT.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	public static void testMSSQL(String[] args) {
		System.out.println("ok 0");
		
		int nBatchSize = 100;
		long lStartTime = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		long nRows = 0;
		
		//DBConnectionManager oConMgr = new DBConnectionManager("MPDB_TEST");
		System.out.println("ok 1");
		//Connection oConnS = oConMgr.getConnection();
		//Connection oConnT = oConMgr.getConnection();
		
		System.out.println("ok 2");
		
		Statement oStmtS = null;
		PreparedStatement oStmtT  = null;
		
		String strSqlS = "select * from dbadm.dbo.tb_test_pl";
		String strSqlT1 = "insert into dbadm.dbo.tb_test_pl2(";
		String strSqlT2 = "values(";
		
		InputStream  input = StandAloneTest.class.getClassLoader().getResourceAsStream("./conf/DBConfig.ini");
		Properties prop = new Properties();

		try {
			prop.load(input);
			
			String sConnS = prop.getProperty("MPDB_TEST");
			String sConnT = prop.getProperty("ANALSTORE");

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);
			oStmtS = oConnS.createStatement();
			oStmtS.setFetchSize(nBatchSize);
			
			oConnT.setAutoCommit(false);
			
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			ResultSetMetaData oRsMeta = oRs.getMetaData(); 
			
			for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
				//System.out.print(String.valueOf(i) + " ");
				System.out.println(String.format("%d\t%s", oRsMeta.getColumnType(i), oRsMeta.getColumnTypeName(i)));

				strSqlT1 = strSqlT1 + oRsMeta.getColumnName(i) + ",";
				strSqlT2 = strSqlT2 + "?,";
			}
			
			System.out.println("");
			strSqlT1 = strSqlT1.substring(0, strSqlT1.length()-1) + ") " 
			           + strSqlT2.substring(0, strSqlT2.length() -1) + ")";
			
			oStmtT = oConnT.prepareStatement(strSqlT1);
			System.out.println("sql:" + strSqlT1);
			
			while(oRs.next()) {
				nRows ++;
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
				if(nRows % nBatchSize == 0 ) {
					int[] nRet = oStmtT.executeBatch();
					for(int i=0; i<nRet.length; i++) {
						System.out.print(String.format(" %s,", nRet[i]));
					}
					System.out.println("");
					
					oStmtT.clearBatch();
					oConnT.commit();
					dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
					System.out.println( String.format("%10d Rows ...%7.0f rows/sec", nRows, nRows / dElapsedSec));
		
				}
			}
			
			if((nRows % nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			System.out.println( String.format("COMPLETE : total %d Rows, Sec: %.0f,  %.1f rows/sec", nRows, dElapsedSec, nRows / dElapsedSec));

			oStmtS.close();
			oStmtT.close();	
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//oConMgr.closeAll();
	}

	/**
	 * 
	 * @param args
	 */
	public static void testORA(String[] args) {
		System.out.println("ok 0");
		
		int nBatchSize = 4000;
		long lStartTime = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		long nRows = 0;
		int nCols=0;
		
		//DBConnectionManager oConMgr = new DBConnectionManager("MPDB_TEST");
		System.out.println("ok 1");
		//Connection oConnS = oConMgr.getConnection();
		//Connection oConnT = oConMgr.getConnection();
		
		System.out.println("ok 2");
		
		Statement oStmtS = null;
		PreparedStatement oStmtT  = null;
		
		String strSqlS  = "select * from dbadm.tb_test";
		String strSqlT1 = "update dbadm.tb_test2 set ";
		String strSqlT2 = "where rn = ? ";
		
		
		InputStream  input = StandAloneTest.class.getClassLoader().getResourceAsStream("./conf/DBConfig.ini");
		Properties prop = new Properties();

		try {
			prop.load(input);
			
			String sConnS = prop.getProperty("ENURI_TEST");
			String sConnT = prop.getProperty("ENURI_TEST");
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);
			oStmtS = oConnS.createStatement();
			oStmtS.setFetchSize(nBatchSize);
			
			oConnT.setAutoCommit(false);
			
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			ResultSetMetaData oRsMeta = oRs.getMetaData(); 
			
			for(int i=1; i <= oRsMeta.getColumnCount(); i++) {
				//System.out.print(String.valueOf(i) + " ");
				System.out.println(String.format("%d\t%s", oRsMeta.getColumnType(i), oRsMeta.getColumnTypeName(i)));

				strSqlT1 = strSqlT1 + oRsMeta.getColumnName(i) + " = ?,";
			}
			
			System.out.println("");
			strSqlT1 = strSqlT1.substring(0, strSqlT1.length() -1) + strSqlT2;
			
			oStmtT = oConnT.prepareStatement(strSqlT1);
			System.out.println("sql:" + strSqlT1);
			
			nCols = oRsMeta.getColumnCount();
			
			while(oRs.next()) {
				nRows ++;
				for(int i=1; i <= nCols; i++) {
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
				oStmtT.setInt(nCols+1, oRs.getInt(1)); // where conditions
				oStmtT.addBatch();
				if(nRows % nBatchSize == 0 ) {
					int[] nRet = oStmtT.executeBatch();
					for(int i=0; i<nRet.length; i++) {
						System.out.print(String.format(" %s,", nRet[i]));
					}
					System.out.println("");

					oStmtT.clearBatch();
					oConnT.commit();
					dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
					System.out.println( String.format("%10d Rows ...%7.0f rows/sec", nRows, nRows / dElapsedSec));
		
				}
			}
			
			if((nRows % nBatchSize) != 0) {
				int[] nRet = oStmtT.executeBatch();
				for(int i=0; i<nRet.length; i++) {
					System.out.print(String.format(" %s,", nRet[i]));
				}
				System.out.println("");

				oStmtT.clearBatch();
				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			System.out.println( String.format("COMPLETE : total %d Rows, Sec: %.0f,  %.1f rows/sec", nRows, dElapsedSec, nRows / dElapsedSec));

			oStmtS.close();
			oStmtT.close();	
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//oConMgr.closeAll();
	
	}
}