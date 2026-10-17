package com.hotelreservation.controller;

import com.hotelreservation.model.Hotel;
import com.hotelreservation.service.HotelService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminHotelController {
    
    @Autowired
    private HotelService hotelService;
    
    /**
     * GET /admin/hotels → list all hotels (returns hotels.jsp)
     */
    @GetMapping("/hotels")
    public String listHotels(Model model) {
        try {
            List<Hotel> hotels = hotelService.getAllActiveHotels();
            model.addAttribute("hotels", hotels);
            model.addAttribute("totalHotels", hotels.size());
            model.addAttribute("activeHotels", hotels.stream().mapToLong(h -> h.getIsActive() ? 1 : 0).sum());
            return "adminHotels";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading hotels: " + e.getMessage());
            model.addAttribute("hotels", new java.util.ArrayList<>());
            model.addAttribute("totalHotels", 0);
            model.addAttribute("activeHotels", 0);
            return "adminHotels";
        }
    }
    
    /**
     * Simple test endpoint
     */
    @GetMapping("/hotels/simple-test")
    @ResponseBody
    public String simpleTest() {
        return "Admin Hotel Controller is working!";
    }
    
    /**
     * GET /admin/hotels/new → show form to create hotel
     */
    @GetMapping("/hotels/new")
    public String showCreateHotelForm(Model model) {
        try {
            Hotel hotel = new Hotel();
            model.addAttribute("hotel", hotel);
            model.addAttribute("isEdit", false);
            return "hotelForm";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error loading form: " + e.getMessage());
            return "hotelForm";
        }
    }
    
    /**
     * POST /admin/hotels → save new hotel
     */
    @PostMapping("/hotels")
    public String saveHotel(@Valid @ModelAttribute("hotel") Hotel hotel, 
                           BindingResult bindingResult, 
                           RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "hotelForm";
        }
        
        try {
            hotelService.saveHotel(hotel);
            redirectAttributes.addFlashAttribute("successMessage", "Hotel created successfully!");
            return "redirect:/admin/hotels";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating hotel: " + e.getMessage());
            return "redirect:/admin/hotels/new";
        }
    }
    
    /**
     * GET /admin/hotels/edit/{id} → show edit form
     */
    @GetMapping("/hotels/edit/{id}")
    public String showEditHotelForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Hotel hotel = hotelService.getHotelById(id)
                    .orElseThrow(() -> new RuntimeException("Hotel not found"));
            model.addAttribute("hotel", hotel);
            model.addAttribute("isEdit", true);
            return "hotelForm";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hotel not found: " + e.getMessage());
            return "redirect:/admin/hotels";
        }
    }
    
    /**
     * POST /admin/hotels/update/{id} → update hotel
     */
    @PostMapping("/hotels/update/{id}")
    public String updateHotel(@PathVariable Long id, 
                             @Valid @ModelAttribute("hotel") Hotel hotel, 
                             BindingResult bindingResult, 
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "hotelForm";
        }
        
        try {
            hotel.setId(id);
            hotelService.saveHotel(hotel);
            redirectAttributes.addFlashAttribute("successMessage", "Hotel updated successfully!");
            return "redirect:/admin/hotels";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating hotel: " + e.getMessage());
            return "redirect:/admin/hotels/edit/" + id;
        }
    }
    
    /**
     * GET /admin/hotels/delete/{id} → delete hotel
     */
    @GetMapping("/hotels/delete/{id}")
    public String deleteHotel(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            hotelService.deleteHotel(id);
            redirectAttributes.addFlashAttribute("successMessage", "Hotel deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting hotel: " + e.getMessage());
        }
        return "redirect:/admin/hotels";
    }
    
    /**
     * GET /admin/hotels/deactivate/{id} → deactivate hotel (soft delete)
     */
    @GetMapping("/hotels/deactivate/{id}")
    public String deactivateHotel(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Hotel hotel = hotelService.getHotelById(id)
                    .orElseThrow(() -> new RuntimeException("Hotel not found"));
            hotel.setIsActive(false);
            hotelService.saveHotel(hotel);
            redirectAttributes.addFlashAttribute("successMessage", "Hotel deactivated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deactivating hotel: " + e.getMessage());
        }
        return "redirect:/admin/hotels";
    }
    
    /**
     * GET /admin/hotels/activate/{id} → activate hotel
     */
    @GetMapping("/hotels/activate/{id}")
    public String activateHotel(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Hotel hotel = hotelService.getHotelById(id)
                    .orElseThrow(() -> new RuntimeException("Hotel not found"));
            hotel.setIsActive(true);
            hotelService.saveHotel(hotel);
            redirectAttributes.addFlashAttribute("successMessage", "Hotel activated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error activating hotel: " + e.getMessage());
        }
        return "redirect:/admin/hotels";
    }
}
