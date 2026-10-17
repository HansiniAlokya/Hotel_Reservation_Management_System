package com.hotelreservation.repository;

import com.hotelreservation.model.Guest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface GuestRepository extends JpaRepository<Guest, Long> {
    
    Optional<Guest> findByEmail(String email);
    
    Boolean existsByEmail(String email);
    
    @Query("SELECT g FROM Guest g WHERE g.firstName LIKE %:name% OR g.lastName LIKE %:name%")
    List<Guest> findByNameContaining(@Param("name") String name);
    
    @Query("SELECT g FROM Guest g WHERE g.phoneNumber = :phoneNumber")
    List<Guest> findByPhoneNumber(@Param("phoneNumber") String phoneNumber);
    
    @Query("SELECT g FROM Guest g WHERE g.passportNumber = :passportNumber")
    Optional<Guest> findByPassportNumber(@Param("passportNumber") String passportNumber);
    
    @Query("SELECT g FROM Guest g WHERE g.nationality = :nationality")
    List<Guest> findByNationality(@Param("nationality") String nationality);
}
