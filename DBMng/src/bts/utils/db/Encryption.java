package bts.utils.db;

//import java.security.SecureRandom;
import java.util.Scanner;

import javax.crypto.Cipher;
//import javax.crypto.KeyGenerator;
//import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class Encryption
{
	//16bytes Key
	final static String DBM_SEC_KEY = "DBMSSecretKey#91";
	
	public static String encrypt(String strClearText) 
	{
		try 
		{
			return encrypt(DBM_SEC_KEY, strClearText);
		} 
		catch (Exception e)
		{
			e.printStackTrace();
			return "";
		}
	}
	public static String decrypt(String strEncrptedText) 
	{
		try 
		{
			return decrypt(DBM_SEC_KEY, strEncrptedText);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return "";
		}
	}
	private static String encrypt(String strSeed, String strClearText) throws Exception 
	{
		//byte[] byteEncypted = encrypt(strSeed, strClearText.getbuff());
		//return byteToHex(byteEncrypted);
		
		String strAlgorithm = "AES";
		SecretKeySpec keySpec =  getSecretKeySpec(strSeed, strAlgorithm);
		Cipher secCipher = Cipher.getInstance(strAlgorithm);
		secCipher.init(Cipher.ENCRYPT_MODE, keySpec);
		byte[] byteEncrypted = secCipher.doFinal(strClearText.getBytes());
		
		return bytesToHex(byteEncrypted);		
	}
	
	private static String decrypt(String strSeed, String strEncryptedText) throws Exception 
	{
		String strAlgorithm = "AES";
		SecretKeySpec keySpec =  getSecretKeySpec(strSeed, strAlgorithm);
		Cipher secCipher = Cipher.getInstance(strAlgorithm);
		secCipher.init(Cipher.DECRYPT_MODE, keySpec);
		byte[] byteEnctyped = hexToBytes(strEncryptedText);
		
		byte[] byteDecrypted = secCipher.doFinal(byteEnctyped);
		return new String(byteDecrypted);
	}
	
	private static SecretKeySpec getSecretKeySpec(String strSeed, String strAlgorithm) throws Exception
	{
		return new SecretKeySpec(strSeed.getBytes(), strAlgorithm);		
	}
	
	// sometimes error occured.
//	private static SecretKeySpec getSecretKeySpec2(String strSeed, String strAlgorithm) throws Exception
//	{
//		byte[] bytSeed = strSeed.getBytes();
//		KeyGenerator keyGen = KeyGenerator.getInstance(strAlgorithm);
//		SecureRandom secRand = SecureRandom.getInstance("SHA1PRNG");
//		secRand.setSeed(bytSeed);
//		keyGen.init(128, secRand);
//		SecretKey secKey = keyGen.generateKey();
//		return new SecretKeySpec(secKey.getEncoded(), strAlgorithm);		
//	}
	private final static String HEX = "0123456789ABCDEF";
	private static String bytesToHex(byte[] buff) 
	{
		if(buff == null) 
		{
			return "";
		}
		
		StringBuffer sb = new StringBuffer(buff.length *2);
		for(int i=0; i < buff.length; i++)
		{
			sb.append(HEX.charAt((buff[i] >> 4) & 0x0f)).append(HEX.charAt( buff[i] & 0x0f));
		}
		
		return sb.toString();
		/*
		 *
		 
		String strHex;
		for( int i=0 ; i < buff.length; i++) 
		{
			strHex = "0" + Integer.toHexString(0xff & buff[i]);
			sb.append(strHex.substring(strHex.length()-2));
		}
		*/
	}
	private static byte[] hexToBytes(String strHex) {
		byte[] bytesResult = new byte[strHex.length()/2];
		
		for(int i = 0; i < bytesResult.length; i++)
		{
			bytesResult[i] = Integer.valueOf(strHex.substring(i*2, i*2+2),16).byteValue();
		}
		
		return bytesResult;
	}

	@SuppressWarnings("unused")
	private static byte[] hexToBytes2(String strHex) {
		int nLen = strHex.length();
		byte[] bytesResult = new byte[nLen/2];
		
		for(int i = 0; i < nLen; i+=2)
		{
			bytesResult[i/2] = (byte)((Character.digit(strHex.charAt(i),  16) << 4) 
					                   + Character.digit(strHex.charAt(i+1), 16));
		}
		
		return bytesResult;
	}

	public static void main(String[] args) {
		if(args.length < 1) 
		{
			System.out.println("usage: java dbm.utils.Encryption [text to encrypt] or [-D text to decrypt]");
			System.out.print("Enter password :");
			
			Scanner scan= new Scanner(System.in);
			String str1 = scan.nextLine();
			scan.close();
			String str2 = encrypt(str1);
			System.out.println("[" + decrypt(str2) + "]");
			System.out.println(str2);
			return;
		}
		try {
			if (args[0].equalsIgnoreCase("-D")) 
			{
				String str1 = args[1];
				System.out.println(decrypt(str1));
			} 
			else 
			{
				String str1 = args[0];
				String str2 = encrypt(str1);
				System.out.println(decrypt(str2));
				System.out.println(str2);
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}

}