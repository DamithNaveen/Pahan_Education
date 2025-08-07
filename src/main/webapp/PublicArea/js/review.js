document.addEventListener('DOMContentLoaded', function() {
    const testimonials = document.querySelectorAll('.testimonial');
    let currentIndex = 0;
    let interval;
    
    function showTestimonial(index) {
        // Hide all testimonials
        testimonials.forEach(testimonial => {
            testimonial.classList.remove('active');
        });
        
        // Show the selected one
        testimonials[index].classList.add('active');
    }
    
    function startSlider() {
        showTestimonial(currentIndex);
        interval = setInterval(() => {
            currentIndex = (currentIndex + 1) % testimonials.length;
            showTestimonial(currentIndex);
        }, 5000);
    }
    
    // Only initialize if testimonials exist
    if(testimonials.length > 0) {
        startSlider();
        
        // Pause on hover (optional)
        const slider = document.querySelector('.testimonial-slider');
        slider.addEventListener('mouseenter', () => clearInterval(interval));
        slider.addEventListener('mouseleave', startSlider);
    }
});