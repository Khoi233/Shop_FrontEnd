const API_BASE = 'http://127.0.0.1:5001';

// Hiển thị thông báo
function showAlert(message, type = 'info') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.innerHTML = `<i class="fas fa-${type === 'error' ? 'exclamation-circle' : type === 'success' ? 'check-circle' : 'info-circle'}"></i> ${message}`;
    
    const form = document.querySelector('.auth-form.active');
    form.insertBefore(alertDiv, form.firstChild);
    
    // Tự động xóa alert sau 5 giây
    setTimeout(() => alertDiv.remove(), 5000);
}

// Xóa tất cả alert
function clearAlerts() {
    document.querySelectorAll('.alert').forEach(alert => alert.remove());
}

// Tab switching
document.querySelectorAll('.tab-button').forEach(button => {
    button.addEventListener('click', (e) => {
        e.preventDefault();
        
        // Remove active từ tất cả button
        document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.auth-form').forEach(form => form.classList.remove('active'));
        
        // Add active tới button được click
        button.classList.add('active');
        const tabName = button.dataset.tab;
        document.getElementById(`${tabName}-form`).classList.add('active');
        
        clearAlerts();
    });
});

// LOGIN FORM
document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    clearAlerts();

    const username = document.getElementById('login-username').value.trim();
    const password = document.getElementById('login-password').value;

    if (!username || !password) {
        showAlert('Vui lòng điền đầy đủ thông tin', 'error');
        return;
    }

    try {
        const response = await fetch(`${API_BASE}/api/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();

        if (data.success) {
            showAlert(data.message, 'success');

            // Lưu user info (cart.js dùng user_id)
            localStorage.setItem('user', JSON.stringify(data.user));
            localStorage.setItem('user_id', data.user.user_id);
            localStorage.setItem('username', data.user.username);

            // Redirect ngay về trang chủ (Flask route '/')
            window.location.href = '/';
        } else {
            showAlert(data.error, 'error');
        }
    } catch (err) {
        showAlert('Lỗi kết nối: ' + err.message, 'error');
    }
});

// REGISTER FORM
document.getElementById('register-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    clearAlerts();
    
    const fname = document.getElementById('register-fname').value.trim();
    const lname = document.getElementById('register-lname').value.trim();
    const email = document.getElementById('register-email').value.trim();
    const username = document.getElementById('register-username').value.trim();
    const password = document.getElementById('register-password').value;
    const confirm_password = document.getElementById('register-confirm-password').value;
    const dob = document.getElementById('register-dob').value;
    const address = document.getElementById('register-address').value.trim();
    
    // Validation
    if (!fname || !lname || !email || !username || !password || !confirm_password) {
        showAlert('Vui lòng điền tất cả các trường bắt buộc', 'error');
        return;
    }
    
    if (password !== confirm_password) {
        showAlert('Mật khẩu không trùng khớp', 'error');
        return;
    }
    
    if (password.length < 6) {
        showAlert('Mật khẩu phải ít nhất 6 ký tự', 'error');
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE}/api/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                fname, lname, email, username, password, confirm_password, dob, address
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            showAlert(data.message, 'success');
            
            // Reset form
            document.getElementById('register-form').reset();
            
            // Chuyển tới tab login sau 2 giây
            setTimeout(() => {
                document.querySelector('[data-tab="login"]').click();
                document.getElementById('login-username').value = username;
                document.getElementById('login-username').focus();
            }, 2000);
        } else {
            showAlert(data.error, 'error');
        }
    } catch (err) {
        showAlert('Lỗi kết nối: ' + err.message, 'error');
    }
});