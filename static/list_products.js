let allProducts = [];

const loadProducts = async () => {
    try {
        const response = await fetch('/list_products');
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
            <div class="product-id">ID: ${product.id}</div>
            <div class="product-name">Name: ${product.name}</div>
            <div class="product-stock">Remaining stock: ${product.stock}</div>
        </div>
        `;

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
        p.name.toLowerCase().includes(searchInput)
    );

    renderProducts(filteredProducts);
}

document.addEventListener("DOMContentLoaded", () => {
    loadProducts();

    const searchBtn = document.getElementById('search-product-btn');
    searchBtn.addEventListener('click', filterProducts);
})