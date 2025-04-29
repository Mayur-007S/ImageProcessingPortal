document.addEventListener('DOMContentLoaded', function() {
    // Function to check if image is already uploaded
    function checkImageUpload() {
        const uploadSuccess = document.querySelector('.alert.success');
        const encodeForm = document.getElementById('encodeForm');
        
        // Only proceed if encodeForm exists on the page
        if (!encodeForm) return;
        
        if (uploadSuccess) {
            // Enable encode form if image is uploaded
            encodeForm.classList.add('active');
            // Enable encoding type select
            const encodingTypeSelect = document.getElementById('encodingType');
            if (encodingTypeSelect) {
                encodingTypeSelect.disabled = false;
            }
            // Enable encode button
            const encodeButton = document.getElementById('encodeButton');
            if (encodeButton) {
                encodeButton.disabled = true; // Still disabled until a type is selected
            }
        } else {
            // Disable encode form if no image is uploaded
            const encodingTypeSelect = document.getElementById('encodingType');
            const encodeButton = document.getElementById('encodeButton');
            
            if (encodeForm) {
                const allInputs = encodeForm.querySelectorAll('input, textarea, select');
                
                if (encodingTypeSelect) {
                    encodingTypeSelect.disabled = true;
                }
                
                if (encodeButton) {
                    encodeButton.disabled = true;
                    encodeButton.title = "Please upload an image first";
                }
                
                if (allInputs) {
                    allInputs.forEach(input => {
                        input.disabled = true;
                    });
                }
                
                // Add info message
                const infoMessage = document.createElement('div');
                infoMessage.className = 'alert info';
                infoMessage.textContent = 'Please upload an image first before encoding data.';
                
                // Remove existing info message if present
                const existingInfo = encodeForm.querySelector('.alert.info');
                if (existingInfo) {
                    existingInfo.remove();
                }
                
                encodeForm.prepend(infoMessage);
            }
        }
    }
    
    // Function to show the appropriate encoding form
    window.showEncodingForm = function() {
        // Get all form divs
        const encodingForms = document.querySelectorAll('.encoding-form');
        const encodingTypeElement = document.getElementById('encodingType');
        
        if (!encodingTypeElement) return; // Exit if element doesn't exist
        
        const encodingType = encodingTypeElement.value;
        const encodeButton = document.getElementById('encodeButton');
        
        // Hide all forms first
        if (encodingForms && encodingForms.length > 0) {
            encodingForms.forEach(form => {
                form.style.display = 'none';
            });
        }
        
        // Show the selected form if a type is selected
        if (encodingType) {
            const selectedForm = document.getElementById(encodingType + 'EncodingForm');
            if (selectedForm && encodeButton) {
                selectedForm.style.display = 'block';
                encodeButton.disabled = false;
            }
        } else if (encodeButton) {
            encodeButton.disabled = true;
        }
    }
    
    // Form validation
    const uploadForm = document.getElementById('uploadForm');
    const encodeForm = document.getElementById('encodeForm');
    
    if (uploadForm) {
        uploadForm.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('image');
            
            if (!fileInput.files || fileInput.files.length === 0) {
                e.preventDefault();
                alert('Please select an image file to upload.');
                return false;
            }
            
            const file = fileInput.files[0];
            if (!file.type.startsWith('image/')) {
                e.preventDefault();
                alert('Please select a valid image file.');
                return false;
            }
        });
    }
    
    if (encodeForm) {
        encodeForm.addEventListener('submit', function(e) {
            const encodingType = document.getElementById('encodingType').value;
            
            if (!encodingType) {
                e.preventDefault();
                alert('Please select an encoding type.');
                return false;
            }
            
            // Validate based on encoding type
            switch (encodingType) {
                case 'text':
                    const textMessage = document.getElementById('textMessage').value.trim();
                    if (!textMessage) {
                        e.preventDefault();
                        alert('Please enter a text message to encode.');
                        return false;
                    }
                    break;
                    
                case 'link':
                    const linkUrl = document.getElementById('linkUrl').value.trim();
                    if (!linkUrl) {
                        e.preventDefault();
                        alert('Please enter a URL to encode.');
                        return false;
                    }
                    if (!linkUrl.match(/^https?:\/\/.+/)) {
                        e.preventDefault();
                        alert('Please enter a valid URL starting with http:// or https://');
                        return false;
                    }
                    break;
                    
                case 'file':
                case 'video':
                case 'apk':
                case 'malware':
                    const fileInputId = encodingType + 'Upload';
                    const fileInput = document.getElementById(fileInputId);
                    if (!fileInput.files || fileInput.files.length === 0) {
                        e.preventDefault();
                        alert('Please select a file to encode.');
                        return false;
                    }
                    break;
            }
        });
    }
    
    // Call the function to check image upload status
    checkImageUpload();
});
