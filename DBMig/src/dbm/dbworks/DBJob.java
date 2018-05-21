package dbm.dbworks;

//import dbm.db.dbpool.*;
//import dbm.utils.*;

public class DBJob {
	public static void main(String[] args) {
		DBWorker dbw = new DBWorker("LOGDB");
		dbw.setJobInfo("TestID", "TestNm", "TestTBL", "-");
		//dbw.setSQL("select * from dbadm.vw_mig_log");
		dbw.setSQL("select * from dbadm.tb_mig_job_log", DBWorker.CMDTYPE.QUERY);
		dbw.setSQL("truncate table dbadm.tb_mig_job_log", DBWorker.CMDTYPE.DDL);
		dbw.start();
		
	}

}
