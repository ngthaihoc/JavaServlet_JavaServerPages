package hocng.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class XQuery {

	public static <B> B getSingleBean(Class<B> beanClass, String sql, Object... values) {
		List<B> list = XQuery.getBeanList(beanClass, sql, values);
		if (!list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	public static <B> List<B> getBeanList(Class<B> beanClass, String sql, Object... values) {
		List<B> list = new ArrayList<>();
		try {
			ResultSet resultSet = XJDBC.executeQuery(sql, values);
			try (resultSet) {
				while (resultSet != null && resultSet.next()) {
					list.add(XQuery.readBean(resultSet, beanClass));
				}
			}
		} catch (SQLException ex) {
			throw new RuntimeException("Lỗi khi thực hiện truy vấn", ex);
		} catch (Exception ex) {
			throw new RuntimeException("Lỗi khi đọc dữ liệu sang Bean", ex);
		}
		return list;
	}

	private static <B> B readBean(ResultSet resultSet, Class<B> beanClass) throws InstantiationException,
			IllegalAccessException, InvocationTargetException, NoSuchMethodException, SQLException {

		B bean = beanClass.getDeclaredConstructor().newInstance();
		Method[] methods = beanClass.getDeclaredMethods();

		for (Method method : methods) {
			String name = method.getName();
			if (name.startsWith("set") && method.getParameterCount() == 1) {
				try {
					String columnName = name.substring(3);
					Object value = resultSet.getObject(columnName);
					Class<?> paramType = method.getParameterTypes()[0];
					if (value instanceof BigDecimal) {
						if (paramType == double.class || paramType == Double.class) {
							value = ((BigDecimal) value).doubleValue();
						} else if (paramType == float.class || paramType == Float.class) {
							value = ((BigDecimal) value).floatValue();
						}
					}
					method.invoke(bean, value);
				} catch (SQLException e) {
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
				}
			}
		}
		return bean;
	}

}