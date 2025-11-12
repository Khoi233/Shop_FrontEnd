const API_BASE = 'http://127.0.0.1:5001';
let adminToken = localStorage.getItem('admin_token');
let adminUsername = localStorage.getItem('admin_username');

// Kiểm tra nếu chưa login, redirect tới login page
window.addEventListener('load', () => {
    if (!adminToken) {
        window.location.href = './admin_login.html';
        return;
    }
    // Cập nhật username trên header
    document.getElementById('admin-username').textContent = adminUsername || 'Admin';
    loadDashboardData();
});

// Hàm format tiền tệ
const formatCurrency = (amount) => {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
};

// Hàm format ngày tháng
const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('vi-VN');
};

// Tải dữ liệu Dashboard (có token)
const loadDashboardData = async () => {
    try {
        const response = await fetch(`${API_BASE}/admin/dashboard`, {
            headers: { 'Authorization': `Bearer ${adminToken}` }
        });
        
        if (response.status === 401) {
            localStorage.removeItem('admin_token');
            window.location.href = './admin_login.html';
            return;
        }
        
        if (!response.ok) throw new Error('Failed to fetch dashboard data');

        const data = await response.json();
        document.getElementById('total-products').textContent = data.total_products;
        document.getElementById('total-users').textContent = data.total_users;
        document.getElementById('total-orders').textContent = data.total_orders;
        document.getElementById('total-revenue').textContent = formatCurrency(data.total_revenue);
    } catch (err) {
        console.error('Error loading dashboard:', err);
    }
};

// Tải danh sách người dùng (có token)
const loadUsers = async () => {
    try {
        const response = await fetch(`${API_BASE}/admin/users`, {
            headers: { 'Authorization': `Bearer ${adminToken}` }
        });
        
        if (response.status === 401) {
            localStorage.removeItem('admin_token');
            window.location.href = './admin_login.html';
            return;
        }
        
        if (!response.ok) throw new Error('Failed to fetch users');

        const users = await response.json();
        const tbody = document.getElementById('users-table-body');
        tbody.innerHTML = '';

        if (users.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;">Không có dữ liệu</td></tr>';
            return;
        }

        users.forEach(user => {
            const row = tbody.insertRow();
            row.innerHTML = `
                <td>${user.UserId}</td>
                <td>${user.Username}</td>
                <td>${user.Email}</td>
                <td>${user.Fname} ${user.Lname}</td>
                <td>${user.Address || 'N/A'}</td>
                <td>${formatDate(user.Dob)}</td>
            `;
        });
    } catch (err) {
        console.error('Error loading users:', err);
        document.getElementById('users-table-body').innerHTML = 
            '<tr><td colspan="6" style="text-align:center; color:red;">Lỗi tải dữ liệu</td></tr>';
    }
};

// Tải danh sách đơn hàng (có token)
const loadOrders = async () => {
    try {
        const response = await fetch(`${API_BASE}/admin/orders`, {
            headers: { 'Authorization': `Bearer ${adminToken}` }
        });
        
        if (response.status === 401) {
            localStorage.removeItem('admin_token');
            window.location.href = './admin_login.html';
            return;
        }
        
        if (!response.ok) throw new Error('Failed to fetch orders');

        const orders = await response.json();
        const tbody = document.getElementById('orders-table-body');
        tbody.innerHTML = '';

        if (orders.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;">Không có dữ liệu</td></tr>';
            return;
        }

        orders.forEach(order => {
            const row = tbody.insertRow();
            const statusBadge = `<span class="status-badge status-${order.Status.toLowerCase()}">${order.Status}</span>`;
            row.innerHTML = `
                <td>${order.OrderId}</td>
                <td>${formatDate(order.OrderDate)}</td>
                <td>${order.Username}</td>
                <td>${order.Email}</td>
                <td>${statusBadge}</td>
            `;
        });
    } catch (err) {
        console.error('Error loading orders:', err);
        document.getElementById('orders-table-body').innerHTML = 
            '<tr><td colspan="5" style="text-align:center; color:red;">Lỗi tải dữ liệu</td></tr>';
    }
};

// Tải danh sách sản phẩm (không cần token)
const loadProducts = async () => {
    try {
        const response = await fetch(`${API_BASE}/list_products`);
        if (!response.ok) throw new Error('Failed to fetch products');

        const products = await response.json();
        const container = document.getElementById('products-container');
        container.innerHTML = '';

        if (products.length === 0) {
            container.innerHTML = '<p style="text-align:center;">Không có sản phẩm</p>';
            return;
        }

        const table = document.createElement('table');
        table.className = 'admin-table';
        table.innerHTML = `
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Mô tả</th>
                </tr>
            </thead>
            <tbody></tbody>
        `;

        const tbody = table.querySelector('tbody');
        products.forEach(product => {
            const row = tbody.insertRow();
            row.innerHTML = `
                <td>${product.ProductId}</td>
                <td>${product.Name}</td>
                <td>${formatCurrency(product.Price)}</td>
                <td>${product.Stock}</td>
                <td>${product.Description.substring(0, 50)}...</td>
            `;
        });

        container.appendChild(table);
    } catch (err) {
        console.error('Error loading products:', err);
        document.getElementById('products-container').innerHTML = 
            '<p style="text-align:center; color:red;">Lỗi tải dữ liệu</p>';
    }
};

// Chuyển đổi section
const switchSection = (sectionName) => {
    document.querySelectorAll('.content-section').forEach(section => {
        section.classList.remove('active');
    });

    const activeSection = document.getElementById(sectionName);
    if (activeSection) {
        activeSection.classList.add('active');
    }

    document.querySelectorAll('.nav-item').forEach(item => {
        item.classList.remove('active');
    });
    document.querySelector(`[data-section="${sectionName}"]`)?.classList.add('active');

    if (sectionName === 'users') loadUsers();
    if (sectionName === 'orders') loadOrders();
    if (sectionName === 'products') loadProducts();
};

// Logout
function adminLogout() {
    localStorage.removeItem('admin_token');
    localStorage.removeItem('admin_username');
    window.location.href = './admin_login.html';
}

// Khởi tạo
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            const section = item.dataset.section;
            if (section) {
                switchSection(section);
            }
        });
    });

    loadUsers();
});