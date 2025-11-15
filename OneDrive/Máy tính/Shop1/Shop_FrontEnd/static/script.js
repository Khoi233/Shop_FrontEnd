const API_BASE = 'http://127.0.0.1:5001';

let allProducts = [];
let activeCategoryId = 'all';

const CATEGORY_NAMES = [
    "Tất cả sản phẩm", // ID: 'all' (or 0)
    "Thuốc giảm đau, chống viêm",      // ID: 1
    "Kháng sinh & Dị ứng", // ID: 2
    // Add more categories here
];

const loadProductsByCategory = async (categoryId) => {
    activeCategoryId = categoryId;

    try {
        const response = await fetch(`${API_BASE}/list_products?category_id=${categoryId}`);
        if (!response.ok) throw new Error('Failed to fetch products.');

        const products = await response.json();
        allProducts = products;

        renderProducts(products);
    }
    catch (err) {
        console.error('Error loading products: ', err);
        document.getElementById('product-list').innerHTML = '<p>Failed to load products.</p>';
    }
};

// const fetchCategories = async () => { // Copy from new_product.js, delete if found a way to import
//     const categorySelect = document.getElementById('category');

//     try {
//         const response = await fetch(`${API_BASE}/categories`);

//         if (!response.ok) {
//             throw new Error(`Failed to fetch categories. Status ${response.status}`);
//         }
//         categories = await response.json();
//         renderCategoryButtons(categories);
//     }
//     catch (err) {
//         console.error('Error fetching categories: ', err);

//         const errorMessage = document.createElement('option');
//         errorMessage.value = '';
//         errorMessage.textContent = 'Failed to load categories';
//         categorySelect.appendChild(errorMessage);
//     }
// }

const filterByCategory = (categoryId) => {
    activeCategoryId = (categoryId === 'all') ? null : parseInt(categoryId);

    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.classList.remove('active');
    });

    document.querySelector(`[data-category-id="${categoryId}"]`).classList.add('active');

    // document.querySelector('.product-search').value = '';

    loadProductsByCategory(categoryId);
}

const filterProducts = () => {
    const searchInput = document.querySelector('.search-input').value.trim().toLowerCase();

    let filteredProducts = allProducts;

    if (!searchInput) {
        renderProducts(allProducts);
        return;
    }

    filteredProducts = allProducts.filter(p => 
        p.Name.toLowerCase().includes(searchInput)
    );

    renderProducts(filteredProducts);
}

const renderProducts = (products) => {
    console.log("Rendering for customers...");
    const container = document.getElementById('product-grid');
    container.innerHTML = '';

    if (products.length === 0) {
        container.innerHTML = '<p style="text-align:center;">Không tìm thấy sản phẩm nào.</p>';
        return;
    }

    products.forEach((product) => {
        const card = document.createElement('div');
        card.className = 'product-card';

        card.innerHTML = `
        <h3><a href="product_detail.html?id=${product.ProductId}">${product.Name}</a></h3>
        <p class="price">${parseInt(product.Price.toLocaleString('vi-VN'))} VNĐ</p>
        <button class="btn-add-to-cart" data-product-id="${product.ProductId}">Thêm vào giỏ</button>
        `;
        const addToCartBtn = card.querySelector('.btn-add-to-cart');
        addToCartBtn.addEventListener('click', () => {
            const productId = addToCartBtn.getAttribute('data-product-id');
            addToCart(productId);
        });

        container.appendChild(card);
    })
}

const renderCategoryButtons = () => {
    console.log("Rendering category buttons...");
    const panel = document.getElementById('category-filter-panel');
    panel.innerHTML = `
        <nav class="main-nav">
            <ul class="main-nav-list" id="category-list-ul">
            </ul>
        </nav>
    `;

    const ul = document.getElementById('category-list-ul');
    CATEGORY_NAMES.forEach ((name, index) => {
        const categoryId = (index === 0) ? 'all' : index;
        const isActive = (index === 0) ? 'active' : '';

        const li = document.createElement('li');

        li.innerHTML = `
        <button class="category-btn ${isActive}" id="category-${categoryId}" data-category-id="${categoryId}">${name}</button>
        `;
        ul.appendChild(li);
    });

    panel.querySelectorAll('.category-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            const categoryId = e.target.getAttribute('data-category-id');
            filterByCategory(categoryId);
        })
    });
}

const addToCart = async (productId) => {
    const userId = localStorage.getItem('user_id');
    
    if (!userId) {
        alert('Vui lòng đăng nhập trước');
        window.location.href = './login_register.html';
        return;
    }

    try {
        const response = await fetch(`${API_BASE}/api/cart/add`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                user_id: userId,
                product_id: productId,
                quantity: 1
            })
        });

        const data = await response.json();
        
        if (data.success) {
            alert('✅ Thêm vào giỏ hàng thành công');
        } else {
            alert('❌ ' + data.error);
        }
    } catch (err) {
        console.error('Error:', err);
        alert('Lỗi thêm vào giỏ hàng');
    }
};


document.addEventListener('DOMContentLoaded', () => {
    renderCategoryButtons();

    loadProductsByCategory('all');

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

    // // Bạn có thể thêm các logic JavaScript khác ở đây,
    // // ví dụ: kiểm tra dữ liệu đầu vào (form validation)
    // // hoặc xử lý việc gửi form (sẽ cần backend sau này).

    // const loginForm = document.getElementById('login-form');
    // loginForm.addEventListener('submit', (e) => {
    //     e.preventDefault(); // Ngăn chặn form gửi đi theo cách truyền thống
    //     console.log('Form Đăng nhập đã được gửi!');
    //     // TODO: Thêm logic gửi dữ liệu đến Backend
    // });

    // const registerForm = document.getElementById('register-form');
    // registerForm.addEventListener('submit', (e) => {
    //     e.preventDefault(); // Ngăn chặn form gửi đi theo cách truyền thống
    //     console.log('Form Đăng ký đã được gửi!');
    //     // TODO: Thêm logic gửi dữ liệu đến Backend
    // });

    const searchBtn = document.getElementById('search-btn');
    searchBtn.addEventListener('click', filterProducts);
});