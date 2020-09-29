package commons;
import java.sql.*;
// DB주소의 반복을 줄이고 단일성을 확보함 코드의 양을 줄일수 있다.
public class DBUtil {
	public Connection getConnection() throws Exception {
	String driver ="org.mariadb.jdbc.Driver";
	String dbaddr ="jdbc:mariadb://localhost:3306/mall";
	String dbid ="root";
	String dbpw ="java1004";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbaddr, dbid, dbpw);	
	return conn;
	}
	
}
