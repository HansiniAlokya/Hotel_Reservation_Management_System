package com.hotelreservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class SimpleTestController {

    @GetMapping("/simple")
    public String simpleTest(Model model) {
        model.addAttribute("message", "Simple test working!");
        return "simpleTest";
    }
}
