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

const filterByCategory = (categoryId) => {
    activeCategoryId = (categoryId === 'all') ? null : parseInt(categoryId);

    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.classList.remove('active');
    });

    document.querySelector(`[data-category-id="${categoryId}"]`).classList.add('active');

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
    updateAuthStatus();
    loadProductsByCategory('all');

    const tabButtons = document.querySelectorAll('.tab-button');
    const authForms = document.querySelectorAll('.auth-form');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const targetTab = button.dataset.tab;

            tabButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            authForms.forEach(form => form.classList.remove('active'));
            document.getElementById(`${targetTab}-form`).classList.add('active');
        });
    });
    const searchBtn = document.getElementById('search-btn');
    searchBtn.addEventListener('click', filterProducts);
});

const updateAuthStatus = () => {
    const authStatusDiv = document.getElementById('auth-status');
    const user = localStorage.getItem('user'); 
    
    if (user && authStatusDiv) {
        try {
            const userData = JSON.parse(user);
            const username = userData.username; 
                authStatusDiv.innerHTML = `
                <a href="javascript:void(0);" class="action-item" style="color: #007bff; font-weight: bold; margin-right: 10px;">
                    <i class="fas fa-user-circle"></i>
                    <span>${username}</span>
                </a>
                <a href="javascript:void(0);" id="logout-btn" class="action-item" style="color: #e63946;">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Thoát</span>
                </a>
            `;
            
            document.getElementById('logout-btn').addEventListener('click', handleLogout);

        } catch (e) {
            console.error("Lỗi parse JSON user data:", e);
        }
    } else if (authStatusDiv) {
        authStatusDiv.innerHTML = `
            <a href="login_register.html" id="login-link" class="action-item">
                <i class="fas fa-user"></i>
                <span>Đăng nhập</span>
            </a>
        `;
    }
};
const handleLogout = () => {
    localStorage.removeItem('user');
    localStorage.removeItem('user_id');
    localStorage.removeItem('username');
    
    updateAuthStatus();
    window.location.reload(); 
};