// ==================== Mobile Navigation Toggle ====================
document.addEventListener('DOMContentLoaded', function() {
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('navMenu');
    
    // Toggle mobile menu
    hamburger.addEventListener('click', function() {
        hamburger.classList.toggle('active');
        navMenu.classList.toggle('active');
    });

    // Close menu when a link is clicked
    const navLinks = navMenu.querySelectorAll('a');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            hamburger.classList.remove('active');
            navMenu.classList.remove('active');
        });
    });

    // Close menu when clicking outside
    document.addEventListener('click', function(event) {
        const isClickInsideNav = navMenu.contains(event.target);
        const isClickHamburger = hamburger.contains(event.target);
        
        if (!isClickInsideNav && !isClickHamburger && navMenu.classList.contains('active')) {
            hamburger.classList.remove('active');
            navMenu.classList.remove('active');
        }
    });
});

// ==================== Smooth Scrolling for Anchor Links ====================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href !== '#' && document.querySelector(href)) {
            e.preventDefault();
            const target = document.querySelector(href);
            const offsetTop = target.offsetTop - 80; // Adjust for sticky navbar
            window.scrollTo({
                top: offsetTop,
                behavior: 'smooth'
            });
        }
    });
});

// ==================== Contact Form Handling ====================
document.querySelector('.contact-form')?.addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Get form values
    const form = this;
    const name = form.querySelector('input[type="text"]').value;
    const email = form.querySelector('input[type="email"]').value;
    const message = form.querySelector('textarea').value;
    
    // Validate form
    if (name.trim() === '' || email.trim() === '' || message.trim() === '') {
        alert('Please fill in all fields');
        return;
    }
    
    // Validate email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address');
        return;
    }
    
    // Show success message
    alert(`Thank you ${name}! We've received your message and will get back to you soon.`);
    
    // Reset form
    form.reset();
});

// ==================== Scroll Animation for Elements ====================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Observe service cards and benefit items for fade-in animation
document.querySelectorAll('.service-card, .benefit-item').forEach(element => {
    element.style.opacity = '0';
    element.style.transform = 'translateY(20px)';
    element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(element);
});

// ==================== Active Navigation Link Highlight ====================
window.addEventListener('scroll', function() {
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('.nav-link');
    
    let current = '';
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        if (pageYOffset >= sectionTop - 200) {
            current = section.getAttribute('id');
        }
    });
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href').substring(1) === current) {
            link.style.color = 'var(--primary-yellow)';
        } else {
            link.style.color = 'var(--white)';
        }
    });
});

// ==================== Button Ripple Effect ====================
document.querySelectorAll('.btn').forEach(button => {
    button.addEventListener('click', function(e) {
        const ripple = document.createElement('span');
        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;
        
        ripple.style.width = ripple.style.height = size + 'px';
        ripple.style.left = x + 'px';
        ripple.style.top = y + 'px';
        ripple.classList.add('ripple');
        
        this.appendChild(ripple);
        
        setTimeout(() => ripple.remove(), 600);
    });
});

// ==================== Scroll Progress Indicator ====================
window.addEventListener('scroll', function() {
    const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
    const scrolled = (window.scrollY / scrollHeight) * 100;
    
    // You can use this for a progress bar if needed
    // Example: document.getElementById('progressBar').style.width = scrolled + '%';
});

// ==================== Add External Link Icons ====================
document.querySelectorAll('a[target="_blank"]').forEach(link => {
    // External links already have proper attributes
    // This is here for any additional styling or behavior
    link.setAttribute('rel', 'noopener noreferrer');
});

// ==================== Accessibility: Keyboard Navigation ====================
document.addEventListener('keydown', function(event) {
    // Close mobile menu on Escape key
    if (event.key === 'Escape') {
        const hamburger = document.getElementById('hamburger');
        const navMenu = document.getElementById('navMenu');
        if (navMenu.classList.contains('active')) {
            hamburger.classList.remove('active');
            navMenu.classList.remove('active');
        }
    }
});

// ==================== Performance: Lazy Load Images ====================
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.add('loaded');
                observer.unobserve(img);
            }
        });
    });
    
    document.querySelectorAll('img[data-src]').forEach(img => imageObserver.observe(img));
}

// ==================== Vehicle Search Form ====================
const vehicleSearchForm = document.getElementById('vehicleSearchForm');
if (vehicleSearchForm) {
    vehicleSearchForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const manufacturer = document.getElementById('manufacturer').value;
        const model = document.getElementById('model').value;
        const year = document.getElementById('year').value;
        const engine = document.getElementById('engine').value;
        
        if (manufacturer && model) {
            // Show results section
            const searchResults = document.getElementById('searchResults');
            const resultsList = document.getElementById('resultsList');
            const resultsText = document.getElementById('resultsText');
            
            resultsText.textContent = `Found tuning options for ${manufacturer.charAt(0).toUpperCase() + manufacturer.slice(1)} ${model}${year ? ' (' + year + ')' : ''}${engine ? ' - ' + engine : ''}`;
            
            // Sample results data
            const results = [
                {
                    title: 'Stage 1 Remapping',
                    desc: 'Performance boost with improved fuel economy',
                    bhp: '+15-25 BHP'
                },
                {
                    title: 'Stage 2 Tuning',
                    desc: 'Advanced tuning with bolt-on modifications',
                    bhp: '+30-50 BHP'
                },
                {
                    title: 'Stage 3 Performance',
                    desc: 'Maximum performance with custom optimization',
                    bhp: '+50+ BHP'
                }
            ];
            
            resultsList.innerHTML = results.map(result => `
                <div class="result-item">
                    <h4>${result.title}</h4>
                    <p>${result.desc}</p>
                    <p><strong>Estimated Gain: ${result.bhp}</strong></p>
                    <a href="contact.html" class="btn btn-primary btn-small" style="display: inline-block; margin-top: 0.5rem;">Get Quote</a>
                </div>
            `).join('');
            
            searchResults.style.display = 'block';
            searchResults.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    });
}

console.log('AutoDiag website initialized successfully');
