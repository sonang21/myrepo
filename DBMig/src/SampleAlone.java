

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;
//import com.microsoft.sqlserver.jdbc.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

//import dbm.db.dbpool.DBConnectionManager;

@SuppressWarnings({"unused"})
public class SampleAlone extends Thread {
	private String _sSourceDB;
	private String _sTargetDB;
	private String _sSourceTable;
	private String _sTargetTable;
	private static int _nTotalCount=0;
	private static int _nThreadCount=0;
	private static int _nBatchSize = 5000; //5000;
	private static int _nFetchSize = 1000; //5000;
	private static long _nRows = 500000; //500000;
	private static long _nOffSetUnit = _nRows;

	private int _nThreadNumber;
	
//	@SuppressWarnings("unused")
	public static void main(String[] args) throws Exception {
		//test01(args);
		/*****************/
		long lStartTime = System.currentTimeMillis();
		long lSpotTime = lStartTime ;
		double dElapsedSec = 0.0;
		
		int nTotalCnt = 1;
		if (args.length > 0) {
			System.out.println(args[0]);
			nTotalCnt = Integer.valueOf(args[0]);
		}
		SampleAlone[] sample = new SampleAlone[nTotalCnt];
		
		for(int i=0; i < sample.length; i++) {
			sample[i] = new SampleAlone("MPDB_TEST", "ELOC2001.dbo.pricelist"
					                 , "ANALSTORE", "ANALSTORE.dbo.tb_test_pl");
			sample[i].start();
			Thread.sleep(3000);
			while (_nThreadCount >= 7 && i < sample.length) { 
				Thread.sleep(3000);
			}
		}
		for(int i=0; i < sample.length; i++) {
			sample[i].join();
		}
		dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
		long nRows = _nRows * _nTotalCount;
		System.out.println( String.format("### END : %d Rows, Sec: %.0f,  %.1f rows/sec", nRows, dElapsedSec, nRows / dElapsedSec));
		
		/******************/
		
	}
	public SampleAlone() {
		_nTotalCount ++;
		_nThreadCount ++;
		_nThreadNumber = _nTotalCount;
	}
	public SampleAlone(String sSourceDB, String sSourceTable, String sTargetDB, String sTargetTable) {
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
		long lStartTime = System.currentTimeMillis();
		long lSpotTime = lStartTime ;
		double dElapsedSec = 0.0;
		
		String sConnS = "jdbc:sqlserver://x.x.x.x:1433;"
				        + "databaseName=db;user=user;password=pass";
		String sConnT = "jdbc:sqlserver://x.x.x.x:1433;"
		                + "databaseName=db;user=user;password=pass";
		
//		String strSqlS = String.format("select * from %s "
//				                     + " where pl_delivery_lev > '°¡' "  //9453027, 9340239
//				                     //+ " order by pl_no "
//				                     //+ " offset %d rows fetch next %d rows only"
//				                       ,_sSourceTable);
//									 // ,_sSourceTable, _nOffSetUnit * (_nThreadNumber-1), _nOffSetUnit);
		
		String strSqlS = "select pl_no, pl_modelno, pl_vcode, pl_category, pl_goodsnm"
				      + ", pl_price, convert(varbinary, pl_url) pl_url, pl_note, pl_srvflag, pl_status"
				      + ", pl_soldoutflag, pl_soldoutdate, pl_rightnleft, pl_multicomment, convert(varbinary, pl_imgurl) pl_imgurl"
				      + ", pl_coupon, pl_airconfeetype, pl_account_yn, pl_esstockflag, pl_instance_price"
				      + ", pl_finalusedflag, pl_goodsfactory, convert(varbinary,pl_goodscode) pl_goodscode , pl_dutycode, pl_goodsnm_cs"
				      + ", pl_url_cs, pl_imgurlflag, pl_deliveryinfo, pl_freeinterest, pl_nochange"
				      + ", pl_goodscode_cs, pl_agree_month, pl_homeflag, pl_price_card, option_flag2"
				      + ", catalog_flag, pl_cashback, pl_tag_price, pl_call_plan, pl_in_fee_yn"
				      + ", pl_ship_fee_yn, pl_bond_fee, pl_penality_fee, PRICE_FLAG, convert(varbinary, pl_delivery_lev) pl_delivery_lev "
				      + ", pl_set_yn, pl_store_flag, pl_ca_code_dept, pl_mobile_flag, pl_deliveryinfo2"
				      + ", pl_deliverytype2, pl_copyplno, pl_mobile_url, pl_authdate, pl_date"
				      + ", GD_EVL_CNT, GD_EVL_TOT_SCR"
				      + " from ELOC2001.dbo.pricelist with (nolock) "
				      + " order by pl_no "
				      + " offset " + String.valueOf(_nOffSetUnit * (_nThreadNumber -1)) + " rows "
				      + " fetch next " + String.valueOf(_nOffSetUnit) + " rows only";

				       
		System.out.println(strSqlS);

		
		try {
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
			oStmtS.setFetchSize(_nFetchSize);
			
			System.out.println(String.format("Query Start (%d) .... ", _nThreadNumber));
			lSpotTime = System.currentTimeMillis();
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			dElapsedSec =  (System.currentTimeMillis() - lSpotTime) /1000.0;
			System.out.println(String.format("Query End (%d) .... %.1f sec", _nThreadNumber, dElapsedSec));

//			## NOT GOOD
//			System.out.println(String.format("Skip %d Rows .... ", _nOffSetUnit));
//			lSpotTime = System.currentTimeMillis();
//			for(int i=0; i <  _nOffSetUnit; i++) oRs.next();
//			dElapsedSec =  (System.currentTimeMillis() - lSpotTime) /1000.0;
//			System.out.println(String.format("Skip End .... %.1f sec", dElapsedSec));

			//SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(oConnT);
			SQLServerBulkCopy bulkCopy = new SQLServerBulkCopy(sConnT);
			SQLServerBulkCopyOptions copyOptions = new SQLServerBulkCopyOptions();
			copyOptions.setKeepIdentity(true);
			copyOptions.setBatchSize(_nBatchSize);
			copyOptions.setTableLock(false);
			copyOptions.setBulkCopyTimeout(0);
			
			bulkCopy.setBulkCopyOptions(copyOptions);
			
			bulkCopy.setDestinationTableName(_sTargetTable);
			
			bulkCopy.writeToServer(oRs);
			bulkCopy.close();
			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			//_nRows = _nRows - _nOffSetUnit;
			System.out.println( String.format("COMPLETE(%d): total %d Rows, Sec: %.0f,  %.1f rows/sec", _nThreadNumber, _nRows, dElapsedSec, _nRows / dElapsedSec));
			
			oRs.close();
			oConnS.close();
			oConnT.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		_nThreadCount --;
	}
	
	
	
	
	public static void test01(String[] args) {
		System.out.println("ok 0");
		
		int _nBatchSize = 4000;
		long lStartTime = System.currentTimeMillis();
		double dElapsedSec = 0.0;
		long _nRows = 0;
		
		//DBConnectionManager oConMgr = new DBConnectionManager("MPDB_TEST");
		System.out.println("ok 1");
		//Connection oConnS = oConMgr.getConnection();
		//Connection oConnT = oConMgr.getConnection();
		
		System.out.println("ok 2");
		
		Statement oStmtS = null;
		PreparedStatement oStmtT  = null;
		
		String strSqlS = "select * from ELOC2001.dbo.pricelist where pl_no = 9340239";
		String strSqlT1 = "insert into ANALSTORE.dbo.tb_test_pl(";
		String strSqlT2 = " values(";
		
		
		String sConnS = "jdbc:sqlserver://x.x.x.x:1433;"
		        + "databaseName=db;user=user;password=pass";
		String sConnT = "jdbc:sqlserver://x.x.x.x:1433;"
		        + "databaseName=db;user=user;password=pass";
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);
			oStmtS = oConnS.createStatement();
			oStmtS.setFetchSize(_nBatchSize);
			
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
				_nRows ++;
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
					oConnT.commit();
					dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
					System.out.println( String.format("%10d Rows ...%7.0f rows/sec", _nRows, _nRows / dElapsedSec));
		
				}
			}
			
			if((_nRows % _nBatchSize) != 0) {
				oStmtT.executeBatch();
				oStmtT.clearBatch();
				oConnT.commit();
			}

			dElapsedSec =  (System.currentTimeMillis() - lStartTime) /1000.0;
			System.out.println( String.format("COMPLETE : total %d Rows, Sec: %.0f,  %.1f rows/sec", _nRows, dElapsedSec, _nRows / dElapsedSec));

			oStmtS.close();
			oStmtT.close();	
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//oConMgr.closeAll();
	}

}
