package com.hotelreservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class TestController {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @GetMapping("/events-count-sql")
    public String getEventsCountSQL() {
        try {
            Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM events", Integer.class);
            return "Events count: " + count;
        } catch (Exception e) {
            return "Error counting events: " + e.getMessage();
        }
    }
    
    @GetMapping("/events-sample")
    public String getEventsSample() {
        try {
            List<Map<String, Object>> events = jdbcTemplate.queryForList("SELECT event_id, event_name, event_date, location FROM events LIMIT 3");
            StringBuilder sb = new StringBuilder();
            sb.append("Sample events:\n");
            for (Map<String, Object> event : events) {
                sb.append("ID: ").append(event.get("event_id"))
                  .append(", Name: ").append(event.get("event_name"))
                  .append(", Date: ").append(event.get("event_date"))
                  .append(", Location: ").append(event.get("location"))
                  .append("\n");
            }
            return sb.toString();
        } catch (Exception e) {
            return "Error getting events sample: " + e.getMessage();
        }
    }
}