package LogisticProject.Service;

import LogisticProject.Dao.DriverDao;
import LogisticProject.Model.Driver;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DriverServiceImpl implements DriverService {
    private DriverDao driverDao;

    public void setDriverDao(DriverDao driverDao) {
        this.driverDao = driverDao;
    }
    @Override
    @Transactional
    public void addDriver(Driver driver) {
        this.driverDao.addDriver(driver);
    }

    @Override
    @Transactional
    public void updateDriver(Driver driver) {
        this.driverDao.updateDriver(driver);
    }

    @Override
    @Transactional
    public void removeDriver(int id) {
        this.driverDao.removeDriver(id);
    }

    @Override
    @Transactional
    public Driver getDriverById(int id) {
        return this.driverDao.getDriverById(id);
    }

    @Override
    @Transactional
    public List<Driver> listDrivers() {
        return this.driverDao.listDrivers();
    }
}
