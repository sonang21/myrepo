

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;
//import com.microsoft.sqlserver.jdbc.*;

import dbm.dbworks.StandAloneTest;

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
public class MigAnalPricelist extends Thread {
	private String _sSourceDB;
	private String _sTargetDB;
	private String _sSourceTable;
	private String _sTargetTable;
	private static int _nTotalCount=0;
	private static int _nThreadCount=0;
	private static int _nBatchSize = 5000; //5000;
	private static int _nFetchSize = 500; //5000;
	private static long _nTotalRows = 0; //500000;
	
	private int _nDutyCode = 0;
	
	
	public static void main(String[] args) throws Exception {
		int nTotalCnt = 1;
		int nDutyCode = 0;
		if (args.length > 0) {
			System.out.println(args[0]);
			//check args is number
			if(args[0].chars().allMatch(Character::isDigit))  {
				nTotalCnt = 1;
				nDutyCode = Integer.valueOf(args[0]);
			}
			else if(args[0].equalsIgnoreCase("all"))
			{
				nTotalCnt = 15;
				nDutyCode = 0;
			}
			else {
				System.out.println("Usage : MyAnalPricelist [dutycode|all]");
				return;
			}
		}
		else {
			System.out.println("Usage : MyAnalPricelist [dutycode|all]");
			return;
		}
		MigAnalPricelist[] sample = new MigAnalPricelist[nTotalCnt];
		
		for(int i=0; i < sample.length; i++) {
			sample[i] = new MigAnalPricelist("MPDB_TEST", "ELOC2001.dbo.pricelist"
					                 , "ANALSTORE", "ANALSTORE.dbo.pricelist");
			sample[i].setDutyCode(nDutyCode);
			nDutyCode++;
			
			sample[i].start();
			Thread.sleep(3000);
		}
		
	}
	public MigAnalPricelist(String sSourceDB, String sSourceTable, String sTargetDB, String sTargetTable) {
		setSource(sSourceDB, sSourceTable);
		setTarget(sTargetDB, sTargetTable);
	}
	
	public void setDutyCode(int nDutyCode) {
		this._nDutyCode = nDutyCode;
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
	
//	@SuppressWarnings("unused")
	public void bulkCopy() {
		long lStartTime = System.currentTimeMillis();
		long nSpotTimeBefore = lStartTime ;
		long nSpotTimeCurr;
		double dElapsedSec = 0.0;
		double dLapSec = 0.0;
		long nRows=0;
		
//		String sConnS = "jdbc:sqlserver://X.X.X.X:port;"
//				        + "databaseName=dbname;user=user;password=passwd";
//		String sConnT = "jdbc:sqlserver://x.x.x.x:port;"
//				        + "databaseName=dbname;user=user;password=passwd";
			
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
				      + " where ELOC2001.$PARTITION.PF_PRICELIST(pl_vcode) = 8 " // 8, 18, 13 
//				      + "   and */ pl_dutycode = " + String.valueOf(_nDutyCode)
				      + "   and (pl_no % 15) = " + String.valueOf(_nDutyCode)
				      ;

				       
		System.out.println(strSqlS);

//		InputStream  input = StandAloneTest.class.getClassLoader().getResourceAsStream("../conf/DBConfig.ini");

		try {
			InputStream  input = new FileInputStream("conf/DBConfig.ini");
			Properties prop = new Properties();
			prop.load(input);
			
			String sConnS = prop.getProperty("MPDB_TEST");
			String sConnT = prop.getProperty("ANALSTORE");
			
			System.out.println(String.format("start(%d) ---------------------------------------------", _nDutyCode));
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			//DBConnectionManager oConMgrS = new DBConnectionManager(_sSourceDB);
			//DBConnectionManager oConMgrT = new DBConnectionManager(_sTargetDB);
			//Connection oConnS = oConMgrS.getConnection();
			//Connection oConnT = oConMgrT.getConnection();
			System.out.println(sConnS);
			
			Connection oConnS = DriverManager.getConnection(sConnS);
			Connection oConnT = DriverManager.getConnection(sConnT);

			if (_nDutyCode==0) {
				Statement oStmtT = oConnT.createStatement();
				oStmtT.execute("truncate table " + _sTargetTable);
				oStmtT.close();
			}
			Statement oStmtS = null;
			//PreparedStatement oStmtT  = null;
//			oStmtS = oConnS.createStatement();
			oStmtS = oConnS.createStatement(ResultSet.TYPE_FORWARD_ONLY
					                      , ResultSet.CONCUR_READ_ONLY);
			oStmtS.setFetchSize(_nFetchSize);
			
			System.out.println(String.format("Query Start (%d) .... ", _nDutyCode));
			nSpotTimeBefore = System.currentTimeMillis();
			ResultSet oRs = oStmtS.executeQuery(strSqlS);
			dElapsedSec =  (System.currentTimeMillis() - nSpotTimeBefore) /1000.0;
			System.out.println(String.format("Fetch Start (%d) .... %.1f sec", _nDutyCode, dElapsedSec));

		
//			nSpotTimeBefore = System.currentTimeMillis();
//			int nLapCnt = 1000000;
//			while (oRs.next())
//			{
//				nRows++;
//				if (nRows % nLapCnt == 0)
//				{
//					nSpotTimeCurr = System.currentTimeMillis();
//					dLapSec = (nSpotTimeCurr - nSpotTimeBefore) / 1000.0;
//					dElapsedSec = (nSpotTimeCurr - lStartTime) / 1000.0;
//					nSpotTimeBefore = nSpotTimeCurr;
//					System.out.println( String.format("... DUTY(%d): %10d Rows, Sec: %3.0f, Lap %5.1f rows/sec, AVG %5.1f rows/s"
//							         , _nDutyCode, nRows, dLapSec, nLapCnt/dLapSec, nRows / dElapsedSec));
//				}
//				
//			}

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
			
			System.out.println( String.format("COMPLETE(%d): total %d Rows, Sec: %.0f,  %.1f rows/sec", _nDutyCode, nRows, dElapsedSec, nRows / dElapsedSec));
			
			oRs.close();
			oConnS.close();
			oConnT.close();
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
