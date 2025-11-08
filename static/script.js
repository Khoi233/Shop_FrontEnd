document.addEventListener('DOMContentLoaded', () => {
    const tabButtons = document.querySelectorAll('.tab-button');
    const authForms = document.querySelectorAll('.auth-form');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const targetTab = button.dataset.tab;

            // Xóa trạng thái active khỏi tất cả các nút tab
            tabButtons.forEach(btn => btn.classList.remove('active'));
            // Thêm trạng thái active vào nút được nhấp
            button.classList.add('active');

            // Ẩn tất cả các form
            authForms.forEach(form => form.classList.remove('active'));
            // Hiển thị form tương ứng với tab được nhấp
            document.getElementById(`${targetTab}-form`).classList.add('active');
        });
    });

    // Bạn có thể thêm các logic JavaScript khác ở đây,
    // ví dụ: kiểm tra dữ liệu đầu vào (form validation)
    // hoặc xử lý việc gửi form (sẽ cần backend sau này).

    const loginForm = document.getElementById('login-form');
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault(); // Ngăn chặn form gửi đi theo cách truyền thống
        console.log('Form Đăng nhập đã được gửi!');
        // TODO: Thêm logic gửi dữ liệu đến Backend
    });

    const registerForm = document.getElementById('register-form');
    registerForm.addEventListener('submit', (e) => {
        e.preventDefault(); // Ngăn chặn form gửi đi theo cách truyền thống
        console.log('Form Đăng ký đã được gửi!');
        // TODO: Thêm logic gửi dữ liệu đến Backend
    });
});