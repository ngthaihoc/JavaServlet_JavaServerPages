package hocng.daoImp;

import java.util.List;

import hocng.dao.NewletterDAO;
import hocng.entity.NEWSLETTERS;
import hocng.utils.XJDBC;
import hocng.utils.XQuery;

public class NewletterDAOImpl implements NewletterDAO {

	String insertNewsletterSQL = "INSERT INTO NEWSLETTERS(Email, Enabled) VALUES (?, ?)";
	String updateNewsletterSQL = "UPDATE NEWSLETTERS SET Enabled = ? WHERE Email = ?";
	String deleteNewsletterSQL = "DELETE FROM NEWSLETTERS WHERE Email = ?";
	String findAllNewslettersSQL = "SELECT Email, Enabled FROM NEWSLETTERS";
	String findNewsletterByEmailSQL = "SELECT Email, Enabled FROM NEWSLETTERS WHERE Email = ?";
	String findActiveNewslettersSQL = "SELECT Email, Enabled FROM NEWSLETTERS WHERE Enabled = 1";

	@Override
	public NEWSLETTERS create(NEWSLETTERS entity) {
		Object[] values = { entity.getEmail(), entity.isEnabled() };
		XJDBC.executeUpdate(insertNewsletterSQL, values);
		return entity;
	}

	@Override
	public void update(NEWSLETTERS entity) {
		Object[] values = { entity.isEnabled(), entity.getEmail() };
		XJDBC.executeUpdate(updateNewsletterSQL, values);

	}

	@Override
	public void deleteById(String id) {
		XJDBC.executeUpdate(deleteNewsletterSQL, id);
	}

	@Override
	public List<NEWSLETTERS> findAll() {
		return XQuery.getBeanList(NEWSLETTERS.class, findAllNewslettersSQL);
	}

	@Override
	public NEWSLETTERS findById(String id) {
		return XQuery.getSingleBean(NEWSLETTERS.class, findNewsletterByEmailSQL, id);
	}
}
