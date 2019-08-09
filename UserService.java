package cargoProject.service;

import cargoProject.model.User;

/**
 * Service class for {@link cargoProject.model.User}
 */

public interface UserService {

    void save(User user);

    User findByUsername(String username);
}
