package com.cslee.dqm;

import java.sql.Connection;
import java.sql.PreparedStatement;
//import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import com.cslee.db.dbpool.*;
import com.cslee.utils.*;


//import java.sql.SQLException;

//import org.json.JSONArray;
//import org.json.JSONObject;
//import org.json.JSONException;

@SuppressWarnings("unused")
public class DQMain {

	public static String replaceUserValues(String sSQL) throws SQLException 
	{
		if (sSQL == null || sSQL.isEmpty()) return sSQL;

		String sVars = SysConfig.getConfig("sql_variables/variables");
		if (sVars == null) return sSQL;
		
		String sRet=sSQL;
		String sConnName = SysConfig.getConfig("sql_variables/database");
		String sQuery = SysConfig.getConfig("sql_variables/query");
		String sVarNames[] = sVars.split(",");
		String sValue = "";

		DBConnectionManager oConnMgr = new DBConnectionManager(sConnName);
		Connection oConn = oConnMgr.getConnection();
		
		PreparedStatement oStmt = oConn.prepareStatement(sQuery);
		
		for (int i=0; i < sVarNames.length; i++)
		{
			//System.out.println("sVarNames=" + sVarNames[i] + ", sRet = " + sRet);
			
			if(sRet.indexOf("${"+ sVarNames[i]+ "}") < 1) continue;
			oStmt.setString(1, sVarNames[i]);
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next())
			{
				sValue = oRs.getString(1);
			}
			sRet = sRet.replaceAll(Pattern.quote("${"+ sVarNames[i]+ "}"), sValue);
			oRs.close();
		}
		oConnMgr.freeConnection(oConn);
		
		return sRet;
	}
	
	
	public static void main(String[] args) 
	{
		String sRULE_ID        = null;
		String sRULE_TYPE      = null;
		String sLCLS_NM        = null;
		String sMCLS_NM        = null;
		String sTGT_DB_NM      = null;
		String sTGT_TAB_NM     = null;
		String sTGT_COL_NM     = null;
		String sTGT_TAB_KO_NM  = null;
		String sTGT_COL_KO_NM  = null;
		String sCMP_DB_NM      = null;
		String sCMP_TAB_NM     = null;
		String sCMP_TAB_KO_NM  = null;
		String sRULE_DFN       = null;
		String sVRFY_DFN       = null;
		String sERR_PROC_DFN   = null;
		String sDB_N1_CONN_NM  = null;
		String sRULE_N1_SQL    = null;  
		String sDB_N2_CONN_NM  = null;
		String sRULE_N2_SQL    = null;
		String sERR_SAV_TAB_NM = null;
		String sCYCLE          = null;
		
		String sQueryRule = null;
		String sDQMConn = "DQMS";
		String sSQL1 = null;
		String sSQL2 = null;
		String sMsg = null;
		
		String sConsoleMsg = null;
		
		
		if(args.length < 2 ||args.length%2 != 0 )
		{
			System.out.println("Usage: DQMain -[Option] [Option Value] ...");
			System.out.println("  option: ID, CYCLE, TYPE, DB, TABLE, COL, COND");
			return;
		}
		
		StringBuffer sb = new StringBuffer();
		
		for(int i=0; i < args.length; i+=2)
		{
			//System.out.println(String.format("args [%d:%s], [%d:%s]\n", i, args[i], i+1, args[i+1]));
			
			if(args[i].equalsIgnoreCase("-ID")) 
			{
				sb.append(" AND RULE_ID LIKE '" + args[i+1] + "'");
			} 
			else if(args[i].equalsIgnoreCase("-CYCLE"))
			{
				sb.append(" AND CYCLE LIKE '" + args[i+1] + "'");
			}
			else if(args[i].equalsIgnoreCase("-TYPE"))
			{
				sb.append(" AND RULE_TYPE LIKE '" + args[i+1] + "'");
			}
			else if(args[i].equalsIgnoreCase("-DB"))
			{
				sb.append(" AND TGT_DB_NM LIKE '" + args[i+1] + "'");
			}
			else if(args[i].equalsIgnoreCase("-TABLE"))
			{
				sb.append(" AND TGT_TAB_NM LIKE '" + args[i+1] + "'");
			}
			else if(args[i].equalsIgnoreCase("-COL"))
			{
				sb.append(" AND TGT_COL_NM LIKE '" + args[i+1] + "'");
			}
			else if(args[i].equalsIgnoreCase("-COND"))
			{
				sb.append(" AND " + args[i+1]);
			}
			else if(args[i].isEmpty())
			{
				break;
			}
			else
			{
				System.out.println("Usage: DQMain -[Option] [Option Value] ...");
				System.out.println("  option: ID, CYCLE, TYPE, DB, TABLE, COND");
				return;
			}
		}
		
		SysConfig sysconf  = new SysConfig();
		
		LogFileManager oLogFileMgr = LogFileManager.getInstance();
		oLogFileMgr.set(sysconf.getLogFile(), sysconf.getLogLevel(), false);
		System.out.println("DQM RUNING : " + sb.toString());
		
		try 
		{
			DBWork dbDQM = new DBWork(sDQMConn);

			sQueryRule = "SELECT RULE_ID, RULE_TYPE, LCLS_NM, MCLS_NM, TGT_DB_NM, TGT_TAB_NM, TGT_COL_NM "
				       + "     , TGT_TAB_KO_NM, TGT_COL_KO_NM, CMP_DB_NM, CMP_TAB_NM, CMP_TAB_KO_NM      "
					   + "     , RULE_DFN, VRFY_DFN, ERR_PROC_DFN, DB_N1_CONN_NM, RULE_N1_SQL            "
					   + "     , DB_N2_CONN_NM, RULE_N2_SQL, ERR_SAV_TAB_NM, CYCLE                       "
					   + " FROM TB_DQM_RULES2 "
		               + " WHERE USE_YN = 'Y'"
//		               + "   and rule_id = 'ETOM0006' "
		               + sb.toString()
		               + " ORDER BY RULE_ID";
			
			ResultSet oRs = dbDQM.runSQL(dbDQM.getConnection(), sQueryRule);
			
			if (oRs != null) 
			{
				while (oRs.next()) 
				{
					sRULE_ID        = oRs.getString("RULE_ID");
					sRULE_TYPE      = oRs.getString("RULE_TYPE");
					sLCLS_NM        = oRs.getString("LCLS_NM");
					sMCLS_NM        = oRs.getString("MCLS_NM");
					sTGT_DB_NM      = oRs.getString("TGT_DB_NM");
					sTGT_TAB_NM     = oRs.getString("TGT_TAB_NM");
					sTGT_COL_NM     = oRs.getString("TGT_COL_NM");
					sTGT_TAB_KO_NM  = oRs.getString("TGT_TAB_KO_NM");
					sTGT_COL_KO_NM  = oRs.getString("TGT_COL_KO_NM");
					sCMP_DB_NM      = oRs.getString("CMP_DB_NM");
					sCMP_TAB_NM     = oRs.getString("CMP_TAB_NM");
					sCMP_TAB_KO_NM  = oRs.getString("CMP_TAB_KO_NM");
					sRULE_DFN       = oRs.getString("RULE_DFN");
					sVRFY_DFN       = oRs.getString("VRFY_DFN");
					sERR_PROC_DFN   = oRs.getString("ERR_PROC_DFN");
					sDB_N1_CONN_NM  = oRs.getString("DB_N1_CONN_NM");
					sRULE_N1_SQL    = oRs.getString("RULE_N1_SQL");
					sDB_N2_CONN_NM  = oRs.getString("DB_N2_CONN_NM");
					sRULE_N2_SQL    = oRs.getString("RULE_N2_SQL");
					sERR_SAV_TAB_NM = oRs.getString("ERR_SAV_TAB_NM");
					sCYCLE          = oRs.getString("CYCLE");
					
					
					LogDB oLogDB = new LogDB(sRULE_ID, sTGT_DB_NM, sTGT_TAB_NM, sTGT_COL_NM);
					
					// print START MESSAGE USING LOGDB INFO.
					
					//System.out.println(oLogDB);
					sConsoleMsg =  String.format("ID:[%s], TYPE:[%s], OBJ:%s"
							, sRULE_ID, sRULE_TYPE, StrUtils.rpad("["+sTGT_DB_NM+"].["+sTGT_TAB_NM+"]  ", 50, '.')); //, oLogDB.getLogId());
					
					System.out.print(sConsoleMsg);
					
					oLogDB.startLog();
					
					sSQL1 = replaceUserValues(sRULE_N1_SQL);
					sSQL2 = replaceUserValues(sRULE_N2_SQL);
					
//					System.out.println("START: ID = " + sRuleId + ", CON1=" + sConnName1 + ", CON2=" + sConnName2);
//					System.out.println("SQL1 = " + sSQL1); 
//					System.out.println("SQL2 = " + sSQL2);
					
					
					oLogDB.changeStatus("RUNNING", "SQL Executing");					
					if(sSQL2 == null) 
					{
						DBWork dbThread1 = new DBWork(sDB_N1_CONN_NM, sSQL1, oLogDB);
						dbThread1.start();
						dbThread1.join();
						
						if(dbThread1.hasError()) 
						{
							oLogDB.endLog(dbThread1.getException(), "SQL2");
						}
						else
						{
							oLogDB.changeStatus("RUNNING", "Inserting error data to log table (" + sERR_SAV_TAB_NM + ")");					
							//long nRet = oLogDB.insertErrResultSet(sERR_SAV_TAB_NM, dbThread1.getResultSet());
							long nRet = oLogDB.insertErrResultSet(dbThread1.getResultSet());
							oLogDB.setSqlResult1(String.valueOf(nRet));
							oLogDB.endLog(nRet == 0);
						}
						
						dbThread1.dbClose();
						sMsg = String.format("( %7.2f )s", dbThread1.getDuration());
		
					}
					else 
					{
						DBWork dbThread1 = new DBWork(sDB_N1_CONN_NM, sSQL1, oLogDB, "SQL1");
						DBWork dbThread2 = new DBWork(sDB_N2_CONN_NM, sSQL2, oLogDB, "SQL2");
						dbThread1.start();
						dbThread2.start();
						dbThread1.join();
						dbThread2.join();
						
//						String sRet1 = dbThread1.getResultString(1);
//						String sRet2 = dbThread2.getResultString(1);
						
//						oLogDB.setSqlResult1(sRet1);
//						oLogDB.setSqlResult2(sRet2);
//						oLogDB.endLog(sRet1.equalsIgnoreCase(sRet2));
						if(dbThread1.hasError())
						{
							oLogDB.endLog(dbThread1.getException(), "SQL1");
						}
						else if(dbThread2.hasError())
						{
							oLogDB.endLog(dbThread2.getException(), "SQL2");
						}
						else
						{
							oLogDB.endLog(oLogDB.compareResultSet(dbThread1.getResultSet(), dbThread2.getResultSet()));
						}
						dbThread1.dbClose();
						dbThread2.dbClose();
						sMsg = String.format("( %7.2f: %7.2f )s", dbThread1.getDuration(), dbThread2.getDuration());
					}
					System.out.println(".. " + sMsg + ", ["+ oLogDB.getResult() + "]");
				}
			}
			
			dbDQM.dbClose();
			System.out.println(".... JOB COMPLETED!");
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
	
/////	public static void testJson() 
////	{
////		
////		LogFile oLogFile = new LogFile("log/json_test.txt");
////		String sSQL = "SELECT TABLE_NAME, COLUMN_ID, COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE OWNER = 'DBADM'";
////        DBWork oWrk1 = new DBWork("default", sSQL);
////        
////       
////		ResultSet oRs = null;
////		ResultSetMetaData oRsmd = null;
////		
////		String sColName;
////		int iColCnt;
////		JSONArray oJsonArr = new JSONArray();
////		
////		try {
////			oWrk1.start();
////			oWrk1.join();
////			
////			oRs = oWrk1.getResultSet();
////			oRsmd = oRs.getMetaData();
////			iColCnt = oRsmd.getColumnCount();
////			
////			while (oRs.next()) {
////				JSONObject oJson = new JSONObject();
////				
////				for (int i=1; i <= iColCnt ; i++) 
////				{
////					sColName = oRsmd.getColumnName(i);
////					switch(oRsmd.getColumnType(i)) 
////					{
////					  	case java.sql.Types.ARRAY : 
////					  		oJson.put(sColName, oRs.getArray(i));
////					  		break;
////					  	case java.sql.Types.INTEGER:
////						  	oJson.put(sColName, oRs.getInt(i));
////						  	break;
////					  	case java.sql.Types.DECIMAL:
////					  	case java.sql.Types.NUMERIC:
////					  	case java.sql.Types.BIGINT : 
////					  		oJson.put(sColName, oRs.getBigDecimal(i));
////					  		break;
////					  	case java.sql.Types.FLOAT:
////					  	case java.sql.Types.REAL:
////					  	case java.sql.Types.DOUBLE : 
////					  		oJson.put(sColName, oRs.getDouble(i));
////					  		break;
////					  	case java.sql.Types.CHAR : 
////					  		oJson.put(sColName, oRs.getString(i));
////					  		break;
////					  	case java.sql.Types.VARCHAR : 
////					  	case java.sql.Types.NVARCHAR : 
////					  	case java.sql.Types.LONGVARCHAR : 
////					  	case java.sql.Types.LONGNVARCHAR : 
////						  	oJson.put(sColName, oRs.getString(i));
////					  		break;					  	
////					  	/*
////					  	 case java.sql.Types.CLOB:
////					  		Clob clob = oRs.getCLob(i);
////						  	oJson.put(sColName, oRs.getString(i));
////					  		reak;
////					  	*/					  	
////					  	case java.sql.Types.DATE : 
////						  	oJson.put(sColName, oRs.getDate(i));
////					  		break;
////					  	default :                
////					  		oJson.put(sColName, oRs.getObject(i));
////					  		break;
////					}
////					//oLogFile.write(sColName + ":" + oRs.getString(i) + ", ");
////				}
////				//oLogFile.write("\n\r");
////				oJsonArr.put(oJson);
////			}
////			
////			oWrk1.dbClose();
////			
////			oLogFile.logWrite(LOG_LEVEL.OFF, oJsonArr.toString(4));
////	    } catch (InterruptedException e) {
////			e.printStackTrace();
////		} catch (JSONException e) {
////			e.printStackTrace();
////		} catch (SQLException e) {
////			e.printStackTrace();
////		}
////		
////
////		
////		System.out.println("W1:" + oWrk1.toString());
////		
////		//System.out.println("W2:" + oWrk2.toString());
////	}

	
}

