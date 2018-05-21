package com.cslee.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

enum LOG_LEVEL { OFF, FATAL, ERROR, WARN, INFO, DEBUG, TRACE, ALL};

public class LogFile {
	public static final String LINE_SEPARATOR = System.getProperty("line.separator");
	
	
	private LOG_LEVEL m_logLevel = LOG_LEVEL.FATAL;
	private String m_sLogFileName = null;
	
	private SimpleDateFormat m_oDateFormat = null;
	private PrintStream m_oPrintStream = null;
	private boolean m_bIsFileOpen = false;

	private boolean m_bCloseAfterWrite = true;

	public LogFile(String sFileName, LOG_LEVEL logLevel, boolean bCloseAfterWrite) { 
		this.m_sLogFileName = sFileName;
		this.m_logLevel = logLevel;
		this.m_oDateFormat = new SimpleDateFormat("yyyy/MM/dd H:mm:ss.SSS");
		this.m_bCloseAfterWrite = bCloseAfterWrite;
	}	

	public LogFile(String sFileName, String sLogLevel, boolean bCloseAfterWrite) { 
		this(sFileName, LOG_LEVEL.valueOf(sLogLevel.toUpperCase()),  bCloseAfterWrite);
	}	

	
	
	public LogFile() 
	{
		this("./log/default.log", "DEBUG", true);
	}
	
	
	public LogFile(String sFileName) 
	{  
		this(sFileName, "DEBUG", false);
	}
	
	public void setFileName(String sFileName) { this.m_sLogFileName = sFileName; }
	public void setCloseAfterWrite(boolean bCloseAfterWrite) { this.m_bCloseAfterWrite = bCloseAfterWrite; };
	public LOG_LEVEL getLogLevel() { return m_logLevel; };
	public PrintStream getPrintStream() { 
		fileOpen();
		return this.m_oPrintStream; 
	}
	
	public boolean fileOpen() { return this.fileOpen(true); }
	
	public boolean fileOpen(boolean bAppend) {
		//System.out.println("Debug:fileOpen, start, m_bIsFileOpen = " + m_bIsFileOpen);
		try {
			if (! this.m_bIsFileOpen) {
				this.m_oPrintStream = new PrintStream(new FileOutputStream(this.m_sLogFileName, bAppend));
				this.m_bIsFileOpen = true;
			}
		} catch (IOException e) {
			this.m_bIsFileOpen = false;
			e.printStackTrace();
		}
		//System.out.println("Debug:fileOpen, end, m_bIsFileOpen = " + m_bIsFileOpen);
		return this.m_bIsFileOpen;
	}
	
	public void fileClose() {
		if (this.m_bIsFileOpen) {
			this.m_oPrintStream.close();
			this.m_bIsFileOpen = false;
		}
	}
	
	public void fileFlush() {
		if (this.m_bIsFileOpen) {
			this.m_oPrintStream.flush();
		}
	}

	public void logWrite(String sFormat, Object... args) { this.logWrite(LOG_LEVEL.OFF, sFormat, args);}
	public void logWrite(String sMsg) {this.logWrite(LOG_LEVEL.OFF, sMsg);}
	public void logWrite(LOG_LEVEL logLevel, String sFormat, Object... args) 
	{
		if (logLevel.ordinal() > this.m_logLevel.ordinal()) return;
		this.logWrite(logLevel, String.format(sFormat, args));
	}
	
	public synchronized void logWrite(LOG_LEVEL logLevel, String sMsg) {
		if (logLevel.ordinal() > this.m_logLevel.ordinal()) return;
		if (fileOpen()) {
			//this.m_oPrintStream.println(LINE_SEPARATOR + "["+this.m_oDateFormat.format(System.currentTimeMillis()) + ", " + m_sLogClass + "]: " + sMsg );
			this.m_oPrintStream.println(LINE_SEPARATOR + "["+this.m_oDateFormat.format(new Date().getTime()) + "]: " + sMsg );
			//this.m_oPrintStream.flush();
		}
		if (m_bCloseAfterWrite) {
			this.fileClose();
		}
	}
	
	public synchronized void logWrite(Exception e) 
	{
		if (this.fileOpen()) {
			String sStack = Thread.currentThread().getStackTrace()[2].toString();
			//this.m_oPrintStream.println(LINE_SEPARATOR + "[" + this.m_oDateFormat.format(System.currentTimeMillis()) + ", ERROR: " + sStack + "]");
			this.m_oPrintStream.println(LINE_SEPARATOR + "[" + this.m_oDateFormat.format(new Date().getTime()) + ", ERROR: " + sStack + "]");
			if (e instanceof SQLException) 
			{
				this.m_oPrintStream.println("ERROR :"  + ((SQLException)e).getMessage());
			}
			e.printStackTrace(this.m_oPrintStream);
		}
		if (m_bCloseAfterWrite) {
			this.fileClose();
		}
	}
	
	public synchronized void debugWrite(String sMsg) 
	{
		if(m_logLevel.ordinal() < LOG_LEVEL.DEBUG.ordinal()) return;
		
		if (this.fileOpen()) {
			String sStack = Thread.currentThread().getStackTrace()[2].toString();
			//this.m_oPrintStream.println(LINE_SEPARATOR + "[" + this.m_oDateFormat.format(System.currentTimeMillis()) + ", DEBUG: " + sStack +"]\n" + sMsg );
			this.m_oPrintStream.println(LINE_SEPARATOR + "[" + this.m_oDateFormat.format(new Date().getTime()) + ", DEBUG: " + sStack +"]\n" + sMsg );
		}
		if (m_bCloseAfterWrite) {
			this.fileClose();
		}
	}
	
	public synchronized void debugWrite(Exception e) 
	{
		if(m_logLevel.ordinal() < LOG_LEVEL.DEBUG.ordinal()) return;
		
		logWrite(e);
	}
	
	public static LOG_LEVEL LOG_LEVEL(String sLogLevel) 
	{
		return LOG_LEVEL.valueOf(sLogLevel.toUpperCase());
	}
	public String toString()
	{
		StringBuffer sb = new StringBuffer();
		sb.append("LogFile=" + this.m_sLogFileName);
		sb.append(", LogLevel=" + this.m_logLevel);
        return sb.toString();
	}
	
	enum TEST_TYPE {AAA, BBB, CCC};
	public static void main(String[] args) 
	{
		LogFile lf = new LogFile("./log/test.log", "ALL", true);
		lf.logWrite("Test Log Message " + lf.toString());
		System.out.println(lf);
	}

}
