const submitProduct = async () => {
    const name = document.getElementById('name').value.trim();
    const description = document.getElementById('description').value.trim();
    const price = parseFloat(document.getElementById('price').value);
    const stock = parseInt(document.getElementById('stock').value);

    if (!name || !description || isNaN(price) || isNaN(stock)) {
        alert("Please fill in the form correctly.");
        return;
    }

    try {
        const response = await fetch('http://127.0.0.1:5000/add_product', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                Description: description,
                Name: name,
                Price: price,
                Stock: stock
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