package bts.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import bts.utils.db.DBConnection;
import bts.utils.db.DBConnection.DBMS_TYPE;

public class DBObjectWork {
	
	private Connection _oConn = null;
	private DBConnection _dbconnection = null;
	
	public DBObjectWork(String sConnectionName) {
		_dbconnection = new DBConnection(sConnectionName);
		_oConn = _dbconnection.dbConnect();
	}
	
	public DBObjectWork(DBMS_TYPE dbmsType, String sURL, String sUser, String sPassword) {
		
		_dbconnection = new DBConnection(dbmsType, sURL, sUser, sPassword);
		_oConn = _dbconnection.dbConnect();
	}
	
	@Override
	public String toString() {
		return "DBObjectWork -> " + _dbconnection.toString();
	}
	
	public String[] getOracleText(String sOwner, String sObjectName, String sObjectType, boolean isBatch) {
		
		//oConn.setCatalog(sDBName);
		String sResult[] = {"",""};
		String sSQL = 
				"SELECT OWNER, OBJECT_TYPE , OBJECT_NAME, CREATED, LAST_DDL_TIME \r\n" + 
				"     , DBMS_METADATA.GET_DDL(OBJECT_TYPE=>REPLACE(A.OBJECT_TYPE, ' ', '_'), NAME=>A.OBJECT_NAME, SCHEMA=>A.OWNER) DDL \r\n" + 
				"  FROM DBA_OBJECTS A \r\n" + 
				" WHERE 1 = 1 \r\n" +
				"   AND A.OWNER = ? \r\n" +
				"   AND A.OBJECT_NAME = ? \r\n" +
				"   AND A.OBJECT_TYPE = ? \r\n" +
				"   --AND A.OBJECT_TYPE IN ('PACKAGE','PROCEDURE','FUNCTION', 'TRIGGER','VIEW', 'MATERIALIZED VIEW') \r\n" + 
				"   --AND A.OBJECT_TYPE IN ('TABLE','INDEX','SEQUENCE','PACKAGE','PROCEDURE','FUNCTION', 'TRIGGER','VIEW', 'MATERIALIZED VIEW') \r\n" + 
				" ORDER BY A.OWNER, A.OBJECT_TYPE, A.OBJECT_NAME";
		try {
			PreparedStatement oStmt = _oConn.prepareStatement(sSQL);
			oStmt.setString(1, sOwner.toUpperCase());
			oStmt.setString(2, sObjectName.toUpperCase());
			oStmt.setString(3, sObjectType.toUpperCase());
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next()) {
				sResult[0] = "1";
				if(isBatch) {
					SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd_HHmmss");
					sResult[1] = String.format("/*** [%s] %s.%s  : modified %s ***/\r\n"
							, sObjectType, sOwner, sObjectName, fmt.format(oRs.getDate(5)));
					sResult[1] = sResult[1] + oRs.getString(6).replaceFirst("\nALTER TRIGGER ", "\n/\r\nALTER TRIGGER " );
					sResult[1] = sResult[1] + "\r\n/\r\n----------------------------------------------------------------------------------\r\n\r\n";
	//				SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd_HHmmss");
	//				System.out.println(fmt.format(oRs.getDate(4))+ " , "+ fmt.format(oRs.getDate(5)));
				}
				else {
					sResult[1] = oRs.getString(6);
				}
			} else {
				sResult[0] = "0";
				sResult[1] = "";
			}
			oRs.close();
		} catch (Exception e) {
			// TODO: handle exception
			sResult[0] = "-1";
			sResult[1] = e.getMessage();
			e.printStackTrace();
		}
		return sResult;
	}

	public String[] getMSSQLText(String sDBName, String sOwner, String sObjectName, String sObjectType, boolean isBatch) {
		
		String sResult[] = {"",""};
		String sSQL = "SELECT DB_NAME()  DB_NAME \r\n" + 
			      "     , CASE WHEN A.TYPE IN ('FN','FS','FT','IF','TF') THEN 'FUNCTION' \r\n" + 
			      "            WHEN A.TYPE = 'P'  THEN 'PROCEDURE' \r\n" + 
			      "            WHEN A.TYPE = 'TR' THEN 'TRIGGER' \r\n" + 
			      "            WHEN A.TYPE = 'V'  THEN 'VIEW' \r\n" + 
			      "            ELSE A.TYPE \r\n" + 
			      "       END  AS TYPE2 \r\n" + 
			      "     , C.NAME     SCHEMA_NAME \r\n" + 
			      "     , A.NAME     SOURCE_NAME \r\n" + 
			      "     , B.DEFINITION \r\n" +                     //5 
			      "     , A.TYPE     SOURCE_TYPE \r\n" + 
			      "     , A.TYPE_DESC \r\n" + 
			      "     , A.CREATE_DATE, A.MODIFY_DATE \r\n" +     //8,9
			      "FROM SYS.OBJECTS A \r\n" + 
			      "     INNER JOIN SYS.SQL_MODULES B ON (B.OBJECT_ID = A.OBJECT_ID) \r\n" + 
			      "     INNER JOIN SYS.SCHEMAS     C ON (C.SCHEMA_ID = A.SCHEMA_ID) \r\n" +
			      "WHERE C.NAME = ? \r\n" +   // schema
			      "  AND A.NAME = ? \r\n" +   // object_name
//			      "WHERE A.TYPE IN ('FN','FS','FT','IF','TF','P','TR','V','U') \r\n" + 
//			      "  AND A.IS_MS_SHIPPED = 0 \r\n" + 
			      "ORDER BY TYPE2, SCHEMA_NAME, SOURCE_NAME";

		try {
			_oConn.setCatalog(sDBName);
			PreparedStatement oStmt = _oConn.prepareStatement(sSQL);
			oStmt.setString(1, sOwner);
			oStmt.setString(2, sObjectName);
//			oStmt.setString(3, sObjectType);
			System.out.println(sDBName + ", " + sOwner + ", " + sObjectName);
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next()) {
				sResult[0] = "1";
				if(isBatch) {
					SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//					System.out.println(fmt.format(oRs.getTimestamp(8))+ " , "+ fmt.format(oRs.getTimestamp(9)));
					sResult[1] = String.format("/*** [%s] %s.%s : modified %s ***/\r\n\r\nUSE [%s]\r\nGO\r\n"
							                  , sObjectType, sOwner, sObjectName, fmt.format(oRs.getTimestamp(9)), oRs.getString(1));
					sResult[1] = sResult[1] + String.format("IF OBJECT_ID('%s.%s','%s') IS NOT NULL \r\n    DROP %s %s.%s; \r\nGO\r\n"
							                   , sOwner, sObjectName, oRs.getString(6)
							                   , sObjectType, sOwner, sObjectName
							                  );
					sResult[1] = sResult[1] + oRs.getString(5);
					sResult[1] = sResult[1] + "\r\nGO\r\n---------------------------------------------------------------------------------------\r\n";
				}
				else { 
					sResult[1] = oRs.getString(5);
				}
				  
				//System.out.println(oRs.getString(8)+ " , "+ oRs.getString(9));
				
			} else {
				sResult[0] = "0";
				sResult[1] = "";
			}
			oRs.close();
		} catch (Exception e) {
			// TODO: handle exception
			sResult[0] = "-1";
			sResult[1] = e.getMessage();
			e.printStackTrace();
		}
		return sResult;
	}
	

	public void closeAll() {
		_dbconnection.dbClose();
	}
	
	public boolean objectExistsMSSQL(String sDBName, String sOwner, String sObjectName) {
		boolean bResult = false;
		String sSQL = "SELECT 1 " +
			      "FROM SYS.OBJECTS A \r\n" + 
			      "     INNER JOIN SYS.SCHEMAS     C ON (C.SCHEMA_ID = A.SCHEMA_ID) \r\n" +
			      "WHERE C.NAME = ? \r\n" +   // schema
			      "  AND A.NAME = ? \r\n";    // object_name

		try {
			_oConn.setCatalog(sDBName);
			PreparedStatement oStmt = _oConn.prepareStatement(sSQL);
			oStmt.setString(1, sOwner);
			oStmt.setString(2, sObjectName);
//			oStmt.setString(3, sObjectType);
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next()) {
				bResult = true;
			} else {
				bResult = false;
			}
			oRs.close();
		} catch (Exception e) {
			// TODO: handle exception
			bResult = false;
			e.printStackTrace();
		}
		return bResult;
	}

	public boolean objectExistsORACLE(String sOwner, String sObjectName, String sObjectType) {
		boolean bResult = false;
		String sSQL = 
				"SELECT 1 " +
				"  FROM DBA_OBJECTS A \r\n" + 
				" WHERE 1 = 1 \r\n" +
				"   AND A.OWNER = ? \r\n" +
				"   AND A.OBJECT_NAME = ? \r\n" +
				"   AND A.OBJECT_TYPE = ? \r\n";
		try {
			PreparedStatement oStmt = _oConn.prepareStatement(sSQL);
			oStmt.setString(1, sOwner.toUpperCase());
			oStmt.setString(2, sObjectName.toUpperCase());
			oStmt.setString(3, sObjectType.toUpperCase());
			ResultSet oRs = oStmt.executeQuery();
			if (oRs.next()) {
				bResult = true;
			} else {
				bResult = false;
			}
			oRs.close();
		} catch (Exception e) {
			// TODO: handle exception
			bResult = false;
			e.printStackTrace();
		}
		return bResult;
	}

}
