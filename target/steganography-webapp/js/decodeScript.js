document.addEventListener('DOMContentLoaded', function() {
    // Form validation for image upload
    const decodeForm = document.getElementById('decodeForm');
    
    if (decodeForm) {
        decodeForm.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('imageToDecodeFile');
            
            if (!fileInput.files || fileInput.files.length === 0) {
                e.preventDefault();
                alert('Please select an image file to decode.');
                return false;
            }
            
            const file = fileInput.files[0];
            if (!file.type.startsWith('image/')) {
                e.preventDefault();
                alert('Please select a valid image file.');
                return false;
            }
            
            // Show loading indicator or message if needed
            const submitButton = decodeForm.querySelector('button[type="submit"]');
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.innerHTML = 'Decoding...';
            }
        });
    }
    
    // Image preview functionality
    const fileInput = document.getElementById('imageToDecodeFile');
    if (fileInput) {
        fileInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                // Could add image preview functionality here if desired
                const fileName = this.files[0].name;
                const fileSize = Math.round(this.files[0].size / 1024); // Convert to KB
                
                // You could display file info if needed
                console.log(`Selected file: ${fileName} (${fileSize} KB)`);
            }
        });
    }
});