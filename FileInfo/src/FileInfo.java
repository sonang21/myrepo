//import java.io.File;
import java.io.*;
import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.sql.Connection;
//import java.sql.DriverManager;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;


public class FileInfo {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private DerbyInf m_db ;
	private PreparedStatement m_pstmt;
	private int m_reverse = 0;
	//public FileInfo() {
	//	m_reverse = 0;
	//}
	public FileInfo(int areverse) {
		m_reverse = areverse;
	}
	
	public static void main(String[] args) {
		int ireverse=0;
		if (args.length >= 1) {
			if (args[0].equalsIgnoreCase("SCAN")) {
				if(!(args.length >= 3 && args.length <= 4)) {
					System.out.println("Usage: FileInfo scan directory saveTable [F:force]");
					System.exit(0);
				}
				//System.out.println("ARGS = " + args.length);
				System.out.println("Scan Directory : " + args[1]);
				System.out.println("Saved TableName: " + args[2]);
				FileInfo fi = new FileInfo(ireverse);
				if(args.length == 4) {
					if(args[3].equalsIgnoreCase("F") || args[3].equalsIgnoreCase("FORCE")) {
						fi.dropTable(args[2]);
						System.out.println("Table " + args[2] + " is dropped.");
					}
				}
				fi.scan(args[1],args[2]);
				
			} else if(args[0].equalsIgnoreCase("COMP") || args[0].equalsIgnoreCase("COMPR")) {
				if(args.length != 3) {
					System.out.println("Usage: FileInfo comp(R) sorceTable targetTable(bak)");
					System.exit(0);
				}
				if (args[0].equalsIgnoreCase("COMPR")) ireverse = 1;
				System.out.println("Source Table: " + args[1]);
				System.out.println("Target Table: " + args[2]);
				FileInfo fi = new FileInfo(ireverse);
				fi.compareSame(args[1], args[2]);
				fi.compareNew(args[1], args[2]);
				fi.compareChanged(args[1], args[2]);
			} else if(args[0].equalsIgnoreCase("CHECKDUP") || args[0].equalsIgnoreCase("CHECKDUPR")) {
				if(args.length < 2) {
					System.out.println("Usage: FileInfo checkdup(R) table1 [table2]) [reverse]");
					System.exit(0);
				}
				if (args[0].equalsIgnoreCase("CHECKDUPR")) ireverse = 1;
				String table1 = args[1];
				String table2 = table1;
				if (args.length == 3) {
					table2 = args[2];
				}
				System.out.println("Table 1: " + table1);
				System.out.println("Table 2: " + table2);
				FileInfo fi = new FileInfo(ireverse);
				fi.checkDup(table1, table2);
			} else if(args[0].equalsIgnoreCase("FIND")) {
				if(args.length < 3) {
					System.out.println("Usage: FileInfo find table find_file_name [ \"and lcase(name) like '%' ...order by path, name \"] ");
					System.exit(0);
				}
				String table = args[1];
				String find_file = args[2];
				System.out.println("Table  : " + table);
				System.out.println("Search : " + find_file);
				FileInfo fi = new FileInfo(ireverse);
				// String sql = "select path ||' ... '|| name from " + table + " where name like '" + find_file + "'";
                //String sql = "select name ||', '||substr('........................................', 1, case when length(name) > 40 then 0 else 40 - length(name) end)||'... ,'|| path||', '||size||', '||mdate from " 
                //            + table + " where name like '" + find_file + "'";
                //String sql = "select name||', '||cast(size as char(15))||', '||mdate||', '||path from " + table + " where name like '" + find_file + "'";
                String sql = "select name, size, mdate, path from " + table + " where name like '" + find_file + "'";
                if(args.length == 4) sql = sql + " " + args[3];
                System.out.println("query : " + sql);
				fi.queryOut(sql);				
				
			} else if(args[0].equalsIgnoreCase("LIST")) {
				FileInfo fi = new FileInfo(ireverse);
				fi.listTable();
			} else if(args[0].equalsIgnoreCase("DROP")) {
				if(args.length != 2) {
					System.out.println("Usage: FileInfo drop tablename");
					System.exit(0);
				}
				System.out.println("Table: " + args[1]);
				FileInfo fi = new FileInfo(ireverse);
				fi.dropTable(args[1]);
			} else if(args[0].equalsIgnoreCase("OUT")) {
				if(args.length != 3) {
					System.out.println("Usage: FileInfo out table filename");
					System.exit(0);
				}
				System.out.println("Table: " + args[1]);
				System.out.println("File : " + args[2]);
				FileInfo fi = new FileInfo(ireverse);
				String sql = "select * from " + args[1] + " order by path, name";
				fi.queryOut(sql, args[2]);
			} else if(args[0].equalsIgnoreCase("SQL")) {
				if(args.length != 2) {
					System.out.println("Usage: FileInfo sql sql_statement");
					System.out.println("sample: FileInfo sql \"select name, size, mdate, path from this where name like '%doc%' and path like '%path%'\"" );
					System.exit(0);
				}
				System.out.println("SQL: " + args[1]);
				FileInfo fi = new FileInfo(ireverse);
				String sql = args[1];
				fi.queryOut(sql);
			} else {
				System.out.println("Usage: FileInfo scan/comp(R)/list/checkDup(R)/find/out/drop/sql");
			}
		} else {
			System.out.println("Usage: FileInfo scan/comp/list/checkDup/find/out/drop/sql");
		}
	}
	public void listTable() {
		StringBuffer sb = new StringBuffer();
		sb.append("select tablename t ");
		sb.append("  from sys.systables t, sys.sysschemas s ");
		sb.append(" where s.schemaid = t.schemaid  ");
		sb.append("   and s.schemaname = USER ");
		sb.append(" order by 1 ");
		
		this.queryOut(sb.toString());		
	}
	public void dropTable(String table_name) {
		this.dbOpen();
		this.m_db.dropTable(table_name);
		this.dbClose();
	}
	public void compareSame(String source_table, String target_table) {
		StringBuffer sb = new StringBuffer();
		String file_name = "out_" + source_table + "_" + target_table + ".same.csv";
		sb.append("select fn_similar2(s.path, t.path, " + m_reverse + " ) similar ");
		sb.append("     , s.name, s.path, s.pname, s.size, s.mdate ");
		sb.append("     , t.path tpath ");
		sb.append("  from " + source_table +" s, " + target_table + " t ");
		sb.append(" where s.name = t.name  ");
		sb.append("   and s.pname = t.pname  ");
		sb.append("   and s.size = t.size  ");
		sb.append("   and s.mdate= t.mdate ");
		sb.append(" order by s.path, s.name ");
		
		this.queryOut(sb.toString(), file_name);
	}
	public void compareNew(String source_table, String target_table) {
		StringBuffer sb = new StringBuffer();
		String file_name = "out_" + source_table + "_" + target_table + ".new.csv";
		sb.append("select s.name, s.path, s.size, s.mdate    ");
		sb.append("  from " + source_table + " s             ");
		sb.append(" where not exists                         ");
		sb.append("    (select 1 from " + target_table + " t ");
		sb.append("      where t.name = s.name               ");
		sb.append("        and fn_similar(t.path,s.path, " + m_reverse + " ) > 0 ");
		//sb.append("        and t.pname = s.pname   "         );
		sb.append("     )");
		sb.append(" order by s.path, s.name ");
		
		this.queryOut(sb.toString(), file_name);
	}
	public void compareChanged(String source_table, String target_table) {
		StringBuffer sb = new StringBuffer();
		String file_name = "out_" + source_table + "_" + target_table + ".changed.csv";
		sb.append("select fn_similar2(s.path, t.path, " + m_reverse + " ) similar ");
		sb.append("     , s.name, s.path, s.pname, s.size, s.mdate ");
		sb.append("     , t.path tpath, t.pname tpname, t.size tsize, t.mdate tmdate ");
		sb.append("  from " + source_table +" s, " + target_table + " t ");
		sb.append(" where s.name = t.name  ");
		//sb.append("   and s.pname = t.pname ");
		sb.append("   and s.mdate > t.mdate ");
		sb.append("   and fn_similar(s.path, t.path, " + m_reverse + " ) > 0 ");
		sb.append(" order by s.path, s.name ");
		
		this.queryOut(sb.toString(), file_name);
	}
	
	public void checkDup(String source_table, String target_table) {
		StringBuffer sb = new StringBuffer();
		String file_name = "out_" + source_table + "_" + target_table + ".dup.csv";
		/*
		sb.append("select fn_similar(s.path, t.path) similar ");
		sb.append("     , s.name, s.path, s.pname, s.size, s.mdate ");
		sb.append("     , t.path tpath ");
		sb.append("  from " + source_table +" s, " + target_table + " t ");
		sb.append(" where s.name = t.name  ");
		sb.append("   and s.size = t.size  ");
		sb.append("   and s.mdate = t.mdate ");
		sb.append("   and s.path <> t.path ");
		sb.append("   and s.size > 0 ");
		sb.append(" order by similar desc, s.path, s.name ");
		*/
		sb.append("select fn_similar2(s.path, t.path, " + m_reverse + " ) similar ");
		sb.append("     , s.name, s.path, s.size, s.mdate ");
		sb.append("     , t.path tpath ");
		sb.append("  from ");
		
		sb.append("(select s.name, max(s.path) path , s.size, s.mdate ");
		sb.append("   from " + source_table +" s, " + target_table + " t ");
		sb.append("  where s.name = t.name  ");
		sb.append("    and s.size = t.size  ");
		sb.append("    and s.mdate = t.mdate ");
		sb.append("    and s.path <> t.path ");
		sb.append("    and s.size > 0 ");
		sb.append("  group by s.name, s.size, s.mdate) s ");

        sb.append(" , " + target_table + " t ");
		sb.append(" where s.name = t.name  ");
		sb.append("   and s.size = t.size  ");
		sb.append("   and s.mdate = t.mdate ");
		sb.append("   and s.path <> t.path ");
		sb.append("   and s.size > 0 ");
		sb.append(" order by similar desc, s.path, s.name ");

		this.queryOut(sb.toString(), file_name);
	}
	
	public void queryOut(String sql) {
		
		this.dbOpen();
		Statement stmt  = this.m_db.getStatement();
		ResultSet rs;
		try {
			rs = stmt.executeQuery(sql);
			//ResultSetMetaData rsm = ;
			int icol = rs.getMetaData().getColumnCount();
            for(int i=1; i<=icol; i++) {
                System.out.print(rs.getMetaData().getColumnName(i));
                if(i<icol) System.out.print(",");                
            }
            System.out.println("");
			while(rs.next()) {
				for(int i=1; i<=icol; i++) {
					System.out.print('"' + rs.getString(i) + '"');
					if(i<icol) System.out.print(",");
				}
				System.out.print("\n");
			}

			rs.close();
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (Exception e2) {
			e2.printStackTrace();
		} finally {
			this.dbClose();
		}
	}
	public void queryOut(String sql, String file_name) {
		
		this.dbOpen();
		Statement stmt  = this.m_db.getStatement();
		ResultSet rs;
		BufferedWriter out;
		long icnt = 0;
		try {
			out = new BufferedWriter(new FileWriter(file_name));
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsm = rs.getMetaData();
			int icol = rsm.getColumnCount();
			for(int i=1; i<=icol; i++) {
				out.write("\"" + rsm.getColumnName(i) + "\"");
				if(i<icol) {
					out.write(",");
				}
				else {
					out.write("\r\n");
				}
			}
			
			while(rs.next()) {
				icnt ++;
				for(int i=1; i<=icol; i++) {
					out.write("\"" + rs.getString(i) + "\"");
					if(i<icol) out.write(",");
				}
				out.write("\r\n");
			}

			out.close();
			rs.close();
			if(icnt == 0) {
				System.out.println("========================");
				System.out.println(">>>  No Data Found  <<<<");
				System.out.println("========================");
				
			} else {
				System.out.println("========================");
				System.out.println(icnt + " rows founded");
				System.out.println("========================");
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (Exception e2) {
			e2.printStackTrace();
		} finally {
			this.dbClose();
		}
	}
	public void scan(String targetDir, String tableName) {
		this.dbOpen(tableName);
		this.prepareScan(tableName);
		this.doScan(targetDir);
		this.dbClose();
	}

	public void dbOpen() {
		m_db = new DerbyInf();
		m_db.connect();
	}
	public void dbOpen(String tableName) {
		this.dbOpen();
		m_db.createTable(tableName);
	}
	public void prepareStatement(String sql) {
		try {
			if (m_pstmt != null) {
				m_pstmt.close();
			}
			m_pstmt = m_db.getPreparedStatement(sql);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
	public void prepareScan(String tableName) {
		StringBuffer sb = new StringBuffer();
		sb.append("insert into "+ tableName + "(name, path, pname, size, mdate) ");
		sb.append(" values(?,?,?,?,?)");
		try {
			if (m_pstmt != null) {
				m_pstmt.close();
			}
			m_pstmt = m_db.getPreparedStatement(sb.toString());
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
	public void dbClose() {
		try {
			if (m_pstmt != null) m_pstmt.close();
			m_db.close();
		}catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}
	public void doScan(String folder) {

		File dir = new File(folder);
		
		if(!dir.exists() || !dir.isDirectory()) {
			System.out.println("\nParameter is not a diretory");
			System.exit(1);
		}
		File[] files = dir.listFiles();
		if (files == null) {
			System.err.println("\n** Can't read this Directory ->" + dir.getAbsolutePath());
			return;
		}
		for (int i=0; i < files.length; i++) {
			if(files[i].isDirectory()) {
				//System.out.println("..." + files[i].getAbsolutePath());
				System.out.print(".");
				doScan(files[i].getAbsolutePath());
			}
			else {
				//System.out.println( files[i].getAbsolutePath()+":"+files[i].length()+":"+getDateString(files[i].lastModified()));
				try {
					m_pstmt.setString(1, files[i].getName());
					m_pstmt.setString(2, files[i].getParent());
					m_pstmt.setString(3, getPname(files[i].getParent()));
					m_pstmt.setLong(4,files[i].length());
					m_pstmt.setDate(5, new Date(files[i].lastModified()));
					m_pstmt.execute();
				} catch (Exception e) {
					System.out.println("\n"+files[i].getAbsolutePath()+":"+files[i].length()+":"+getDateString(files[i].lastModified()));
					System.err.println(e.getMessage());
				}
			}
		}

	}
	private String getPname(String fullName) {
		String fileSep = File.separator;
		String rval = "";
		int i = fullName.lastIndexOf(fileSep);
		if (i > 0) {
			rval = fullName.substring(i +1);
		}
		//System.out.println(fullName + " > " + fileSep + i + " : "+ rval);
		return rval;
	}
	private String getDateString(long date) {
		return dateFormat.format(date);
	}
}
