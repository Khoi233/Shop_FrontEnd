let allProducts = [];

const createUpdateForm = (product) => {
    document.getElementById('update-form-container')?.remove();

    const formContainer = document.createElement('div');

    formContainer.id = 'update-form-container';

    formContainer.className = 'update-form';

    formContainer.innerHTML = `
    <div class="update-form-modal">
            <h3>Update product: ${product.Name} (ID: ${product.ID})</h3>
            <form id="product-update-form">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${product.Name}" required><br>
                
                <label for="description">Description:</label>
                <textarea id="description" name="description" required>${product.Description}</textarea><br>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" value="${product.Price}" min="0" step="0.01" required><br>

                <label for="stock">Remaining Stock:</label>
                <input type="number" id="stock" name="stock" min="0" value="${product.Stock}" required><br>

                <button type="submit" id="confirm-changes-btn">Confirm Changes</button>
                <button type="button" id="cancel-update-btn">Cancel</button>
            </form>
        </div>
    `;

    document.body.appendChild(formContainer);

    document.getElementById('cancel-update-btn').addEventListener('click', () => {
        formContainer.remove();
    });

    document.getElementById('product-update-form').addEventListener('submit', (event) => {
        event.preventDefault();
        handleUpdateSubmit(product.ProductId, formContainer);
    });
}

const handleUpdateSubmit = async (productId, formContainer) => {
    const form = document.getElementById('product-update-form');
    const updatedData = {
        Description: form.description.value,
        Name: form.name.value,
        Price: parseFloat(form.price.value),
        ProductId: productId,
        Stock: parseInt(form.stock.value)
    }

    try {
        const response = await fetch('http://127.0.0.1:5000/update_product', {
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
        formContainer.remove(); // Close form
        loadProducts(); // Reload products to show updated data
    }
    catch (err) {
        console.error('Error updating product: ', err);
        alert(`Update failed: ${err.message}`);
        formContainer.remove(); // Close form
    }
}

const loadProducts = async () => {
    try {
        const response = await fetch('http://127.0.0.1:5000/list_products');
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

const renderProducts = (products) => {
    console.log("Rendering...");
    const container = document.getElementById('product-list');
    container.innerHTML = '';

    if (products.length === 0) {
        container.innerHTML = '<p style="text-align:center;">No products found.</p>';
        return;
    }

    products.forEach((product) => {
        const card = document.createElement('div');
        card.className = 'product-card';

        card.innerHTML = `
        <div className="product-details">
            <div class="product-id">ID: ${product.ProductId}</div>
            <div class="product-name">Name: ${product.Name}</div>
            <div class="product-description">Description: ${product.Description}</div>
            <div class="product-price">Price: ${product.Price}</div>
            <div class="product-stock">Remaining stock: ${product.Stock}</div>
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

        container.appendChild(card);
    })
}

const filterProducts = () => {
    const searchInput = document.querySelector('.product-search').value.trim().toLowerCase();

    if (!searchInput) {
        renderProducts(allProducts);
        return;
    }

    const filteredProducts = allProducts.filter(p => 
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
        const response = await fetch(`http://127.0.0.1:5000/delete_product/${productId}`, {
            method: 'DELETE',
        });

        if (!response.ok) throw new Error(`Failed to delete product ${productId}`);

        // Optionally get response text or JSON
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

document.addEventListener("DOMContentLoaded", () => {
    loadProducts();

    const searchBtn = document.getElementById('search-product-btn');
    searchBtn.addEventListener('click', filterProducts);

    const newProductBtn = document.getElementById('new-product-btn');
    newProductBtn.addEventListener('click', () => {
        location.href = "new_product_form.html";
    })
})