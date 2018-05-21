package dbm.utils;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
//import javax.xml.soap.Node;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;

public class XmlRead {
	private static String m_sConfigFile = "./conf/config.xml";
	public static String getConfigFile() { return m_sConfigFile; }
	
	public static String getXMLNodeValueXX(String sNodePath, String sXmlFile) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		String sReturnValue=null;
		
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(sXmlFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    
		    sReturnValue =  (String) xpath.evaluate(sNodePath, doc, XPathConstants.STRING);
			
		}
		catch (Exception e) {
			System.err.println("ERROR:" + e.getMessage());
		}
	    return sReturnValue;

	}
	
	public static String getXmlNodeValue(String sNodePath) 
	   //throws ParserConfigurationException, SAXException, 
	          //IOException, XPathExpressionException 
	{
		try {
		    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
		    domFactory.setNamespaceAware(true); // never forget this!
		    DocumentBuilder builder = domFactory.newDocumentBuilder();
		    Document doc = builder.parse(m_sConfigFile);
	
		    XPathFactory factory = XPathFactory.newInstance();
		    XPath xpath = factory.newXPath();
		    XPathExpression expr = xpath.compile(sNodePath + "/text()");
	
		    Object result = expr.evaluate(doc, XPathConstants.NODESET);
		    NodeList nodes = (NodeList) result;
		    if (nodes.getLength() > 0) {
		    //for (int i = 0; i < nodes.getLength(); i++) {
		        //System.out.println(nodes.item(i).getNodeValue());
		        //System.out.println("debug:"+ connName + ","+ cfgName + "=" + nodes.item(0).getNodeValue());
		    	return nodes.item(0).getNodeValue();
		    }
		}
		catch (Exception e) {
			System.err.println("ERROR:" + e.getMessage());
		}
		//System.out.println("debug:"+ connName + ","+ cfgName + "= NULL");
	    return null;

	}
	
	public static void printAll(Node node) {
		System.out.println(node.getNodeName());
		System.out.println(node.getNodeValue());
        
		//System.out.println(node.getTextContent());
        // System.out.println("name:" + node.getAttributes().getNamedItem("name").getNodeValue());
		NamedNodeMap attrs = node.getAttributes();
		for(int i=0; i < attrs.getLength(); i++) {
			System.out.println(":: " + attrs.item(i).getNodeName() + " = "+ attrs.item(i).getNodeValue());
		}
		
		NodeList nodelist = node.getChildNodes();
		for(int i=0; i < nodelist.getLength(); i++) {
			Node currNode = nodelist.item(i);
			if(currNode.getNodeType() == Node.ELEMENT_NODE) {
				printAll(currNode);
			}
		}
		
	}
	
	public static void main(String[] args) throws Exception {
		System.out.println(XmlRead.getXmlNodeValue("/configurations/connections/database[name='default']/url"));
		
		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
		Document document = docBuilder.parse("C:\\Temp\\test.xml");
		printAll(document.getDocumentElement());
	}

}
