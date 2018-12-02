package main.java.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
public class CustomErrorController implements ErrorController {
    @RequestMapping(path="/error")
    public @ResponseBody ResponseEntity error () {
        HashMap<String, String> error = new HashMap<>();
        error.put("error", "endpoint could not be found");

        return new ResponseEntity<Object>(error, HttpStatus.NOT_FOUND);
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }
}