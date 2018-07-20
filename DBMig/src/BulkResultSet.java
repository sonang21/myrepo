import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.microsoft.sqlserver.jdbc.ISQLServerBulkRecord;
import com.microsoft.sqlserver.jdbc.SQLServerException;

public class BulkResultSet implements ISQLServerBulkRecord {

	private class ColumnMetadata {
        String columnName;
        int columnType;
        int columnTypeOrigin;
        int precision;
        int scale;

        String columnTypeName;
        
        ColumnMetadata(String name,
        		int originType,
        		int newType,
                int precision,
                int scale,
                String typeName
        ) {
            columnName = name;
            columnTypeOrigin = originType;
            columnType = newType;
            this.precision = precision;
            this.scale = scale;
            columnTypeName = typeName; 
        }
        @Override
        public String toString() {
        	return String.format("[name=%s, type=%s(%d=>%d), precision=%d, scale=%d]\n"
        			           , columnName, columnTypeName, columnTypeOrigin, columnType, precision, scale);
        }
    }

	int _columnCount = 0;
    int _counter = 0;
    long _rowCount = 0;
    Map<Integer, ColumnMetadata> _columnMetadata;
    ResultSet _oResultSet;
//    Object[] _rowData;
    
    BulkResultSet(ResultSet rs, boolean fromOracle) throws SQLException {
        _columnMetadata = new HashMap<Integer, ColumnMetadata>();
        _oResultSet = rs;
        ResultSetMetaData meta = _oResultSet.getMetaData();
        _columnCount = meta.getColumnCount();
//        _rowData = new Object[_columnCount];
        
        // add metadata
        for (int i = 1; i <= _columnCount; i++) {
        	String name = meta.getColumnName(i);
        	int originType = meta.getColumnType(i);
        	int newType = originType;
        	String typeName = meta.getColumnTypeName(i);
            int precision = meta.getPrecision(i);
            int scale = meta.getScale(i);
            
            if(fromOracle) {
	            switch (originType) {
		        	case 1  : newType = java.sql.Types.NCHAR;    break; //oracle char
		        	case 12 : newType = java.sql.Types.NVARCHAR; break; //oracle varchar2
	            	default : break;  //nothing
	            }
            } 
//            else {
//	            switch (originType) {
//		        	case 93 : newType = java.sql.Types.TIMESTAMP;  break; //mssql smalldatetime 2008에서 오류
//	            	default : break;  //nothing
//	            }
//            }
            
            _columnMetadata.put(i, new ColumnMetadata(name, originType, newType, precision, scale, typeName));
        }
        
//        System.out.println("BulkResultSet() : meta => " + _columnMetadata.toString());
    }
    @Override
    public String toString() {
    	return _columnMetadata.toString();
    }
    
	@Override
	public String getColumnName(int colId) {
		// TODO Auto-generated method stub
		return _columnMetadata.get(colId).columnName;
	}

	@Override
	public Set<Integer> getColumnOrdinals() {
		// TODO Auto-generated method stub
		return _columnMetadata.keySet();
	}

	@Override
	public int getColumnType(int colId) {
		// TODO Auto-generated method stub
		return _columnMetadata.get(colId).columnType;
	}

	@Override
	public int getPrecision(int colId) {
		// TODO Auto-generated method stub
		return _columnMetadata.get(colId).precision;
	}

	@Override
	public Object[] getRowData() throws SQLServerException {
		// TODO Auto-generated method stub
//		System.out.println("S.....................................................................");
		Object[] rowData = new Object[_columnCount];
		try {
			for (int i = 0; i < _columnCount; i++) {
				rowData[i] = _oResultSet.getObject(i+1);
			}
		}
		catch (SQLException ex) {
			rowData = null;			
			System.err.println("BulkResultSet.getRowData() : \n");
			ex.printStackTrace();
			throw new SQLServerException(ex.getMessage(), ex.getSQLState(), ex.getErrorCode(),ex.getCause());
		}
//		System.out.println("E....................................................................." + rowData[0].toString());
		return rowData;
	}

	@Override
	public int getScale(int colId) {
		// TODO Auto-generated method stub
		return _columnMetadata.get(colId).scale;
	}

	@Override
	public boolean isAutoIncrement(int colId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean next() throws SQLServerException {
		// TODO Auto-generated method stub
		boolean result = false;
		try {
			if( _oResultSet.next()) {
				result = true;
				_rowCount ++;
//				System.out.format("============> %d : [%s]\n", _rowCount, _oResultSet.getString(1));
			};
		}
		catch (SQLException ex) {
			System.err.println("BulkResultSet.next()======================================");
			ex.printStackTrace();
			result = false;
		}
		return result;
	}
	
	public long getRowCount() { return _rowCount; }

}
