<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin User Management - Hotel Reservation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: transparent !important;
            background-image: none !important;
            overflow-x: hidden;
            min-height: 100vh;
            padding: 20px;
            color: #333;
            position: relative;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1538683270504-3d09ad7ae739?w=1920') center/cover no-repeat;
            z-index: -1;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            overflow: hidden;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            color: #2c3e50;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.03) 0%, rgba(168, 85, 247, 0.03) 100%);
            pointer-events: none;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 400;
            position: relative;
            z-index: 1;
            letter-spacing: 1px;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.8;
            position: relative;
            z-index: 1;
            color: #5a6c7d;
        }

        .controls {
            padding: 40px;
            background: rgba(248, 249, 250, 0.6);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .search-container {
            display: flex;
            gap: 20px;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            min-width: 300px;
            padding: 15px 25px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.9);
            color: #2c3e50;
        }

        .search-input:focus {
            outline: none;
            border-color: rgba(99, 102, 241, 0.4);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.05);
            background: white;
        }

        .filter-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 12px 25px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.9);
            color: #5a6c7d;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-btn.active {
            background: linear-gradient(135deg, #5a6c7d 0%, #4a5c6d 100%);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(90, 108, 125, 0.25);
            border-color: transparent;
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            background: white;
        }

        .refresh-btn {
            background: linear-gradient(135deg, #5a6c7d 0%, #4a5c6d 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(90, 108, 125, 0.3);
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(135deg, #5a6c7d 0%, #4a5c6d 100%);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .stat-card h3 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
            font-weight: 300;
            letter-spacing: 1px;
        }

        .stat-card p {
            color: #5a6c7d;
            font-weight: 500;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }

        .table-container {
            padding: 40px;
            overflow-x: auto;
        }

        .users-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
        }

        .users-table th {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 25px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .users-table td {
            padding: 25px 20px;
            border-bottom: 1px solid #f1f3f4;
            vertical-align: middle;
        }

        .users-table tr:hover {
            background: rgba(90, 108, 125, 0.03);
        }

        .users-table tr:last-child td {
            border-bottom: none;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #5a6c7d 0%, #4a5c6d 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .user-details h4 {
            margin: 0;
            color: #2c3e50;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 0.3px;
        }

        .user-details p {
            margin: 8px 0 0 0;
            color: #5a6c7d;
            font-size: 14px;
            opacity: 0.9;
        }

        .role-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .role-guest {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        .role-staff {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #333;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
        }

        .status-inactive {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-edit {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220, 53, 69, 0.3);
        }

        .loading {
            text-align: center;
            padding: 80px;
            color: #6c757d;
            font-size: 20px;
            font-weight: 500;
        }

        .loading i {
            font-size: 2rem;
            margin-bottom: 20px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .error-banner {
            background: rgba(248, 215, 218, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: #721c24;
            padding: 20px;
            margin: 20px 40px;
            border-radius: 10px;
            border-left: 4px solid #dc3545;
            font-weight: 500;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .success-banner {
            background: rgba(212, 237, 218, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: #155724;
            padding: 20px;
            margin: 20px 40px;
            border-radius: 10px;
            border-left: 4px solid #28a745;
            font-weight: 500;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            margin: 3% auto;
            padding: 40px;
            border-radius: 15px;
            width: 90%;
            max-width: 700px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(0, 0, 0, 0.08);
        }

        .modal-header h2 {
            color: #2c3e50;
            margin: 0;
            font-size: 2rem;
            font-weight: 400;
            letter-spacing: 0.5px;
        }

        .close {
            color: #aaa;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close:hover {
            color: #000;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 15px;
            letter-spacing: 0.3px;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.95);
            color: #2c3e50;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: rgba(90, 108, 125, 0.5);
            box-shadow: 0 0 0 3px rgba(90, 108, 125, 0.1);
            background: white;
        }

        .modal-buttons {
            display: flex;
            gap: 20px;
            justify-content: flex-end;
            margin-top: 40px;
        }

        .btn-save {
            background: linear-gradient(135deg, #5a6c7d 0%, #4a5c6d 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s;
        }

        .btn-cancel {
            background: rgba(108, 117, 125, 0.1);
            color: #6c757d;
            border: 2px solid rgba(108, 117, 125, 0.3);
            padding: 15px 30px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s;
        }

        .btn-save:hover, .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
        }
        
        .btn-cancel:hover {
            background: rgba(108, 117, 125, 0.15);
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 15px;
            }
            
            .header h1 {
                font-size: 2.2rem;
            }
            
            .search-container {
                flex-direction: column;
            }
            
            .filter-buttons {
                justify-content: center;
            }
            
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .users-table {
                font-size: 14px;
            }
            
            .users-table th,
            .users-table td {
                padding: 15px 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-users"></i> Admin User Management</h1>
            <p>Manage and monitor all registered users with elegant interface</p>
        </div>

        <div class="controls">
            <div class="search-container">
                <input type="text" id="searchInput" class="search-input" placeholder="🔍 Search users by name, email, or username...">
                <div class="filter-buttons">
                    <button class="filter-btn active" data-filter="all">
                        <i class="fas fa-users"></i> All Users
                    </button>
                    <button class="filter-btn" data-filter="admin">
                        <i class="fas fa-crown"></i> Admins
                    </button>
                    <button class="filter-btn" data-filter="guest">
                        <i class="fas fa-user"></i> Guests
                    </button>
                    <button class="filter-btn" data-filter="staff">
                        <i class="fas fa-user-tie"></i> Staff
                    </button>
                </div>
                <button class="refresh-btn" onclick="loadUsers()">
                    <i class="fas fa-sync-alt"></i> Refresh Data
                </button>
            </div>
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <h3 id="totalUsers">0</h3>
                <p><i class="fas fa-users"></i> Total Users</p>
            </div>
            <div class="stat-card">
                <h3 id="adminCount">0</h3>
                <p><i class="fas fa-crown"></i> Admins</p>
            </div>
            <div class="stat-card">
                <h3 id="guestCount">0</h3>
                <p><i class="fas fa-user"></i> Guests</p>
            </div>
            <div class="stat-card">
                <h3 id="activeCount">0</h3>
                <p><i class="fas fa-check-circle"></i> Active Users</p>
            </div>
        </div>

        <div id="errorBanner" class="error-banner" style="display: none;"></div>
        <div id="successBanner" class="success-banner" style="display: none;"></div>

        <div class="table-container">
            <table class="users-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-user"></i> User</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-phone"></i> Phone</th>
                        <th><i class="fas fa-user-tag"></i> Role</th>
                        <th><i class="fas fa-toggle-on"></i> Status</th>
                        <th><i class="fas fa-calendar"></i> Created</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody id="usersTableBody">
                    <tr>
                        <td colspan="7" class="loading">
                            <i class="fas fa-spinner"></i><br>
                            Loading users...
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-edit"></i> Edit User</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="editUserForm">
                <input type="hidden" id="editUserId">
                <div class="form-group">
                    <label for="editFirstName"><i class="fas fa-user"></i> First Name</label>
                    <input type="text" id="editFirstName" required>
                </div>
                <div class="form-group">
                    <label for="editLastName"><i class="fas fa-user"></i> Last Name</label>
                    <input type="text" id="editLastName" required>
                </div>
                <div class="form-group">
                    <label for="editEmail"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="editEmail" required>
                </div>
                <div class="form-group">
                    <label for="editPhone"><i class="fas fa-phone"></i> Phone Number</label>
                    <input type="tel" id="editPhone">
                </div>
                <div class="form-group">
                    <label for="editRole"><i class="fas fa-user-tag"></i> Role</label>
                    <select id="editRole" required>
                        <option value="GUEST">Guest</option>
                        <option value="ADMIN">Admin</option>
                        <option value="STAFF">Staff</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editStatus"><i class="fas fa-toggle-on"></i> Status</label>
                    <select id="editStatus" required>
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editPassword"><i class="fas fa-lock"></i> New Password (leave blank to keep current)</label>
                    <input type="password" id="editPassword">
                </div>
                <div class="modal-buttons">
                    <button type="button" class="btn-cancel" onclick="closeModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let allUsers = [];
        let currentFilter = 'all';

        // Load users on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadUsers();
            setupEventListeners();
        });

        function setupEventListeners() {
            // Search functionality
            document.getElementById('searchInput').addEventListener('input', function() {
                applyFilters();
            });

            // Filter buttons
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    currentFilter = this.dataset.filter;
                    applyFilters();
                });
            });

            // Edit form submission
            document.getElementById('editUserForm').addEventListener('submit', function(e) {
                e.preventDefault();
                saveUser();
            });
        }

        async function loadUsers() {
            try {
                const response = await fetch('/api/admin/users/api');
                if (!response.ok) {
                    throw new Error('Failed to load users');
                }
                allUsers = await response.json();
                updateStats();
                applyFilters();
                hideBanner();
            } catch (error) {
                console.error('Error loading users:', error);
                showError('Error loading users: ' + error.message);
                document.getElementById('usersTableBody').innerHTML = 
                    '<tr><td colspan="7" class="loading"><i class="fas fa-exclamation-triangle"></i><br>Error loading users</td></tr>';
            }
        }

        function updateStats() {
            const totalUsers = allUsers.length;
            const adminCount = allUsers.filter(user => user.roles && user.roles.includes('ADMIN')).length;
            const guestCount = allUsers.filter(user => user.roles && user.roles.includes('GUEST')).length;
            const activeCount = allUsers.filter(user => user.isActive).length;

            document.getElementById('totalUsers').textContent = totalUsers;
            document.getElementById('adminCount').textContent = adminCount;
            document.getElementById('guestCount').textContent = guestCount;
            document.getElementById('activeCount').textContent = activeCount;
        }

        function applyFilters() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            
            let filteredUsers = allUsers.filter(user => {
                const matchesSearch = !searchTerm || 
                    user.firstName.toLowerCase().includes(searchTerm) ||
                    user.lastName.toLowerCase().includes(searchTerm) ||
                    user.email.toLowerCase().includes(searchTerm) ||
                    user.username.toLowerCase().includes(searchTerm);
                
                const matchesFilter = currentFilter === 'all' || 
                    (user.roles && user.roles.includes(currentFilter.toUpperCase()));
                
                return matchesSearch && matchesFilter;
            });

            displayUsers(filteredUsers);
        }

        function displayUsers(users) {
            const tbody = document.getElementById('usersTableBody');
            
            if (users.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="loading"><i class="fas fa-search"></i><br>No users found</td></tr>';
                return;
            }

            tbody.innerHTML = users.map(user => {
                const firstName = user.firstName || '';
                const lastName = user.lastName || '';
                const email = user.email || '';
                const phoneNumber = user.phoneNumber || 'N/A';
                const username = user.username || '';
                const roles = user.roles || [];
                const isActive = user.isActive;
                const createdAt = user.createdAt || '';
                const userId = user.id || '';

                const roleBadges = roles.map(role => 
                    '<span class="role-badge role-' + role.toLowerCase() + '">' + role + '</span>'
                ).join(' ');

                return '<tr>' +
                    '<td>' +
                        '<div class="user-info">' +
                            '<div class="user-avatar">' +
                                (firstName.charAt(0) || 'U').toUpperCase() + (lastName.charAt(0) || 'U').toUpperCase() +
                            '</div>' +
                            '<div class="user-details">' +
                                '<h4>' + firstName + ' ' + lastName + '</h4>' +
                                '<p>@' + username + '</p>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td>' + email + '</td>' +
                    '<td>' + phoneNumber + '</td>' +
                    '<td>' + (roleBadges || 'N/A') + '</td>' +
                    '<td>' +
                        '<span class="status-badge status-' + (isActive ? 'active' : 'inactive') + '">' +
                            (isActive ? 'Active' : 'Inactive') +
                        '</span>' +
                    '</td>' +
                    '<td>' + formatDate(createdAt) + '</td>' +
                    '<td>' +
                        '<div class="action-buttons">' +
                            '<button class="btn-edit" onclick="editUser(' + userId + ')">' +
                                '<i class="fas fa-edit"></i> Edit' +
                            '</button>' +
                            '<button class="btn-delete" onclick="deleteUser(' + userId + ')">' +
                                '<i class="fas fa-trash"></i> Delete' +
                            '</button>' +
                        '</div>' +
                    '</td>' +
                '</tr>';
            }).join('');
        }

        function editUser(userId) {
            const user = allUsers.find(u => u.id === userId);
            if (!user) return;

            document.getElementById('editUserId').value = user.id;
            document.getElementById('editFirstName').value = user.firstName || '';
            document.getElementById('editLastName').value = user.lastName || '';
            document.getElementById('editEmail').value = user.email || '';
            document.getElementById('editPhone').value = user.phoneNumber || '';
            document.getElementById('editRole').value = user.roles ? user.roles[0] : 'GUEST';
            document.getElementById('editStatus').value = user.isActive.toString();
            document.getElementById('editPassword').value = '';

            document.getElementById('editModal').style.display = 'block';
        }

        async function saveUser() {
            const userId = document.getElementById('editUserId').value;
            const userData = {
                firstName: document.getElementById('editFirstName').value,
                lastName: document.getElementById('editLastName').value,
                email: document.getElementById('editEmail').value,
                phoneNumber: document.getElementById('editPhone').value,
                isActive: document.getElementById('editStatus').value === 'true',
                roles: [document.getElementById('editRole').value]
            };

            const password = document.getElementById('editPassword').value;
            if (password) {
                userData.password = password;
            }

            try {
                const response = await fetch('/api/admin/users/api/' + userId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(userData)
                });

                if (!response.ok) {
                    const error = await response.json();
                    throw new Error(error.message || 'Failed to update user');
                }

                showSuccess('User updated successfully!');
                closeModal();
                loadUsers();
            } catch (error) {
                console.error('Error updating user:', error);
                showError('Error updating user: ' + error.message);
            }
        }

        async function deleteUser(userId) {
            if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                return;
            }

            try {
                const response = await fetch('/api/admin/users/api/' + userId, {
                    method: 'DELETE'
                });

                if (!response.ok) {
                    const error = await response.json();
                    throw new Error(error.message || 'Failed to delete user');
                }

                showSuccess('User deleted successfully!');
                loadUsers();
            } catch (error) {
                console.error('Error deleting user:', error);
                showError('Error deleting user: ' + error.message);
            }
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
        }

        function showError(message) {
            const banner = document.getElementById('errorBanner');
            banner.textContent = message;
            banner.style.display = 'block';
            setTimeout(hideBanner, 5000);
        }

        function showSuccess(message) {
            const banner = document.getElementById('successBanner');
            banner.textContent = message;
            banner.style.display = 'block';
            setTimeout(hideBanner, 5000);
        }

        function hideBanner() {
            document.getElementById('errorBanner').style.display = 'none';
            document.getElementById('successBanner').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('editModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>