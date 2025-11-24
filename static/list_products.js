const API_BASE = 'http://127.0.0.1:5001';

let allProducts = [];
let activeCategoryId = 'all';
let categories = [];


const userId = localStorage.getItem('user_id');

const formatCurrency = (amount) => {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
};

const loadProductsByCategory = async (categoryId) => {
    activeCategoryId = categoryId;

    try {
        const response = await fetch(`${API_BASE}/list_products?category_id=${categoryId}`);
        if (!response.ok) throw new Error('Failed to fetch products.');

        const products = await response.json();
        allProducts = products;

        document.querySelector('.product-search').value = '';

        renderProducts(products);
    }
    catch (err) {
        console.error('Error loading products: ', err);
        document.getElementById('product-list').innerHTML = '<p>Failed to load products.</p>';
    }
};


const fetchCategories = async () => {
    try {
        const response = await fetch(`${API_BASE}/categories`);

        if (!response.ok) {
            throw new Error(`Failed to fetch categories. Status ${response.status}`);
        }
        categories = await response.json();
        renderCategoryButtons(categories);
    }
    catch (err) {
        console.error('Error fetching categories: ', err);
        // Có thể thêm thông báo lỗi trên UI cho category filter panel
    }
}

const renderCategoryButtons = (categories) => {
    const panel = document.getElementById('category-filter-panel');
    panel.innerHTML = '<button id="category-all" data-category-id="all" class="category-btn active">All Products</button>';

    categories.forEach(category => {
        const button = document.createElement('button');
        button.className = 'category-btn';
        button.id = `category-${category.CategoryId}`;
        button.setAttribute('data-category-id', category.CategoryId);
        button.textContent = category.Name;
        panel.appendChild(button);
    });

    panel.querySelectorAll('.category-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            const categoryId = e.target.getAttribute('data-category-id');
            filterByCategory(categoryId);
        })
    });
}

const createUpdateForm = async (product) => {
    // Xoá form cũ nếu có
    document.getElementById('update-form-container')?.remove();

    const formContainer = document.createElement('div');
    formContainer.id = 'update-form-container';
    formContainer.className = 'update-form';

    formContainer.innerHTML = `
        <div class="update-form-modal">
            <h3>Update product: ${product.Name} (ID: ${product.ProductId})</h3>
            <form id="product-update-form">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${product.Name}" required><br>
                
                <label for="description">Description:</label>
                <textarea id="description" name="description" required>${product.Description}</textarea><br>
                
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <option value="" disabled>Select category</option>
                </select><br>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price"
                       value="${product.Price}" min="0" step="0.01" required><br>

                <label for="stock">Remaining Stock:</label>
                <input type="number" id="stock" name="stock"
                       min="0" value="${product.Stock}" required><br>

                <button type="submit" id="confirm-changes-btn">Confirm Changes</button>
                <button type="button" id="cancel-update-btn">Cancel</button>
            </form>
        </div>
    `;

    document.body.appendChild(formContainer);

    try {
        // Đảm bảo đã có categories (gọi lại cho chắc, hoặc bỏ đi nếu đã fetch ở ngoài)
        if (!categories || categories.length === 0) {
            await fetchCategories();
        }

        const categorySelect = document.getElementById('category');

        // Xoá option cũ (trừ placeholder)
        categorySelect.innerHTML = '<option value="" disabled>Select category</option>';

        // Đổ options từ mảng categories
        categories.forEach(cat => {
            const opt = document.createElement('option');
            opt.value = cat.CategoryId;
            opt.textContent = cat.Name;
            // chọn category hiện tại của product
            if (String(cat.CategoryId) === String(product.CategoryId)) {
                opt.selected = true;
            }
            categorySelect.appendChild(opt);
        });

    } catch (err) {
        console.error('Error setting product category: ', err);
    }

    document.getElementById('cancel-update-btn').addEventListener('click', () => {
        formContainer.remove();
    });

    document.getElementById('product-update-form').addEventListener('submit', (event) => {
        event.preventDefault();
        handleUpdateSubmit(product.ProductId, formContainer);
    });
};


const handleUpdateSubmit = async (productId, formContainer) => {
    const form = document.getElementById('product-update-form');

    const updatedData = {
        Description: form.description.value,
        Name: form.name.value,
        Price: parseFloat(form.price.value),
        ProductId: productId,
        Stock: parseInt(form.stock.value),
        CategoryId: form.category.value
    }

    try {
        const response = await fetch(`${API_BASE}/update_product`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedData),
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Failed to update product on server.')
        }

        alert('Product updated successfully!');
        formContainer.remove();
        loadProductsByCategory(activeCategoryId);
    }
    catch (err) {
        console.error('Error updating product: ', err);
        alert(`Update failed: ${err.message}`);
        formContainer.remove();
    }
}

const renderProducts = (products) => {
    console.log("Rendering...");
    const container = document.getElementById('product-list');
    container.innerHTML = '';

    if (products.length === 0) {
        container.innerHTML = '<p style="text-align:center;">No products found.</p>';
        return;
    }

    const listContainer = document.createElement('div');
    listContainer.className = 'product-list-container';
    container.appendChild(listContainer);


    products.forEach((product) => {
        const card = document.createElement('div');
        card.className = 'product-card';

        card.innerHTML = `
        <div class="product-header">
            <h4>${product.Name}</h4>
            <span class="product-id">ID: ${product.ProductId}</span>
        </div>
        
        <div class="product-description-box">
            ${product.Description}
        </div>

        <div class="product-info-grid">
            <div><strong>Giá:</strong> ${formatCurrency(product.Price)}</div>
            <div><strong>Tồn kho:</strong> ${product.Stock}</div>
            <div><strong>Category ID:</strong> ${product.CategoryId}</div>
            <!-- Có thể thêm Category Name sau -->
        </div>

        <div class="product-actions">
            <button class="product-update-btn">Update product information</button>
            <button class="product-delete-btn">Delete</button>
        </div>
        `;

        const updateProductBtn = card.querySelector('.product-update-btn');
        updateProductBtn.addEventListener('click', () => {
            createUpdateForm(product);
        });

        const deleteProductBtn = card.querySelector('.product-delete-btn');
        deleteProductBtn.addEventListener('click', () => {
            confirmDeletion(product);
        })

        listContainer.appendChild(card);
    })
}

const filterByCategory = (categoryId) => {
    activeCategoryId = (categoryId === 'all') ? null : parseInt(categoryId);

    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.classList.remove('active');
    });

    document.querySelector(`[data-category-id="${categoryId}"]`).classList.add('active');

    document.querySelector('.product-search').value = '';

    loadProductsByCategory(categoryId);
}

const filterProducts = () => {
    const searchInput = document.querySelector('.product-search').value.trim().toLowerCase();

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

const confirmDeletion = (product) => {
    document.getElementById('update-form-container')?.remove();

    document.getElementById('delete-product-container')?.remove();

    const confirmationContainer = document.createElement('div');

    confirmationContainer.id = 'delete-product-container';
    confirmationContainer.className = 'delete-product-container';
    confirmationContainer.innerHTML = `
    <div class="confirm-deletion-warning">
        <p><strong>!!! This action is irreversible !!!</strong></p>
        <p>By proceding with the deletion, you acknowledge that all information of the product (ID: ${product.ProductId}) in the database will be wiped completely and that you will be responsible for consequences derived from such action.</p>
        <button id="confirm-deletion-btn">Proceed <strong>(Delete)</strong></button>
        <button id="cancel-deletion-btn">I didn't mean that! <strong>(Cancel)</strong></button>
    </div>
    `;

    document.body.appendChild(confirmationContainer);

    document.getElementById('cancel-deletion-btn').addEventListener('click', () => {
        confirmationContainer.remove();
    });

    document.getElementById('confirm-deletion-btn').addEventListener('click', async () => {
        await handleProductDeletion(product.ProductId, confirmationContainer);
    });
}

const handleProductDeletion = async (productId, confirmationContainer) => {
    try {
        const response = await fetch(`${API_BASE}/delete_product/${productId}`, {
            method: 'DELETE',
        });

        if (!response.ok) throw new Error(`${response.error}`);

        const result = await response.json();
        console.log(result.message);

        confirmationContainer.remove();

        location.reload();

        alert(`Product ${productId} deleted successfully.`);
    } catch (err) {
        console.error('Error deleting product:', err);
        alert(`Error deleting product ${productId}: ${err.message}`);
    }
}

document.addEventListener("DOMContentLoaded", async () => {
    const ok = await checkAdminAccess();
    if (!ok) return;

    await fetchCategories();
    await loadProductsByCategory('all');

    const searchBtn = document.getElementById('search-product-btn');
    searchBtn.addEventListener('click', filterProducts);
});

// trong list_products.js
async function checkAdminAccess() {
    if (!userId) {
        alert('Bạn cần đăng nhập bằng tài khoản Admin / Store Manager');
        window.location.href = '/';
        return false;
    }

    const res = await fetch(`${API_BASE}/api/auth/check-admin?user_id=${userId}`);
    const data = await res.json();

    if (!data.is_admin && !data.is_sales_manager) {
        alert('Bạn không có quyền truy cập trang quản lý sản phẩm.');
        window.location.href = '/';
        return false;
    }
    return true;
}

const loadCreatePromotionSection = () => {
    document.getElementById('promotion-form-container')?.remove();

    const formContainer = document.createElement('div');
    formContainer.id = 'promotion-form-container';
    formContainer.className = 'update-form';

    formContainer.innerHTML = `
        <div class="update-form-modal">
            <h3>New Promotion</h3>
            <form id="promotion-create-form">
                
                <label for="promotion-type">Promotion type:</label>
                <input type="text" id="promotion-type" name="type" placeholder="E.g: Discount, Voucher" required><br>
                
                <label for="promotion-value">Value (in VND):</label>
                <input type="number" id="promotion-value" name="value"
                       placeholder=""
                       min="0" step="0.01" 
                       max="9999999999.99"  
                       required><br>
                
                <label for="start-period">Start date:</label>
                <input type="date" id="start-period" name="startDate" required><br>

                <label for="end-period">End date:</label>
                <input type="date" id="end-period" name="endDate" required><br>

                <button type="submit" id="confirm-promotion-btn">Create</button>
                <button type="button" id="cancel-promotion-btn">Cancel</button>
            </form>
        </div>
    `;

    document.body.appendChild(formContainer);

    document.getElementById('cancel-promotion-btn').addEventListener('click', () => {
        formContainer.remove();
    });

    document.getElementById('promotion-create-form').addEventListener('submit', (event) => {
        event.preventDefault();

        handlePromotionSubmit(formContainer);
    });
};

const handlePromotionSubmit = async (formContainer) => {
    const form = document.getElementById('promotion-create-form')

    const promotionData = {
        manager_id: userId,
        type: form.type.value,
        value: parseFloat(form.value.value),
        startDate: form.startDate.value,
        endDate: form.endDate.value,
    };

    try {
        const response = await fetch(`${API_BASE}/create_promotion`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(promotionData),
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Failed to create a promotion on server.')
        }

        alert('Promotion created updated successfully!');
        formContainer.remove();
    }
    catch (err) {
        console.error('Error updating product: ', err);
        alert(`Update failed: ${err.message}`);
        formContainer.remove();
    }
};

document.addEventListener("DOMContentLoaded", async () => {
    const ok = await checkAdminAccess();
    if (!ok) return;

    fetchCategories();
    loadProductsByCategory('all');

    const searchBtn = document.getElementById('search-product-btn');
    searchBtn.addEventListener('click', filterProducts);

    const newProductBtn = document.getElementById('new-product-btn');
    newProductBtn.addEventListener('click', () => {
        window.location.href = './new_product_form.html';
    })

    const newPromotionBtn = document.getElementById('new-promotion-btn');
    newPromotionBtn.addEventListener('click', loadCreatePromotionSection)
});
