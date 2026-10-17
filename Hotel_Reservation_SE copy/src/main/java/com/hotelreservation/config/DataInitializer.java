package com.hotelreservation.config;

import com.hotelreservation.model.Hotel;
import com.hotelreservation.model.Room;
import com.hotelreservation.model.Role;
import com.hotelreservation.model.User;
import com.hotelreservation.model.Event;
import com.hotelreservation.repository.HotelRepository;
import com.hotelreservation.repository.RoomRepository;
import com.hotelreservation.repository.RoleRepository;
import com.hotelreservation.repository.UserRepository;
import com.hotelreservation.repository.EventRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.time.LocalDateTime;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private HotelRepository hotelRepository;
    
    @Autowired
    private RoomRepository roomRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private EventRepository eventRepository;
    
    @Override
    public void run(String... args) throws Exception {
        // Wait a bit for Hibernate to create tables
        Thread.sleep(2000);
        
        initializeRoles();
        initializeTestUser();
        initializeHotelsAndRooms();
        initializeEvents();
    }
    
    private void initializeRoles() {
        try {
            // Create roles if they don't exist
            Arrays.asList(Role.RoleType.values()).forEach(roleType -> {
                try {
                    if (!roleRepository.findByName(roleType).isPresent()) {
                        Role role = new Role(roleType, roleType.name() + " role");
                        roleRepository.save(role);
                        System.out.println("Created role: " + roleType.name());
                    }
                } catch (Exception e) {
                    // If table doesn't exist yet, create the role anyway
                    Role role = new Role(roleType, roleType.name() + " role");
                    roleRepository.save(role);
                    System.out.println("Created role: " + roleType.name());
                }
            });
        } catch (Exception e) {
            System.out.println("Error initializing roles: " + e.getMessage());
            // Continue with initialization
        }
    }
    
    private void initializeTestUser() {
        try {
            // Create Guest User if it doesn't exist
            if (!userRepository.findByEmail("test@example.com").isPresent()) {
                Role guestRole = roleRepository.findByName(Role.RoleType.GUEST)
                        .orElseThrow(() -> new RuntimeException("Guest role not found"));

                User testUser = new User();
                testUser.setUsername("testuser");
                testUser.setEmail("test@example.com");
                testUser.setPassword(passwordEncoder.encode("password123"));
                testUser.setPhoneNumber("+1234567890");
                testUser.setFirstName("Test");
                testUser.setLastName("User");
                testUser.setRoles(java.util.Set.of(guestRole));
                userRepository.save(testUser);

                System.out.println("Created test user: testuser");
            } else {
                System.out.println("Test user already exists");
            }

            // Create Admin User if it doesn't exist
            if (!userRepository.findByEmail("admin@grandstay.com").isPresent()) {
                Role adminRole = roleRepository.findByName(Role.RoleType.ADMIN)
                        .orElseThrow(() -> new RuntimeException("Admin role not found"));

                User adminUser = new User();
                adminUser.setUsername("admin");
                adminUser.setEmail("admin@grandstay.com");
                adminUser.setPassword(passwordEncoder.encode("admin123"));
                adminUser.setPhoneNumber("+1234567891");
                adminUser.setFirstName("Admin");
                adminUser.setLastName("User");
                adminUser.setRoles(java.util.Set.of(adminRole));
                userRepository.save(adminUser);

                System.out.println("Created admin user: admin");
            } else {
                System.out.println("Admin user already exists");
            }

            // Create Staff User if it doesn't exist
            if (!userRepository.findByEmail("staff@grandstay.com").isPresent()) {
                Role staffRole = roleRepository.findByName(Role.RoleType.STAFF)
                        .orElseThrow(() -> new RuntimeException("Staff role not found"));

                User staffUser = new User();
                staffUser.setUsername("staff");
                staffUser.setEmail("staff@grandstay.com");
                staffUser.setPassword(passwordEncoder.encode("staff123"));
                staffUser.setPhoneNumber("+1234567892");
                staffUser.setFirstName("Staff");
                staffUser.setLastName("Member");
                staffUser.setRoles(java.util.Set.of(staffRole));
                userRepository.save(staffUser);

                System.out.println("Created staff user: staff");
            } else {
                System.out.println("Staff user already exists");
            }
        } catch (Exception e) {
            System.out.println("Error initializing users: " + e.getMessage());
            // Continue with initialization
        }
    }
    
        private void initializeHotelsAndRooms() {
            try {
                // Only create hotels if none exist
                if (hotelRepository.count() == 0) {
                    createSampleHotels();
                }
            } catch (Exception e) {
                System.out.println("Error initializing hotels: " + e.getMessage());
                // Continue with initialization - tables might not exist yet
            }
        }
    
    private void createSampleHotels() {
        try {
            // Hotel 1: GrandStay Resort
        Hotel grandStay = new Hotel();
        grandStay.setName("GrandStay Resort");
        grandStay.setLocation("Miami Beach, Florida");
        grandStay.setDescription("Luxury beachfront resort with world-class amenities and stunning ocean views.");
        grandStay.setFacilities("Swimming Pool, Spa, Fitness Center, Restaurant, Bar, Beach Access, Concierge, Valet Parking");
        grandStay.setStarRating(5);
        grandStay.setContactPhone("+1-305-555-0100");
        grandStay.setContactEmail("info@grandstayresort.com");
        grandStay.setIsActive(true);
        grandStay = hotelRepository.save(grandStay);
        
        // Rooms for GrandStay Resort
        createRoomsForHotel(grandStay, 
                           new String[]{"Deluxe Ocean View", "Deluxe Ocean View", "Deluxe Ocean View", 
                                       "Executive Suite", "Executive Suite", "Presidential Suite", "Presidential Suite"},
                           new Integer[]{2, 2, 2, 4, 4, 6, 6},
                           new BigDecimal[]{new BigDecimal("299.00"), new BigDecimal("299.00"), new BigDecimal("299.00"), 
                                           new BigDecimal("499.00"), new BigDecimal("499.00"), new BigDecimal("899.00"), new BigDecimal("899.00")},
                           new String[]{"Ocean View, Balcony, Mini Bar, AC, Pool Access", "Ocean View, Balcony, Mini Bar, AC, Pool Access", "Ocean View, Balcony, Mini Bar, AC, Pool Access",
                                        "Ocean View, Living Room, Kitchenette, Balcony, AC, Pool View", "Ocean View, Living Room, Kitchenette, Balcony, AC, Pool View",
                                        "Ocean View, Living Room, Kitchen, Private Balcony, Butler Service, AC, Pool Access", "Ocean View, Living Room, Kitchen, Private Balcony, Butler Service, AC, Pool Access"});
        
        // Hotel 2: Urban GrandStay
        Hotel urbanGrandStay = new Hotel();
        urbanGrandStay.setName("Urban GrandStay");
        urbanGrandStay.setLocation("Downtown New York, NY");
        urbanGrandStay.setDescription("Modern urban hotel in the heart of Manhattan with city skyline views.");
        urbanGrandStay.setFacilities("Rooftop Pool, Business Center, Fitness Center, Restaurant, Bar, Concierge, Valet Parking");
        urbanGrandStay.setStarRating(4);
        urbanGrandStay.setContactPhone("+1-212-555-0200");
        urbanGrandStay.setContactEmail("info@urbangrandstay.com");
        urbanGrandStay.setIsActive(true);
        urbanGrandStay = hotelRepository.save(urbanGrandStay);
        
        // Rooms for Urban GrandStay
        createRoomsForHotel(urbanGrandStay, 
                           new String[]{"City View Room", "City View Room", "City View Room",
                                       "Executive City View", "Executive City View", "Penthouse Suite", "Penthouse Suite"},
                           new Integer[]{2, 2, 2, 3, 3, 4, 4},
                           new BigDecimal[]{new BigDecimal("199.00"), new BigDecimal("199.00"), new BigDecimal("199.00"), 
                                           new BigDecimal("349.00"), new BigDecimal("349.00"), new BigDecimal("699.00"), new BigDecimal("699.00")},
                           new String[]{"City View, Work Desk, AC", "City View, Work Desk, AC", "City View, Work Desk, AC",
                                        "City View, Living Area, Work Desk, AC, Pool View", "City View, Living Area, Work Desk, AC, Pool View",
                                        "City View, Living Room, Kitchen, Private Terrace, AC, Pool Access", "City View, Living Room, Kitchen, Private Terrace, AC, Pool Access"});
        
        // Hotel 3: Mountain GrandStay
        Hotel mountainGrandStay = new Hotel();
        mountainGrandStay.setName("Mountain GrandStay");
        mountainGrandStay.setLocation("Aspen, Colorado");
        mountainGrandStay.setDescription("Cozy mountain retreat with ski-in/ski-out access and rustic luxury.");
        mountainGrandStay.setFacilities("Ski Storage, Hot Tub, Fireplace Lounge, Restaurant, Bar, Ski Concierge, Free Shuttle");
        mountainGrandStay.setStarRating(4);
        mountainGrandStay.setContactPhone("+1-970-555-0300");
        mountainGrandStay.setContactEmail("info@mountaingrandstay.com");
        mountainGrandStay.setIsActive(true);
        mountainGrandStay = hotelRepository.save(mountainGrandStay);
        
        // Rooms for Mountain GrandStay
        createRoomsForHotel(mountainGrandStay, 
                           new String[]{"Mountain View Room", "Mountain View Room", "Mountain View Room",
                                       "Ski-In Suite", "Ski-In Suite", "Luxury Cabin", "Luxury Cabin"},
                           new Integer[]{2, 2, 2, 4, 4, 6, 6},
                           new BigDecimal[]{new BigDecimal("179.00"), new BigDecimal("179.00"), new BigDecimal("179.00"), 
                                           new BigDecimal("299.00"), new BigDecimal("299.00"), new BigDecimal("449.00"), new BigDecimal("449.00")},
                           new String[]{"Mountain View, Fireplace, Fan Only", "Mountain View, Fireplace, Fan Only", "Mountain View, Fireplace, Fan Only",
                                        "Mountain View, Fireplace, Kitchenette, AC", "Mountain View, Fireplace, Kitchenette, AC",
                                        "Mountain View, Fireplace, Full Kitchen, Private Deck, AC", "Mountain View, Fireplace, Full Kitchen, Private Deck, AC"});
        
            System.out.println("Created sample hotels and rooms");
        } catch (Exception e) {
            System.out.println("Error creating sample hotels: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private void createRoomsForHotel(Hotel hotel, String[] roomTypes, 
                                   Integer[] capacities, BigDecimal[] prices, String[] amenities) {
        for (int i = 0; i < roomTypes.length; i++) {
            Room room = new Room();
            // room.setRoomNumber(roomNumbers[i]);
            room.setRoomType(roomTypes[i]);
            room.setCapacity(capacities[i]);
            room.setPricePerNight(prices[i]);
            // room.setAmenities(amenities[i]);
            // room.setIsAvailable(true);
            room.setHotel(hotel);
            roomRepository.save(room);
        }
    }
    
        private void initializeEvents() {
            try {
                // Only create events if none exist
                if (eventRepository.count() == 0) {
                    createSampleEvents();
                }
            } catch (Exception e) {
                System.out.println("Error initializing events: " + e.getMessage());
                // Continue with initialization - tables might not exist yet
            }
        }
    
    private void createSampleEvents() {
        try {
            LocalDateTime now = LocalDateTime.now();
            
            // Get the first hotel to associate with events
            List<Hotel> hotels = hotelRepository.findAll();
            Hotel defaultHotel = hotels.isEmpty() ? null : hotels.get(0);
        
        // Event 1: New Year's Eve Gala
        Event newYearEvent = new Event();
        newYearEvent.setEventName("New Year's Eve Gala");
        newYearEvent.setEventDate(now.plusDays(90).withHour(20).withMinute(0).withSecond(0));
        newYearEvent.setLocation("GrandStay Resort - Grand Ballroom");
        newYearEvent.setDescription("Ring in the new year with our spectacular gala featuring live music, gourmet dining, and champagne toast at midnight. Black tie optional.");
        newYearEvent.setHotel(defaultHotel);
        newYearEvent.setIsActive(true);
        eventRepository.save(newYearEvent);
        
        // Event 2: Valentine's Day Romance Package
        Event valentineEvent = new Event();
        valentineEvent.setEventName("Valentine's Day Romance Package");
        valentineEvent.setEventDate(now.plusDays(120).withHour(18).withMinute(30).withSecond(0));
        valentineEvent.setLocation("Urban GrandStay - Rooftop Restaurant");
        valentineEvent.setDescription("Celebrate love with our romantic dinner package including wine tasting, couples massage, and city skyline views.");
        valentineEvent.setHotel(defaultHotel);
        valentineEvent.setIsActive(true);
        eventRepository.save(valentineEvent);
        
        // Event 3: Spring Wellness Retreat
        Event wellnessEvent = new Event();
        wellnessEvent.setEventName("Spring Wellness Retreat");
        wellnessEvent.setEventDate(now.plusDays(150).withHour(9).withMinute(0).withSecond(0));
        wellnessEvent.setLocation("Mountain GrandStay - Spa & Wellness Center");
        wellnessEvent.setDescription("Rejuvenate your mind and body with yoga sessions, meditation workshops, spa treatments, and healthy gourmet meals in the mountains.");
        wellnessEvent.setHotel(defaultHotel);
        wellnessEvent.setIsActive(true);
        eventRepository.save(wellnessEvent);
        
        // Event 4: Summer Music Festival
        Event musicEvent = new Event();
        musicEvent.setEventName("Summer Music Festival");
        musicEvent.setEventDate(now.plusDays(200).withHour(16).withMinute(0).withSecond(0));
        musicEvent.setLocation("GrandStay Resort - Beachfront Stage");
        musicEvent.setDescription("Enjoy live performances by local and international artists on our beachfront stage. Food trucks and beach activities included.");
        musicEvent.setHotel(defaultHotel);
        musicEvent.setIsActive(true);
        eventRepository.save(musicEvent);
        
        // Event 5: Business Conference
        Event conferenceEvent = new Event();
        conferenceEvent.setEventName("Tech Innovation Conference");
        conferenceEvent.setEventDate(now.plusDays(60).withHour(8).withMinute(30).withSecond(0));
        conferenceEvent.setLocation("Urban GrandStay - Conference Center");
        conferenceEvent.setDescription("Join industry leaders for a day of innovation talks, networking sessions, and technology demonstrations.");
        conferenceEvent.setHotel(defaultHotel);
        conferenceEvent.setIsActive(true);
        eventRepository.save(conferenceEvent);
        
        // Event 6: Wine Tasting Evening
        Event wineEvent = new Event();
        wineEvent.setEventName("Premium Wine Tasting Evening");
        wineEvent.setEventDate(now.plusDays(30).withHour(19).withMinute(0).withSecond(0));
        wineEvent.setLocation("Mountain GrandStay - Wine Cellar");
        wineEvent.setDescription("Sample exquisite wines from around the world paired with artisanal cheeses and gourmet appetizers.");
        wineEvent.setHotel(defaultHotel);
        wineEvent.setIsActive(true);
        eventRepository.save(wineEvent);
        
        // Event 7: Family Fun Day
        Event familyEvent = new Event();
        familyEvent.setEventName("Family Fun Day");
        familyEvent.setEventDate(now.plusDays(45).withHour(10).withMinute(0).withSecond(0));
        familyEvent.setLocation("GrandStay Resort - Pool Area & Gardens");
        familyEvent.setDescription("A day filled with activities for the whole family including pool games, face painting, magic shows, and BBQ lunch.");
        familyEvent.setHotel(defaultHotel);
        familyEvent.setIsActive(true);
        eventRepository.save(familyEvent);
        
        // Event 8: Cooking Masterclass
        Event cookingEvent = new Event();
        cookingEvent.setEventName("Chef's Cooking Masterclass");
        cookingEvent.setEventDate(now.plusDays(75).withHour(14).withMinute(0).withSecond(0));
        cookingEvent.setLocation("Urban GrandStay - Demonstration Kitchen");
        cookingEvent.setDescription("Learn culinary secrets from our executive chef in this hands-on cooking class. Take home recipes and techniques.");
        cookingEvent.setHotel(defaultHotel);
        cookingEvent.setIsActive(true);
        eventRepository.save(cookingEvent);
        
            System.out.println("Created sample events");
        } catch (Exception e) {
            System.out.println("Error creating sample events: " + e.getMessage());
            e.printStackTrace();
        }
    }
}