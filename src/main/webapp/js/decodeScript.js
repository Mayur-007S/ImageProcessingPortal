document.addEventListener('DOMContentLoaded', function() {
    // Form validation for image upload
    const decodeForm = document.getElementById('decodeForm');
    
    if (decodeForm) {
        decodeForm.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('imageToDecodeFile');
            
            if (!fileInput || !fileInput.files || fileInput.files.length === 0) {
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
                submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Decoding...';
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
                
                // Add file info display
                const fileInfoContainer = document.querySelector('.file-info');
                if (!fileInfoContainer) {
                    // Create file info display if it doesn't exist
                    const fileInfoDiv = document.createElement('div');
                    fileInfoDiv.className = 'file-info alert info';
                    fileInfoDiv.innerHTML = `<p><i class="fas fa-file-image"></i> <strong>Selected file:</strong> ${fileName} (${fileSize} KB)</p>`;
                    
                    // Find the form note element to insert after it
                    const formNote = document.querySelector('.form-note');
                    if (formNote && formNote.parentNode) {
                        formNote.parentNode.insertBefore(fileInfoDiv, formNote.nextSibling);
                    }
                } else {
                    // Update existing file info
                    fileInfoContainer.innerHTML = `<p><i class="fas fa-file-image"></i> <strong>Selected file:</strong> ${fileName} (${fileSize} KB)</p>`;
                }
            }
        });
    }
});