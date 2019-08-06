package LogisticProject.Service;

import LogisticProject.Model.Driver;

import java.util.List;

public interface DriverService {
    public void addDriver(Driver driver);
    public void updateDriver(Driver driver);
    public void removeDriver(int id);
    public Driver getDriverById(int id);
    public List<Driver> listDrivers();
}