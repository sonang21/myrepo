package com.cslee.utils;

public class StrUtils {
	public static String rpad(String sStr, int nSize, char cPadChar)
	{
		if (sStr == null || sStr.isEmpty()) sStr="";
		
		StringBuffer sb = new StringBuffer(sStr);
		while(sb.length() < nSize)
		{
			sb.append(cPadChar);
		}
		return sb.toString();
	}
	public static String rpad(String sStr, int nSize)
	{
		return rpad(sStr, nSize, ' ');
	}

	public static String lpad(String sStr, int nSize, char cPadChar)
	{
		if (sStr == null || sStr.isEmpty()) sStr="";
		
		StringBuffer sb = new StringBuffer();
		for(int i=0; i < sStr.length() - nSize; i++)
		{
			sb.append(cPadChar);
		}
		sb.append(sStr);
		return sb.toString();
	}
	public static String lpad(String sStr, int nSize)
	{
		return lpad(sStr, nSize, ' ');
	}
}
