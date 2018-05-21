//import java.io.File;

/*
drop function fn_similar;
create function fn_similar(p1 varchar(1000), p2 varchar(1000), p3 integer) 
returns varchar(100)
  parameter style java no sql language java
  external name 'DerbyFunction.similar';
  
values fn_similar('F:\dba\test\ok', 'E:\dbb\test\ok', 1);
 */

public class DerbyFunction {
	public static void main(String args[]) {
		int i = similar("J:\\Media\\01.Photo\\Job\\BEDTS", "J:\\DISKs\\07_Media\\01.Photo\\BEDTS\\2008³â", 0);
		String s = similar2("J:\\Media\\01.Photo\\Job\\BEDTS", "J:\\DISKs\\07_Media\\01.Photo\\BEDTS\\2008³â", 0);
		System.out.println(i);
		System.out.println(s);
	}
	
	public static int test(String text, String text2) {
		return text.length();
	}
	
	public static int similar(String p1, String p2, int aReverse) {
		int rval = 0;
		int cnt = 0;
		int i=0; int j=0;

		String [] ap1;
		String [] ap2;
		String fs = "\\\\"; //java.io.File.separator;
		ap1 = p1.split(fs);
		ap2 = p2.split(fs);
		if (aReverse == 1) {
			for( i = 1; i <= ap1.length && i <= ap2.length; i++) {
				if(! ap1[ap1.length -i].equals(ap2[ap2.length-i])) {
					break;
				}
				rval = i;
			}
		} else {
			for(i = 0; i < ap1.length ; i++) {
				for (j = 0; j < ap2.length && i < ap1.length; j++) {
					if( ap1[i].equals(ap2[j]) ) {
						cnt ++;
						i++;
					}
				}
			}
			rval = cnt;
		}
		return rval;
	}

	public static String similar2(String p1, String p2, int aReverse) {
		String rval = "0";
		int cnt = 0;
		int i=0; int j=0;

		String [] ap1;
		String [] ap2;
		String fs = "\\\\"; //java.io.File.separator;
		ap1 = p1.split(fs);
		ap2 = p2.split(fs);
		if (aReverse == 1) {
			for( i = 1; i <= ap1.length && i <= ap2.length; i++) {
				if(! ap1[ap1.length -i].equals(ap2[ap2.length-i])) {
					break;
				}
				rval = String.format("r%2d(%02d/%02d)", ((i * 100)+1) /ap1.length, i, ap1.length) ;
			}
		} else {
			for(i = 0; i < ap1.length ; i++) {
				for (j = 0; j < ap2.length && i < ap1.length; j++) {
					if( ap1[i].equals(ap2[j]) ) {
						cnt ++;
						i++;
					}
				}
			}
			rval = String.format("%2d(%02d/%02d)", ((cnt * 100)+1) / ap1.length, cnt, ap1.length);
		}
		return rval;
	}

}
