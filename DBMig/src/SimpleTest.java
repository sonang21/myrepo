import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class SimpleTest {

	public static void main(String[] args) {
		System.out.println("start..........");
		String DB_URL = "jdbc:oracle:thin:@100.100.100.194:1521:TENURI";
        String DB_USR = "migadm";
        String DB_PWD = "mig1020";
        try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
        }
        catch(Exception ex) {
        	ex.printStackTrace();
        	System.exit(1);
        }
        
        System.out.println("driver load...");
		
		try (   
				
				Connection oConn = DriverManager.getConnection(DB_URL, DB_USR, DB_PWD);
				PreparedStatement oStmt = oConn.prepareStatement("update migadm.tb_tr_test set name=? where id=?");
						
		)
		{
			System.out.println("db test ...");
			oConn.setAutoCommit(false);
			for(int i=1; i <= 5; i++) {
				oStmt.setString(1, "xxx");
				oStmt.setInt(2, i );
				oStmt.addBatch();
				oStmt.clearParameters();
			}
			oStmt.executeBatch();
			oStmt.clearParameters();
			oStmt.clearParameters();
			oConn.commit();
			System.out.println("... OK");
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
