package hocng.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class XJDBC {

	private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String DBURL_WINDOW_AUTH = "jdbc:sqlserver://LAPTOPCUAWELLY:1433;"
			+ "databaseName=Wellum;integratedSecurity=true;" + "encrypt=true;trustServerCertificate=true;";

	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			System.err.println("Lỗi: Không tìm thấy Driver SQL Server.");
			throw new RuntimeException("Không thể tải Driver SQL Server.", e);
		}
	}

	private static void logSQLException(SQLException ex) {
		System.err.println("--- SQL Exception Occurred ---");
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.err.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
		System.err.println("------------------------------");
	}

	public static Connection openConnection() throws SQLException {
		return DriverManager.getConnection(DBURL_WINDOW_AUTH);
	}

	public static PreparedStatement prepareStatement(Connection conn, String sql, Object... values)
			throws SQLException {
		PreparedStatement stmt = sql.trim().startsWith("{") ? conn.prepareCall(sql) : conn.prepareStatement(sql);
		for (int i = 0; i < values.length; i++) {
			stmt.setObject(i + 1, values[i]);
		}
		return stmt;
	}

	@SuppressWarnings("unchecked")
	public static <T> T execute(PreparedStatement stmt, boolean isQuery) throws SQLException {
		if (isQuery) {
			return (T) stmt.executeQuery();
		} else {
			return (T) Integer.valueOf(stmt.executeUpdate());
		}
	}

	public static int executeUpdate(String sql, Object... values) {
		try (Connection conn = openConnection(); PreparedStatement stmt = prepareStatement(conn, sql, values)) {
			return execute(stmt, false);
		} catch (SQLException e) {
			System.err.println("Lỗi trong executeUpdate với SQL: " + sql);
			logSQLException(e);
			throw new RuntimeException("Database error: " + e.getMessage(), e);
		}
	}

	public static ResultSet executeQuery(String sql, Object... values) {
		try {
			Connection conn = openConnection();
			PreparedStatement stmt = prepareStatement(conn, sql, values);
			return execute(stmt, true);
		} catch (SQLException e) {
			System.err.println("Lỗi trong executeQuery with SQL: " + sql);
			logSQLException(e);
			return null;
		}
	}

	public static <T> T getValue(String sql, Class<T> type, Object... values) {
		try (Connection conn = openConnection();
				PreparedStatement stmt = prepareStatement(conn, sql, values);
				ResultSet resultSet = execute(stmt, true)) {

			if (resultSet.next()) {
				Object value = resultSet.getObject(1);
				return type.cast(value);
			}
			return null;
		} catch (SQLException e) {
			System.err.println("Lỗi trong getValue with SQL: " + sql);
			logSQLException(e);
			return null;
		}
	}

	public static void main(String[] args) {
		try {
			System.out.println("Dang kiem tra ket noi den CSDL...");
			try (Connection conn = openConnection()) {
				if (conn != null && !conn.isClosed()) {
					System.out.println("Ket noi den database thanh cong: " + conn.getCatalog());
				} else {
					System.out.println("Ket noi that bai (Ket noi bi dong ngay sau khi mo).");
				}
			}
		} catch (SQLException e) {
			System.err.println("Ket noi that bai do loi. Chi tiet:");
			logSQLException(e);
		}
	}
}