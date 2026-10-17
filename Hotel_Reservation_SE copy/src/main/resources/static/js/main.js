// Hotel Reservation System JavaScript
// Main JavaScript file for frontend functionality

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the application
    initializeApp();
});

function initializeApp() {
    loadFeaturedEvents();
    setupEventListeners();
    initializeTooltips();
}

function loadFeaturedEvents() {
    const eventsContainer = document.getElementById('featured-events');
    if (!eventsContainer) return;

    fetch('/api/events/active')
        .then(response => response.json())
        .then(events => {
            displayEvents(events.slice(0, 3), eventsContainer);
        })
        .catch(error => {
            console.error('Error loading events:', error);
            eventsContainer.innerHTML = '<div class="col-12"><div class="alert alert-warning">Unable to load events at this time.</div></div>';
        });
}

function displayEvents(events, container) {
    if (!events || events.length === 0) {
        container.innerHTML = '<div class="col-12"><div class="alert alert-info">No events available at this time.</div></div>';
        return;
    }

    container.innerHTML = events.map(event => `
        <div class="col-md-4 mb-4">
            <div class="event-card fade-in">
                <div class="event-image">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="event-content">
                    <h5 class="event-title">${event.name}</h5>
                    <p class="event-description">${event.description}</p>
                    <div class="event-details">
                        <span class="event-price">$${event.pricePerPerson}</span>
                        <span class="event-capacity">${event.currentBookings}/${event.maxCapacity} guests</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <small class="text-muted">
                            <i class="fas fa-map-marker-alt me-1"></i>${event.location}
                        </small>
                        <button class="btn btn-primary btn-sm" onclick="viewEvent(${event.id})">
                            View Details
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `).join('');
}

function viewEvent(eventId) {
    // Navigate to event details page
    window.location.href = `/events/${eventId}`;
}

function setupEventListeners() {
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(handleSearch, 300));
    }

    // Form submissions
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', handleFormSubmit);
    });

    // Modal events
    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        modal.addEventListener('show.bs.modal', handleModalShow);
        modal.addEventListener('hide.bs.modal', handleModalHide);
    });
}

function handleSearch(event) {
    const query = event.target.value;
    if (query.length < 2) return;

    // Implement search functionality
    console.log('Searching for:', query);
}

function handleFormSubmit(event) {
    const form = event.target;
    const submitButton = form.querySelector('button[type="submit"]');
    
    if (submitButton) {
        submitButton.disabled = true;
        submitButton.innerHTML = '<span class="spinner"></span> Processing...';
    }
}

function handleModalShow(event) {
    const modal = event.target;
    // Initialize modal content
    console.log('Modal showing:', modal.id);
}

function handleModalHide(event) {
    const modal = event.target;
    // Clean up modal content
    console.log('Modal hiding:', modal.id);
}

function initializeTooltips() {
    // Initialize Bootstrap tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Utility functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

function showAlert(message, type = 'info') {
    const alertContainer = document.getElementById('alertContainer') || createAlertContainer();
    const alertId = 'alert-' + Date.now();
    
    const alertHtml = `
        <div id="${alertId}" class="alert alert-${type} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    alertContainer.insertAdjacentHTML('beforeend', alertHtml);
    
    // Auto-dismiss after 5 seconds
    setTimeout(() => {
        const alert = document.getElementById(alertId);
        if (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }
    }, 5000);
}

function createAlertContainer() {
    const container = document.createElement('div');
    container.id = 'alertContainer';
    container.className = 'position-fixed top-0 end-0 p-3';
    container.style.zIndex = '1050';
    document.body.appendChild(container);
    return container;
}

// API Helper functions
async function apiRequest(url, options = {}) {
    const defaultOptions = {
        headers: {
            'Content-Type': 'application/json',
        },
    };

    const mergedOptions = { ...defaultOptions, ...options };

    try {
        const response = await fetch(url, mergedOptions);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        console.error('API request failed:', error);
        showAlert('An error occurred while processing your request.', 'danger');
        throw error;
    }
}

// Event management functions
async function createReservation(reservationData) {
    return await apiRequest('/api/reservations', {
        method: 'POST',
        body: JSON.stringify(reservationData),
    });
}

async function getEventById(eventId) {
    return await apiRequest(`/api/events/${eventId}`);
}

async function getReservationsByUser(userId) {
    return await apiRequest(`/api/reservations/user/${userId}`);
}

// Form validation
function validateForm(form) {
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.classList.add('is-invalid');
            isValid = false;
        } else {
            input.classList.remove('is-invalid');
        }
    });

    return isValid;
}

// Date picker initialization
function initializeDatePickers() {
    const dateInputs = document.querySelectorAll('input[type="date"]');
    dateInputs.forEach(input => {
        // Set minimum date to today
        input.min = new Date().toISOString().split('T')[0];
    });
}

// Initialize date pickers when DOM is loaded
document.addEventListener('DOMContentLoaded', initializeDatePickers);
