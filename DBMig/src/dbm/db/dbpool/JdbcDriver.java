package dbm.db.dbpool;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Logger;

public class JdbcDriver implements Driver
{
	private Driver m_driver;
	
	JdbcDriver(Driver driver)
	{
		this.m_driver = driver;
	}

	@Override
	public boolean acceptsURL(String sURL) throws SQLException {
		// TODO Auto-generated method stub
		return this.m_driver.acceptsURL(sURL);
	}

	@Override
	public Connection connect(String sURL, Properties oProp) throws SQLException {
		// TODO Auto-generated method stub
		return this.m_driver.connect(sURL, oProp);
	}

	@Override
	public int getMajorVersion() {
		// TODO Auto-generated method stub
		return this.m_driver.getMajorVersion();
	}

	@Override
	public int getMinorVersion() {
		// TODO Auto-generated method stub
		return this.m_driver.getMinorVersion();
	}

	@Override
	public DriverPropertyInfo[] getPropertyInfo(String sURL, Properties oProps)
			throws SQLException {
		// TODO Auto-generated method stub
		return this.m_driver.getPropertyInfo(sURL, oProps);
	}

	@Override
	public boolean jdbcCompliant() {
		// TODO Auto-generated method stub
		return this.m_driver.jdbcCompliant();
	}

	@Override
	public Logger getParentLogger() throws SQLFeatureNotSupportedException {
		// TODO Auto-generated method stub
		return this.m_driver.getParentLogger();
		// return null;
	}
		
}
