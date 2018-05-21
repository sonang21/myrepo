package com.cslee.utils;

//import java.io.IOException;
import java.io.File;

import javax.xml.parsers.*;
import javax.xml.xpath.*;

import org.w3c.dom.*;

//import java.io.File;

//import org.xml.sax.SAXException;


public class SysConfig {
	private static String m_sConfigFile = "./conf/config.xml";
	
	private String m_sLogDir;
	private String m_sWorkDir;
	private String m_sLogFile;
	private String m_sLogLevel;
	
	public SysConfig() 
	{
		this(m_sConfigFile);
	}
	
	public SysConfig(String sConfigFile) 
	{
		m_sConfigFile = sConfigFile;
		this.m_sLogDir = getConfig("log_directory");
		this.m_sWorkDir = getConfig("work_directory");
		this.m_sLogFile = this.m_sLogDir + File.separator + getConfig("logfile_default");
		
//		this.m_sLogDir = getConfig("log_directory").replaceAll("\\", File.separator);
//		this.m_sWorkDir = getConfig("work_directory").replaceAll("\\", File.separator);
//		this.m_sLogFile = this.m_sLogDir + File.separator + getConfig("logfile_default").replaceAll("\\", File.separator);
		
		this.m_sLogLevel = getConfig("log_level");
		
	}

	public void setConfigFile(String filename) { m_sConfigFile = filename; }
	
	public String getLogDir() { return this.m_sLogDir; };
	public String getWorkDir()   { return this.m_sWorkDir; };
	public String getLogFile() { return this.m_sLogFile; };
	public String getLogLevel() { return this.m_sLogLevel; };

	public static String getConfig(String nodeName) {
		return getXMLNodeValue("//configurations/system/" + nodeName + "[1]", m_sConfigFile);
	}
	
	public static String getXMLNodeValue(String sNodePath, String configFile) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		String sReturnValue=null;
		
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(configFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    
		    sReturnValue =  (String) xpath.evaluate(sNodePath, doc, XPathConstants.STRING);
			
		}
		catch (Exception e) {
			System.err.println("ERROR:" + e.getMessage());
		}
	    return sReturnValue;

	}


	/***************************************************************************************************************/
	public static void main(String[] args) {
		StringBuilder sb = new StringBuilder();
	
		for(int i=0; i<args.length; i++)
        {
            if (i == 0) {
            	sb.append(args[i]);
            } else {
            	sb.append(" " + args[i]);
            }
        }
		
		SysConfig test  = new SysConfig();
		
		System.out.println( "\n=====================================================================" );
        System.out.println( " TEST SysConfig");
        System.out.println( " . m_sLogDir    : " + test.getLogDir());
        System.out.println( " . m_sWorkDir   : " + test.getWorkDir());
        System.out.println( " . m_sLogFile   : " + test.getLogFile());
		System.out.println( "\n=====================================================================" );
	}

}
