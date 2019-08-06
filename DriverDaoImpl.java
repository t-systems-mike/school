package LogisticProject.Dao;

import LogisticProject.Model.Driver;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class DriverDaoImpl implements DriverDao {

    private static final Logger logger = LoggerFactory.getLogger(DriverDaoImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addDriver(Driver driver) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(driver);
        logger.info("Driver successfully saved. Driver details: " + driver);
    }

    @Override
    public void updateDriver(Driver driver) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(driver);
        logger.info("Driver is successfully update. Driver details: " + driver);
    }

    @Override
    public void removeDriver(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Driver driver = (Driver) session.load(Driver.class, new Integer(id));

        if(driver!=null){
            session.delete(driver);
        }
        logger.info("Driver is successfully removed. Driver details: " + driver);
    }

    @Override
    public Driver getDriverById(int id) {
        Session session =this.sessionFactory.getCurrentSession();
        Driver driver = (Driver) session.load(Driver.class, new Integer(id));
        logger.info("Driver is successfully loaded. Driver details: " + driver);

        return driver;
    }

    @Override
    public List<Driver> listDrivers() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Driver> driverList = session.createQuery("from Driver").list();

        for(Driver driver: driverList){
            logger.info("Driver list: " + driver);
        }
        return driverList;
    }
}
