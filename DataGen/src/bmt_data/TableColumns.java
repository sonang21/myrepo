package bmt_data;

import java.io.*;
import java.math.BigInteger;

import java.sql.*;
import java.util.Calendar;
import java.util.Random;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.Attribute;
import javax.xml.stream.events.EndElement;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

public class TableColumns {
	private String m_table_name;
	private List<DataColumn> m_columns;
	private long m_rowCount = 0;
	private long m_curCount = 0;
	private int  m_batchSize = 100;

	TableColumns(String table_name, List<DataColumn> columns) { 
		m_table_name = table_name;
		m_columns = columns;
	}
	TableColumns(String defineXmlFile) {
		//this(table_name);
		m_columns = readXmlDefine(defineXmlFile);
	}	
	public void addColumn(DataColumn column) {
		m_columns.add(column);
	}
	
	public String getTableName() { return m_table_name; }
	public String getInsertSQL() {
		String sql1="insert into " + m_table_name + "(" + m_columns.get(0).getColumnName();
		String sql2=" values(?";
		for (int i=1; i< m_columns.size();i++) {
			sql1 = sql1 + ","+m_columns.get(i).getColumnName();
			sql2 = sql2 + ",?";
		}
		sql1 = sql1 + ") " + sql2 + ")";
		return sql1;
	}
	
	public int insertDB (Connection conn) {
		int rows = 0;
		if(m_columns == null) { 
			System.err.println("[ERROR] insertDB: No Column Define");
			return 0;
		}
		try {
			System.out.println(getInsertSQL());
			PreparedStatement stmt = conn.prepareStatement(getInsertSQL());
			Statement exec = conn.createStatement();
			exec.execute("truncate table "+ m_table_name);
			//Iterator<DataColumn> it  = m_columns.iterator();
			DataColumn dc;
			while(nextValue()) {
				rows ++;
				for( int i=0; i < m_columns.size(); i++) {
					dc = m_columns.get(i);
					switch (dc.getDataType()) {
					case STRING:	stmt.setString(i+1, dc.getString()); break;
					case DATESTRING:	stmt.setString(i+1, dc.getDateString()); break;
					case INTEGER: 	stmt.setInt(i+1, dc.getInt()); break;
					case BIGINT: 	stmt.setLong(i+1, dc.getLong()); break;
					case DOUBLE:	stmt.setDouble(i+1, dc.getDouble()); break;
					case DATE:		stmt.setDate(i+1, dc.getDate(),null);
								//System.out.println("DEBUG: " + dc.getDate());
								break;
					default:	System.err.println("[WARNNING] Undifined Type " + dc.getDataType().toString());
								stmt.setString(i+1, dc.getString()); 
								break;
						
					}
				}
				stmt.addBatch();
				if((rows % m_batchSize) == 0) {
					stmt.executeBatch();
					stmt.clearBatch();
					conn.commit();
					System.out.println("진행: [" + m_table_name + "]에 "+(rows) + " 건 입력...");
				}
			}
			if((rows % m_batchSize) != 0) {
				stmt.executeBatch();
				stmt.clearBatch();
				conn.commit();
			}
			System.out.println("완료: [" + m_table_name + "]에 "+(rows) + " 건 입력되었습니다.");
			stmt.close();
		}
		catch(SQLException e) {
			System.err.println("[ERROR] insertDB a: " + e.getMessage());
		}
		finally {
			
		}
		return rows;
	}
	
	
	public List<DataColumn> getColumns() {
		return m_columns;
	}
	public boolean nextValue() {
		if(m_curCount >= m_rowCount) return false;
		
		for(int i=0; i < m_columns.size(); i++){
			m_columns.get(i).nextValue();
		}
		//Iterator<DataColumn> cols = m_columns.iterator();
		//while(cols.hasNext()) {
		//	cols.next().nextValue();
		//}
		m_curCount ++;
		return true;
	}
	public void printValues() {
		for(int i=0; i < m_columns.size(); i++){
			System.out.println(m_columns.get(i).getColumnName()+ "(" + m_columns.get(i).getCurX() + ")"+ m_columns.get(i).toString());
		}
	}
	
	//@SuppressWarnings({ "unchecked" })
	public List<DataColumn>  readXmlDefine(String xmlFile) {
		final String [] elementNames = {"name","data_type","format"}; //values, value

		List<DataColumn> cols = new ArrayList<DataColumn>();
		try {
			// First create a new XMLInputFactory
			XMLInputFactory inputFactory = XMLInputFactory.newInstance();
			// Setup a new eventReader
			InputStream in = new FileInputStream(xmlFile);
			XMLEventReader eventReader = inputFactory.createXMLEventReader(in);
			// Read the XML document
			DataColumn col = null;
			List<String> valueList = null; //new ArrayList();
			m_table_name="";

			reading:
			while (eventReader.hasNext()) {
				XMLEvent event = eventReader.nextEvent();

				if (event.isStartElement()) 
				{
					StartElement startElement = event.asStartElement();
					//System.out.println(startElement.getName());
					// If we have a item element we create a new item
					if (startElement.getName().getLocalPart().equals("table")) {
						// We read the attributes from this tag and add the date attribute to our object
						Iterator<Attribute> attributes = startElement.getAttributes();
						while (attributes.hasNext()) {
							Attribute attribute = attributes.next();
							if (attribute.getName().toString().equals("name"))
								m_table_name = attribute.getValue();
							else if (attribute.getName().toString().equals("count"))
								m_rowCount = Long.valueOf(attribute.getValue());
							else if (attribute.getName().toString().equals("batch_size"))
								m_batchSize = Integer.valueOf(attribute.getValue());						}
					}
					if (startElement.getName().getLocalPart().equals("column")) {
						col = new DataColumn();
						col.setTableName(m_table_name);
						// We read the attributes from this tag and add the date attribute to our object
						Iterator<Attribute> attributes = startElement.getAttributes();
						while (attributes.hasNext()) {
							Attribute attribute = attributes.next();
							if (attribute.getName().toString().equals("name"))
								col.setColumnName(attribute.getValue());
						}
					}
					if (startElement.getName().getLocalPart().equals("values")) {
						valueList = new ArrayList<String>();
						Iterator<Attribute> attributes = startElement.getAttributes();
						while (attributes.hasNext()) {
							Attribute attribute = attributes.next();
							if (attribute.getName().toString().equals("pattern"))
								//if(attribute.getValue().length()>0)
								col.setPattern(attribute.getValue());
							else if (attribute.getName().toString().equals("start"))
								col.setRangeStartValue(Long.valueOf(attribute.getValue()));
							else if (attribute.getName().toString().equals("end")) {
								if(attribute.getValue().length()>0)
									col.setRangeEndValue(Long.parseLong(attribute.getValue()));
							}
							else if (attribute.getName().toString().equals("step")) {
								col.setRangeStep(Integer.parseInt(attribute.getValue()));
							}
							else if (attribute.getName().toString().equals("dup")) {
								col.setRangeDup(Integer.parseInt(attribute.getValue()));
							}
							else if (attribute.getName().toString().equals("random")) {
								col.setIsRandom(attribute.getValue());
							}
						}
						continue reading;
					}
					
					
					else if (event.asStartElement().getName().getLocalPart().equals("value"))
					{
						String delim = "";
						
						if(col.isList()) {
							Iterator<Attribute> attributes = startElement.getAttributes();
							while (attributes.hasNext()) {
								Attribute attribute = attributes.next();
								if (attribute.getName().toString().equals("delim")) {
									delim = attribute.getValue();
								}
							}
							
							event = eventReader.nextEvent();
							if(delim.length()>0) {
								String[] list = event.asCharacters().getData().split(delim);
								for(int i=0; i < list.length; i++){
									valueList.add(list[i]);
								}
							} else {
								valueList.add(event.asCharacters().getData());
							}
						} else if(col.isDate()) {
							event = eventReader.nextEvent();
							col.setValue((Object)Date.valueOf(event.asCharacters().getData()));
						}
						continue reading;
					}
					else {
						for(int i=0; i< elementNames.length; i++)
						{
							if (event.asStartElement().getName().getLocalPart().equals(elementNames[i])) 
							{
								event = eventReader.nextEvent();
								col.setAttribute(elementNames[i], event.asCharacters().getData());
								//System.out.println("DEBUG:" + event.asCharacters().getData());
								continue reading;
							}
							
						}
					}
				}
				// If we reach the end of an item element we add it to the list
				if (event.isEndElement()){
					EndElement endElement = event.asEndElement();
					if (endElement.getName().getLocalPart().equals("column")){
						cols.add(col);
					} else if (endElement.getName().getLocalPart().equals("value_list")){
						//String[] values = (String []) valueList.toArray();
						col.setValueList(valueList.toArray());
					} else if (endElement.getName().getLocalPart().equals("values")){
						if(col.isList()) {
							if(col.isDate()) {
								Date[] dt = new Date[valueList.size()];
								for(int i=0; i < dt.length; i++) {
									dt[i] = Date.valueOf(valueList.get(i));
								}
								col.setValueList(dt);
							} else {
								col.setValueList(valueList.toArray());
							}
						}
					}
				}

			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (XMLStreamException e) {
			e.printStackTrace();
			return null;
		}
		return cols; 
	}
	
	//@SuppressWarnings({ "unchecked" })
	public static void printXmlDefine(String xmlFile) {
		try {
			// First create a new XMLInputFactory
			XMLInputFactory inputFactory = XMLInputFactory.newInstance();
			// Setup a new eventReader
			InputStream in = new FileInputStream(xmlFile);
			XMLEventReader eventReader = inputFactory.createXMLEventReader(in);
			// Read the XML document
			while (eventReader.hasNext()) {
				XMLEvent event = eventReader.nextEvent();

				if (event.isStartElement()) 
				{
					StartElement startElement = event.asStartElement();
					System.out.print(startElement.getName().getLocalPart() + "(");
					Iterator<Attribute> attributes = startElement.getAttributes();
					int i=0;
					while (attributes.hasNext()) {
						i++;
						Attribute attribute = attributes.next();
						if(i>1) System.out.print(",");
						System.out.print(attribute.getName().toString()+"="+attribute.getValue());
					}
					System.out.print("):");
				} else if(event.isEndElement()) {
					System.out.print("\n");
				} else if(event.isCharacters())
				{
					System.out.print(event.asCharacters().getData());
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (XMLStreamException e) {
			e.printStackTrace();
		}
	}
	
	public void printSpec() {
		for(int i=0; i < m_columns.size(); i++){
			System.out.println(m_columns.get(i).getAllString());
		}
	}
	public static void main(String [] args) {
		//genTableXml("기본제원");
		printXmlDefine("src\\기본제원.xml");
	}
	public static void genTableXml(String table_name, String file_name, String target_name) {
		genTableXml(table_name, file_name, target_name, true);
	}
	public static void genTableXml(String table_name, String file_name
			                     , String target_name, boolean safeCreate) {
		LocalConf dbcfg = new LocalConf(target_name);
		//String driver = dbcfg.getDriver();
		//String url = dbcfg.getURL();
		//String user = dbcfg.getUser();
		//String pass = dbcfg.getPass();
		final String RANGE_MAX = "999999999999";
		String sql = "";
		if(dbcfg.getDBMS().equalsIgnoreCase("ORACLE")) {
			sql = " select c.column_name, c.data_type " +
		               " , c.data_length, c.data_precision, c.data_scale " +
		               " , c.nullable , nvl2(p.column_name, 'Y','N') as key " +
		          " from user_tab_columns c" +
		               ",(select col.table_name, col.column_name " +
		               "  from user_constraints con, user_cons_columns col " +
		               "  where con.table_name = ? " +
		               "    and con.constraint_type = 'P' " +
		               "    and con.constraint_name = col.constraint_name) p " +
		          " where c.table_name = ? " +
		          "   and c.table_name = p.table_name(+) " +
		          "   and c.column_name = p.column_name(+) " +
		          " order by c.column_id ";
		} else if(dbcfg.getDBMS().equalsIgnoreCase("ALTIBASE")) {
			sql =    "select c.column_name     " + 
			         "     , DECODE(c.data_type   " + 
					 "          ,1     ,'CHAR'    " + 
					 "          ,12    ,'VARCHAR' " + 
					 "          ,-8    ,'NCHAR'   " + 
					 "          ,-9    ,'NVARCHAR'" + 
					 "          ,2     ,'NUMERIC' " + 
					 "          ,6     ,'NUMBER'  " + 
					 "          ,8     ,'DOUBLE'  " + 
					 "          ,7     ,'REAL'    " + 
					 "          ,-5    ,'BIGINT'  " + 
					 "          ,4     ,'INTEGER' " + 
					 "          ,5     ,'SMALLINT'" + 
					 "          ,9     ,'DATE'    " + 
					 "          ,30    ,'BLOB'    " + 
					 "          ,40    ,'CLOB'    " + 
					 "          ,20001 ,'BYTE'    " + 
					 "          ,20002 ,'NIBBLE'  " + 
					 "          ,-7    ,'BIT'     " + 
					 "          ,-100  ,'VARBIT'  " + 
					 "          ,10003 ,'GEOMETRY'" + 
					 "          ,'?') data_type   " + 
					 "     , c.size-2     data_length    " + 
					 "     , c.precision  data_precision " + 
					 "     , c.scale      data_scale     " + 
					 "     , decode(c.is_nullable,'T','NULL','F','NOT NULL') NULLABLE " + 
					 "     , nvl2(p.column_id,'Y','N') as KEY " + 
					 "from system_.sys_users_ u             " + 
					 "     join system_.sys_tables_ t on t.user_id = u.user_id      " + 
					 "     join  system_.sys_columns_ c on c.table_id = t.table_id  " + 
					 "     left outer join                               " + 
					 "     (select c.column_id                           " + 
					 "      from system_.sys_tables_ t                   " + 
					 "         , system_.sys_users_ u                    " + 
					 "         , system_.sys_constraints_ p              " + 
					 "         , system_.sys_constraint_columns_ c       " + 
					 "      where u.user_name = upper(?)                 " + 
					 "        and t.table_name =  upper(?)               " + 
					 "        and t.user_id = u.user_id                  " + 
					 "        and p.user_id = t.user_id                  " + 
					 "        and p.table_id = t.table_id                " + 
					 "        and p.constraint_type=3                    " + 
					 "        and c.constraint_id = p.constraint_id      " + 
					 "     ) p on c.column_id = p.column_id              " + 
					 "where u.user_name = upper(?) " + 
					 "  and t.table_name = upper(?) " + 
					 "order by u.user_name, t.table_name, c.column_order ";
		}

		try {
			if(safeCreate && (new File(file_name)).exists()) {
				System.err.println("[ERROR] genTableXml: \n\t [" + file_name + "] is already exists.\n");
				return;
			}
			
			//Class.forName(driver);
			//Connection conn = DriverManager.getConnection(url, user,pass);
			Connection conn = dbcfg.getConnection();
			PreparedStatement pstm = conn.prepareStatement(sql);
			if(dbcfg.getDBMS().equalsIgnoreCase("ORACLE")) {
				pstm.setString(1, table_name);
				pstm.setString(2, table_name);
			} else if (dbcfg.getDBMS().equalsIgnoreCase("ALTIBASE")) {
				pstm.setString(1, dbcfg.getUser());
				pstm.setString(2, table_name);
				pstm.setString(3, dbcfg.getUser());
				pstm.setString(4, table_name);
			}
			
			ResultSet rs = pstm.executeQuery();
			if(! rs.isBeforeFirst()) {
				System.err.println("[ERROR]: No MetaData for Table[" + table_name + "] ");
				rs.close();
				pstm.close();
				conn.close();
				return;
			}
			BufferedWriter out = new BufferedWriter(new FileWriter(file_name));
		    out.write("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n");
			out.write("<table name=\""+table_name+"\" count=\"1000\" batch_size=\"1000\">\n");
			String data_type;
			String format;
			int data_len=1;
			while (rs.next()) {
				out.write("\t<column>\n");
				out.write("\t\t<name>"+rs.getString("column_name")+"</name>\n");
				out.write("\t\t<spec type=\""+rs.getString("data_type")+"\""
						+ " len=\"" + rs.getString("data_length") + "\""
						+ " prec=\"" + rs.getString("data_precision") +"\""
						+ " scale=\"" + rs.getString("data_scale") + "\""
						+ " null=\"" + rs.getString("nullable") +"\""
						+ " pk=\"" + rs.getString("key") +"\""
						+ "/>\n");
				data_type = rs.getString("data_type");
				if (data_type.equals("VARCHAR2")) data_type="STRING";
				else if (data_type.equals("VARCHAR")) data_type="STRING";
				else if (data_type.equals("CHAR")) data_type="STRING";
				else if (data_type.equals("LONG")) data_type="STRING";
				else if (data_type.equals("NUMBER")) {
					if(rs.getInt("data_scale") > 0) data_type="DOUBLE";
					else if(rs.getInt("data_precision") > 4) data_type="BIGINT";
					else data_type="INTEGER";
				} else if (data_type.equals("DATETIME")) data_type="DATE";
				
				if(data_type.equals("STRING")) data_len = rs.getInt("data_length");
				else if(data_type.equals("INTEGER")) data_len = rs.getInt("data_precision");
				else if(data_type.equals("BIGINT")) data_len = rs.getInt("data_precision");
				else if(data_type.equals("DOUBLE")) data_len = rs.getInt("data_precision")-rs.getInt("data_scale");
				else data_len=1;
				if (data_len > 20) data_len=20;
				if (data_len > 1) 
					format = "%0"+data_len +"d";
				else
					format = "%d";
				
				out.write("\t\t<data_type>" + data_type + "</data_type>  <format>"+format+"</format>\n");
				//System.out.println(data_len);
				out.write("\t\t<values pattern=\"range\" start=\"1\" end=\"" 
						  + RANGE_MAX.substring(0,Math.min(RANGE_MAX.length(),data_len))+ "\" random=\""
						  + (rs.getString("key").equals("N")) + "\">\n");
				out.write("\t\t\t<!--value delim=\",\">2010-01-01</value-->\n");
				out.write("\t\t</values>\n");
				out.write("\t</column>\n");
			}
			out.write("</table>\n");
			
			out.close();
			System.out.println("[SUCCESS]genTableXml:\n\t[" + table_name + "] 테이블에 대한  [" + file_name + "]이 생성되었습니다.");
			rs.close();
			pstm.close();
			conn.close();
		} 
		//catch(ClassNotFoundException e) {
		//	System.err.println("[ERROR] ClassNotFoundException: " + e.getMessage());
		//	e.printStackTrace();
		//}
		catch(SQLException e){
			System.err.println("[ERROR] SQLException " + e.getMessage());
			e.printStackTrace();
			
		}catch (IOException e) {
			System.err.println("[ERROR] IOException " + e.getMessage());
			e.printStackTrace();
		}

		finally {
		
		}
	}
	
}


class DataColumn {
	enum DATA_TYPE	{
		STRING, INTEGER, BIGINT, DOUBLE, DATE, DATESTRING, OTHER
	}
	enum VAL_PATTERN {
		RANGE, LIST
	}
	private String m_table_name;
	private String m_column_name;
	private Object m_value;
	private DATA_TYPE m_datatype;
	private VAL_PATTERN m_pattern; 
	private boolean m_isRandom;
	private String m_format="";
	private long m_range_start;
	private long m_range_end;
	private long m_range_cur;
	private int  m_range_step;
	private int  m_range_dup; 
	private int  m_range_dup_ix=0;
	private Object[] m_valueList;
	
	DataColumn() {
		m_range_cur = -1;
		m_range_start = 0;
		m_range_end = 9999999999999999l;
		m_range_step = 1;
		m_range_dup = 1;
	}
	DataColumn(String colname) {
		this();
		m_column_name = colname;
		
	}
	
	DataColumn (String colname, DATA_TYPE type, VAL_PATTERN pattern, boolean isRandom) {
		this(colname);
		m_datatype = type;
		m_pattern = pattern;
		m_isRandom = isRandom;
		if (type == DATA_TYPE.DATE) {
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_MONTH, -1);
			m_value = new Date(c.getTimeInMillis());
		}
	}

	//RANGE
	DataColumn (String colname, DATA_TYPE type, long range_start, long range_end, boolean isRandom) {
		this(colname, type, VAL_PATTERN.RANGE, isRandom);
		m_range_start = range_start;
		m_range_end = range_end;
		m_range_cur = m_range_start-1;
	}
	//Range 1~ max
	DataColumn (String colname, DATA_TYPE type, long maxCount, boolean isRandom) {
		this(colname, type, 1l, maxCount, isRandom);
	}
	//LIST, CYCLE
	DataColumn (String colname, DATA_TYPE type, Object[] valueList, boolean isRandom) {
		this(colname, type, VAL_PATTERN.LIST, isRandom);
		m_valueList = valueList;
		m_range_end = valueList.length-1;
	}
	
    public void  setTableName(String table_name)   { m_table_name = table_name; }
	public void  setColumnName(String column_name) { m_column_name = column_name;}
	public void  setDataType(String datatype) { 
		m_datatype = DATA_TYPE.valueOf(datatype.toUpperCase());
		if (m_datatype == DATA_TYPE.DATE || m_datatype == DATA_TYPE.DATESTRING) {
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_MONTH, -1);
			m_value = new Date(c.getTimeInMillis());
			m_valueList = new Object[1];
			m_valueList[0] = ((Date)m_value).clone();
		}
	}
	public void  setPattern(String pattern) 	{ m_pattern = VAL_PATTERN.valueOf(pattern.toUpperCase()); }
	public void  setIsRandom(String isRandom) 	{ m_isRandom = isRandom.equalsIgnoreCase("TRUE"); }
	public void  setFormat(String format) 		{ m_format = format; }
	public void  setRangeStartValue(long start) { m_range_start = start; m_range_cur = start -1;}
	public void  setRangeEndValue(long end)     { m_range_end = end; }
	public void  setRangeStep(int step)			{ m_range_step = step; }
	public void  setRangeDup(int dup)			{ m_range_dup = dup; }
	public void  setValue(Object value){ 
		m_value = value;
		if(m_datatype == DATA_TYPE.DATE || m_datatype == DATA_TYPE.DATESTRING) {
			m_valueList = new Object[1];
			m_valueList[0] = ((Date)m_value).clone();
		}
	}
	public void  setValueList(Object[] valueList){ 
		m_valueList = valueList; 
		m_range_cur = -1; 
		m_range_start=0; 
		m_range_end = valueList.length-1;
	}
	public boolean  setAttribute(String attribute_name, Object attribute_value) {
		if(attribute_name.equals("name")) setColumnName((String)attribute_value);
		else if(attribute_name.equals("data_type")) setDataType((String)attribute_value);
		else if(attribute_name.equals("pattern")) 	setPattern((String)attribute_value);
		else if(attribute_name.equals("is_random")) setIsRandom((String)attribute_value);
		else if(attribute_name.equals("format"))	setFormat((String)attribute_value);
		else if(attribute_name.equals("start_value")) setRangeStartValue(Long.valueOf((String)attribute_value));
		else if(attribute_name.equals("end_value")) setRangeEndValue(Long.valueOf((String)attribute_value));
		else if(attribute_name.equals("value_list")) setValueList((Object[])attribute_value);
		else {
			System.err.println("[ERROR] DataColumn.setAttribute() can't set value for [" + attribute_name + "]");
			return false;
		}
		
		return true;
	}
	

	public String   getTableName() { return m_table_name; }
	public String   getColumnName() { return m_column_name; }
	public boolean  eqaulName (String name) { return m_column_name.equals(name); }
	public DATA_TYPE getDataType() { return m_datatype; }
	public boolean  isList() 	{ return m_pattern.toString().equals("LIST"); }
	public boolean  isDate() 	{ return m_datatype.toString().equals("DATE")||m_datatype.toString().equals("DATESTRING"); }
	public String 	toString()	{ return String.valueOf(m_value); }
	public String 	getString()	{ return (String)(m_value); }
	public String 	getDateString()	{
		String sdt;
		if(m_format.length() >=8) {
			Calendar c = Calendar.getInstance();
			c.setTimeInMillis(((Date)m_value).getTime());
			int yy = c.get(Calendar.YEAR);
			int mm = c.get(Calendar.MONTH)+1;
			int dd = c.get(Calendar.DAY_OF_MONTH);
			//int hh = c.get(Calendar.HOUR_OF_DAY);
			//int mi = c.get(Calendar.MINUTE);
			//int ss = c.get(Calendar.SECOND);
			if(m_format.equalsIgnoreCase("yyyymmdd")) sdt = String.format("%04d%02d%02d", yy,mm,dd);
			else if(m_format.equalsIgnoreCase("yyyy/mm/dd")) sdt = String.format("%04d/%02d/%02d", yy,mm,dd);
			else sdt = ((Date)m_value).toString();
		} else {
			sdt = ((Date)m_value).toString();
		}
		return sdt;
	}
	public int		getInt() 	{ return (Integer)	m_value; }
	public long		getLong() 	{ return (Long)	m_value; }
	public Double 	getDouble() { return (Double) m_value; }
	public Date  	getDate() 	{ return (Date) m_value; }
	public Object   getValue()  { return m_value; }
	public long     getCurX()   { return m_range_cur; }
	public String   getAllString() {
		String rval="";
		if (m_pattern.toString().equals("LIST")) {
			for(int i=0; i < m_valueList.length; i++) {
				if(i > 0) rval = rval+",";
				rval = rval + (String)m_valueList[i]; 
			}
			rval = "Name:" + m_table_name+ "." + m_column_name + ", DataType:"+ m_datatype.toString() + ", format:" + m_format 
		       + ", Pattern:" + m_pattern.toString() + ", cur:" + m_range_cur
		       + ", Random:" + m_isRandom + "\n ValueList:" + rval;
		} else
		{
			rval = "Name:" + m_table_name+ "." + m_column_name + ", DataType:"+ m_datatype.toString() + ", format:" + m_format 
		       + ", Pattern:" + m_pattern.toString() + ", Range:" + m_range_start + "~" + m_range_end
		       + ", cur:" + m_range_cur
		       + ", Random:" + m_isRandom;
		}
		return rval;
	}
	
	public boolean  nextValue() {
			if (m_isRandom) {
				Random rand = new Random();
				if (m_pattern == VAL_PATTERN.LIST) {
					m_range_cur = rand.nextInt(m_valueList.length);
					//arrIx = rand.nextInt(m_valueList.length);
				}
				else {
					BigInteger bi = BigInteger.valueOf(m_range_end - m_range_start + 1L);
					bi =  BigInteger.valueOf(rand.nextLong()).mod(bi);
					m_range_cur = m_range_start + bi.longValue();
					//if (m_column_name.equals("적용단위구분")) System.out.println("DEBUG:nextValue:" + m_range_cur);
				}
			} else {
				if(++m_range_dup_ix > m_range_dup) {
					m_range_dup_ix = 1;
					m_range_cur = m_range_cur + m_range_step;
				}

				if(m_range_cur > m_range_end) m_range_cur = m_range_start;
				else if (m_range_cur < m_range_start) m_range_cur = m_range_start;
			}
			
		if (m_pattern == VAL_PATTERN.LIST) {
			m_value = m_valueList[(int)m_range_cur]; //[(int)arrIx];
		} else {
			if (m_datatype == DATA_TYPE.STRING && m_format.length() > 1) {
				m_value = String.format(m_format, m_range_cur);
			}else {
				switch (m_datatype) {
				case STRING:	m_value = String.valueOf(m_range_cur); break;
				case INTEGER: 	m_value = (int)(m_range_cur); break;
				case BIGINT: 	m_value = (long)(m_range_cur); break;
				case DOUBLE:	m_value = (double)m_range_cur; break;
				case DATE:
				case DATESTRING:
					Calendar c = Calendar.getInstance();
					c.setTimeInMillis(((Date)m_valueList[0]).getTime());
					c.add(Calendar.DAY_OF_MONTH, (int) m_range_cur);
					((Date)m_value).setTime(c.getTimeInMillis());
					//System.out.println("DEBUG: " + (Date)m_value + "," + m_range_cur + "," + m_range_start + ","+ m_range_end);
					break;
				default:  		break;
				}
				
			}
		} 
		return true;
	}
}
