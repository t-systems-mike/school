package LogisticProject.Dao;
import LogisticProject.Model.Driver;
import java.util.List;

public interface DriverDao {
    public void addDriver(Driver driver);
    public void updateDriver(Driver driver);
    public void removeDriver(int id);
    public Driver getDriverById(int id);
    public List<Driver> listDrivers();
}
