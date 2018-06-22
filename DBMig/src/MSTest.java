

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;
//import com.microsoft.sqlserver.jdbc.*;

import java.io.FileInputStream;
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
public class MSTest extends Thread {
	private String _sSourceDB;
	private String _sTargetDB;
	private String _sSourceTable;
	private String _sTargetTable;
	private static long _nTotalCount=0;
	private static int _nThreadCount=0;
	private static int _nBatchSize = 10000; //5000;
	private static int _nFetchSize = 1000; //5000;
//	private static long _nRows = 500000; //500000;
//	private static long _nOffSetUnit = _nRows;

	private int _nThreadNumber;

//	@SuppressWarnings("unused")
	public static void main(String[] args) throws Exception {
//		test01(args);
		/*****************/
		long lStartTime = System.currentTimeMillis();
		long lSpotTime = lStartTime ;
		double dElapsedSec = 0.0;
		_nBatchSize = 5000;
		
		int nTotalCnt = 20;
		if (args.length > 0) {
			System.out.println(args[0]);
			nTotalCnt = Integer.valueOf(args[0]);
		}
		MSTest[] sample = new MSTest[nTotalCnt];
		
		for(int i=0; i < sample.length; i++) {
			sample[i] = new MSTest(i);
			sample[i].start();
			Thread.sleep(3000);
//			while (_nThreadCount >= 7 && i < sample.length) {
			if(i==0) {
				Thread.sleep(3000);
			}
		}
		for(int i=0; i < sample.length; i++) {
			sample[i].join();
		}
		dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
		long nRows = _nTotalCount;
		System.out.println( String.format("### END : %d Rows, Sec: %.0f,  %.1f rows/sec", nRows, dElapsedSec, nRows / dElapsedSec));
		
		/******************/
		
	}
	
	public MSTest(int threadNumber) {
		_nThreadNumber = threadNumber;
	}
	public void run() {
		test01();
	}
	
	private void test01() {
		System.out.println("ok 0");
		
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
		
		String strSqlS = "select * from tb_test1";
		String strSqlT1 = "insert into tb_test2(";
		String strSqlT2 = " values(";
		
		
		try {
			InputStream  input = new FileInputStream("conf/DBConfig.ini");
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnS = prop.getProperty("ANALSTORE");
			String sConnT = prop.getProperty("ANALSTORE");
			
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);
			
			Statement oCommitStmt = oConnT.createStatement(); // for manual commit with additional option
			
			if(_nThreadNumber == 0)
				oCommitStmt.execute("truncate table analstore.dbo.tb_test2");
			
			oConnT.setAutoCommit(false);

			oStmtS = oConnS.createStatement();
			oStmtS.setFetchSize(_nBatchSize);
			
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
				if(nRows % _nBatchSize == 0 ) {
					oStmtT.executeBatch();
					oStmtT.clearBatch();

					oCommitStmt.execute("commit with (delayed_durability=on)");
//					oConnT.commit();
					
					dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
					System.out.println( String.format("... Thread(%2d): %10d Rows ...%7.0f rows/sec", _nThreadNumber, nRows, nRows / dElapsedSec));
		
				}
			}
			
			if((nRows % _nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				
				oCommitStmt.execute("commit with (delayed_durability=on)");
//				oConnT.commit();
				
			}
			
			addCount(nRows);

			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			System.out.println( String.format("COMPLETE(%2d) : total %d Rows, Sec: %.0f,  %.1f rows/sec"
					, _nThreadNumber, nRows, dElapsedSec, nRows / dElapsedSec));

			oStmtS.close();
			oStmtT.close();	
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//oConMgr.closeAll();
	}

	public synchronized void addCount(long nRows)
	{
		_nTotalCount = _nTotalCount + nRows;
	}

}
