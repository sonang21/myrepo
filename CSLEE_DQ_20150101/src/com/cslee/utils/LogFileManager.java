package com.cslee.utils;

import java.util.Hashtable;
//import java.util.Vector;


public class LogFileManager {
	static private LogFileManager m_instance;
	private Hashtable<String, LogFile> m_htLogFiles = new Hashtable<String, LogFile>();
	private LOG_LEVEL m_logLevel = LOG_LEVEL.DEBUG;
	private boolean m_bCloseAfterWrite = false;
	private String m_sDefaultFile = "./log/default.log";
	
	private LogFileManager() {}
	
	public static LogFileManager getInstance() 
	{
		if(m_instance == null) 
		{
			m_instance = new LogFileManager();
		}
		return m_instance;
	}
	
	private LogFile newLogFile(String sFileName)
	{
		LogFile oLogFile = new LogFile(sFileName, this.m_logLevel, this.m_bCloseAfterWrite);
		m_htLogFiles.put(sFileName, oLogFile);
		return oLogFile;
	}

	public void set(String sDefaultFile, String sLogLevel, boolean bCloseAfterWrite) 
	{
		this.m_sDefaultFile = sDefaultFile;
		this.m_logLevel = LogFile.LOG_LEVEL(sLogLevel);
		this.m_bCloseAfterWrite = bCloseAfterWrite;
	}

	public LogFile getLogFile()
	{
		return getLogFile(this.m_sDefaultFile);
	}
	
	public LogFile getLogFile(String sFileName) 
	{
		LogFile oLogFile = m_htLogFiles.get(sFileName);
		
		if(oLogFile != null)
		{
			return oLogFile;
		}
		
		return newLogFile(sFileName);
		
	}
	
	public void closeLogFile()
	{
		closeLogFile(this.m_sDefaultFile);
	}
	
	public void closeLogFile(String sFileName)
	{
		LogFile oLogFile = this.m_htLogFiles.get(sFileName);
		oLogFile.fileClose();
		this.m_htLogFiles.remove(sFileName);
	}
}
