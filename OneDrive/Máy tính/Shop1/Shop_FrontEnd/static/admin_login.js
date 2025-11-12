const API_BASE = 'http://127.0.0.1:5001';

document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value;
    const alertDiv = document.getElementById('alert');

    if (!username || !password) {
        showAlert('Vui lòng điền đầy đủ thông tin', 'error');
        return;
    }

    try {
        const response = await fetch(`${API_BASE}/api/admin/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();

        if (data.success) {
            showAlert('✅ Đăng nhập thành công!', 'success');
            // Lưu token vào localStorage
            localStorage.setItem('admin_token', data.token);
            localStorage.setItem('admin_username', username);
            
            // Redirect tới admin dashboard sau 1.5 giây
            setTimeout(() => {
                window.location.href = './admin_dashboard.html';
            }, 1500);
        } else {
            showAlert('❌ ' + data.error, 'error');
        }
    } catch (err) {
        showAlert('❌ Lỗi kết nối: ' + err.message, 'error');
    }
});

function showAlert(message, type) {
    const alertDiv = document.getElementById('alert');
    alertDiv.textContent = message;
    alertDiv.className = `alert ${type}`;
}