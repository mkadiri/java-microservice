package main.java.controller;

import main.java.entity.User;
import main.java.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(path="/")
public class UserController
{
    @Autowired
    private UserRepository userRepository;

    @PostMapping(path="/users/user")
    public @ResponseBody User addNewUser (@RequestBody User userReq)
    {
        User user = this.userRepository.findByUserLogin(userReq.getLogin());

        if (user == null) {
            user = new User();
        }

        user.setLogin(userReq.getLogin());
        user.setFirstName(userReq.getFirstName());
        user.setLastName(userReq.getLastName());
        user.setEnabled(userReq.getEnabled());

        return this.userRepository.save(user);
    }

    @GetMapping(path="/users")
    public @ResponseBody Iterable<User> getAllUsers()
    {
        return userRepository.findAll();
    }
}