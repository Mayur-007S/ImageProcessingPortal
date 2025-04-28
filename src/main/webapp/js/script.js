document.addEventListener('DOMContentLoaded', function() {
    // Function to check if image is already uploaded
    function checkImageUpload() {
        const uploadSuccess = document.querySelector('.alert.success');
        const encodeForm = document.getElementById('encodeForm');
        
        if (uploadSuccess) {
            // Enable encode form if image is uploaded
            encodeForm.classList.add('active');
        } else {
            // Disable encode form if no image is uploaded
            const submitButton = encodeForm.querySelector('button[type="submit"]');
            const inputs = encodeForm.querySelectorAll('input, textarea, select');
            
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.title = "Please upload an image first";
            }
            
            inputs.forEach(input => {
                input.disabled = true;
            });
            
            // Add info message
            const infoMessage = document.createElement('div');
            infoMessage.className = 'alert info';
            infoMessage.textContent = 'Please upload an image first before encoding a message.';
            encodeForm.prepend(infoMessage);
        }
    }
    
    // Message type selector logic
    const messageTypeSelect = document.getElementById('messageType');
    const messageInput = document.getElementById('message');
    
    if (messageTypeSelect && messageInput) {
        messageTypeSelect.addEventListener('change', function() {
            if (this.value === 'link') {
                messageInput.placeholder = "Enter a URL (e.g., https://www.example.com)";
                messageInput.pattern = "https?://.+";
                messageInput.title = "Please enter a valid URL starting with http:// or https://";
            } else {
                messageInput.placeholder = "Enter your message to hide in the image";
                messageInput.pattern = "";
                messageInput.title = "";
            }
        });
        
        // Trigger change event to set initial placeholder
        messageTypeSelect.dispatchEvent(new Event('change'));
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
            const messageInput = document.getElementById('message');
            const messageType = document.getElementById('messageType').value;
            
            if (!messageInput.value.trim()) {
                e.preventDefault();
                alert('Please enter a message to encode.');
                return false;
            }
            
            if (messageType === 'link' && !messageInput.value.trim().match(/^https?:\/\/.+/)) {
                e.preventDefault();
                alert('Please enter a valid URL starting with http:// or https://');
                return false;
            }
        });
    }
    
    // Call the function to check image upload status
    checkImageUpload();
});
