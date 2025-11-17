const API_BASE = 'http://127.0.0.1:5001';



const fetchCategories = async () => {
    const categorySelect = document.getElementById('category');

    try {
        const response = await fetch(`${API_BASE}/categories`);

        if (!response.ok) {
            throw new Error(`Failed to fetch categories. Status ${response.status}`);
        }

        const categories = await response.json();

        categories.forEach(category => {
            const option = document.createElement('option');
            option.value = category.CategoryId;
            option.textContent = category.Name;
            categorySelect.appendChild(option);
        });
    }
    catch (err) {
        console.error('Error fetching categories: ', err);

        const errorMessage = document.createElement('option');
        errorMessage.value = '';
        errorMessage.textContent = 'Failed to load categories';
        categorySelect.appendChild(errorMessage);
    }
}

const submitProduct = async () => {
    const name = document.getElementById('name').value.trim();
    const description = document.getElementById('description').value.trim();
    const price = parseFloat(document.getElementById('price').value);
    const stock = parseInt(document.getElementById('stock').value);
    const categoryId = document.getElementById('category').value;

    if (!name || !description || isNaN(price) || isNaN(stock) || !categoryId) {
        alert("Please fill in the form correctly.");
        return;
    }

    try {
        const response = await fetch(`${API_BASE}/add_product`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                Description: description,
                Name: name,
                Price: price,
                Stock: stock,
                CategoryId: categoryId
            })
        });

        const result = await response.json();

        if (response.ok) {
            alert(result.message);
            location.href = "list_products.html";
        }
        else {
            alert(`Error: ${result.error}`);
        }
    } catch (err) {
        console.error("Error submitting product: ", err);
        alert("An error occurred while trying to add the product.");
    }
};

document.addEventListener('DOMContentLoaded', () => {
    fetchCategories();

    const cancelProductBtn = document.getElementById('new-product-cancel-btn');
    cancelProductBtn.addEventListener('click', () => {
        location.href = "list_products.html";
    });

    const submitProductBtn = document.getElementById('new-product-confirm-btn');
    submitProductBtn.addEventListener('click', async (event) => {
        event.preventDefault();
        await submitProduct();
    })
})