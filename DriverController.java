package LogisticProject.Controller;

import LogisticProject.Model.Driver;
import LogisticProject.Service.DriverService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DriverController {
    private static final Logger logger = LoggerFactory.getLogger(DriverController.class);
    private DriverService driverService;

    @Autowired(required = true)
    @Qualifier(value = "driverService")
    public void setDriverService( DriverService driverService) {
        this.driverService = driverService;
    }

    @RequestMapping(value = "drivers", method = RequestMethod.GET)
    public String listDrivers(Model model){
        model.addAttribute("driver", new Driver());
        model.addAttribute("listDrivers", this.driverService.listDrivers());

        for(Driver driver: this.driverService.listDrivers()){
            logger.info("Driver list: " + driver);
        }
        return "drivers";
    }

    @RequestMapping(value = "/drivers/add", method = RequestMethod.POST)
    public String addDriver(@ModelAttribute("driver") Driver driver){
        if(driver.getId() == 0){
            this.driverService.addDriver(driver);
        }else {
            this.driverService.updateDriver(driver);
        }

        return "redirect:/drivers";
    }

    @RequestMapping("/remove/{id}")
    public String removeDriver(@PathVariable("id") int id){
        this.driverService.removeDriver(id);

        return "redirect:/drivers";
    }

    @RequestMapping("edit/{id}")
    public String editDriver(@PathVariable("id") int id, Model model){
        model.addAttribute("driver", this.driverService.getDriverById(id));
        model.addAttribute("listDrivers", this.driverService.listDrivers());

        return "drivers";
    }

    @RequestMapping("driverdata/{id}")
    public String driverData(@PathVariable("id") int id, Model model){
        model.addAttribute("driver", this.driverService.getDriverById(id));

        return "driverdata";
    }
}