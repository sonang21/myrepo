package com.cslee.utils;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;

public class XmlRead {


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

}
