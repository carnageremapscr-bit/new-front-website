// ==================== Carnage Remaps - Enhanced Animations & Interactions ====================

// Smooth scroll animation observer
const observerOptions = {
    root: null,
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const animateOnScroll = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animated');
        }
    });
}, observerOptions);

// Initialize animations when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    initScrollAnimations();
    initNavbarEffects();
    initButtonEffects();
    initCounterAnimations();
    initParallaxEffects();
    initCursorGlow();
    initTypingEffect();
    initScrollProgress();
});

// ==================== Scroll Animations ====================
function initScrollAnimations() {
    // Add animation classes to elements
    const sections = document.querySelectorAll('section');
    sections.forEach((section, index) => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';
        section.style.transition = 'opacity 0.8s ease-out, transform 0.8s ease-out';
        
        setTimeout(() => {
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }, index * 100);
    });

    // Animate cards
    const cards = document.querySelectorAll('.featured-card, .location-service-card, .benefit-item, .addon-item, .stage-card');
    cards.forEach(card => {
        animateOnScroll.observe(card);
    });

    // Animate headings
    const headings = document.querySelectorAll('h2, h3');
    headings.forEach(heading => {
        heading.classList.add('animate-on-scroll');
        animateOnScroll.observe(heading);
    });
}

// ==================== Navbar Effects ====================
function initNavbarEffects() {
    const navbar = document.querySelector('.navbar');
    let lastScroll = 0;

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        // Add shadow and blur when scrolling
        if (currentScroll > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }

        // Hide navbar on scroll down, show on scroll up
        if (currentScroll > lastScroll && currentScroll > 500) {
            navbar.style.transform = 'translateY(-100%)';
        } else {
            navbar.style.transform = 'translateY(0)';
        }

        lastScroll = currentScroll;
    });

    // Smooth active link highlighting
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('mouseenter', function() {
            this.style.color = '#f5c400';
            this.style.transform = 'translateY(-2px)';
        });
        
        link.addEventListener('mouseleave', function() {
            if (!this.classList.contains('active')) {
                this.style.color = '#ffffff';
                this.style.transform = 'translateY(0)';
            }
        });
    });
}

// ==================== Button Effects ====================
function initButtonEffects() {
    const buttons = document.querySelectorAll('.btn');
    
    buttons.forEach(button => {
        // Ripple effect on click
        button.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            ripple.classList.add('ripple');
            this.appendChild(ripple);

            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';

            setTimeout(() => ripple.remove(), 600);
        });

        // Magnetic effect
        button.addEventListener('mousemove', function(e) {
            const rect = this.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            
            this.style.transform = `translate(${x * 0.1}px, ${y * 0.1}px) scale(1.05)`;
        });

        button.addEventListener('mouseleave', function() {
            this.style.transform = 'translate(0, 0) scale(1)';
        });
    });
}

// ==================== Counter Animations ====================
function initCounterAnimations() {
    const counters = document.querySelectorAll('.stat-number');
    
    counters.forEach(counter => {
        const target = counter.textContent.replace(/[^0-9]/g, '');
        if (target && !isNaN(target)) {
            let current = 0;
            const increment = parseInt(target) / 50;
            const suffix = counter.textContent.replace(/[0-9]/g, '');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= parseInt(target)) {
                                counter.textContent = target + suffix;
                                clearInterval(timer);
                            } else {
                                counter.textContent = Math.floor(current) + suffix;
                            }
                        }, 20);
                        observer.unobserve(counter);
                    }
                });
            });
            
            observer.observe(counter);
        }
    });
}

// ==================== Parallax Effects ====================
function initParallaxEffects() {
    const parallaxElements = document.querySelectorAll('.hero, .about-image, .stats-img');
    
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        
        parallaxElements.forEach(element => {
            if (element.classList.contains('hero')) {
                element.style.backgroundPositionY = scrolled * 0.5 + 'px';
            } else {
                const rect = element.getBoundingClientRect();
                if (rect.top < window.innerHeight && rect.bottom > 0) {
                    const offset = (window.innerHeight - rect.top) * 0.1;
                    element.style.transform = `translateY(${offset}px)`;
                }
            }
        });
    });
}

// ==================== Cursor Glow Effect ====================
function initCursorGlow() {
    // Create cursor glow element
    const cursorGlow = document.createElement('div');
    cursorGlow.className = 'cursor-glow';
    document.body.appendChild(cursorGlow);

    // Update cursor glow position
    document.addEventListener('mousemove', (e) => {
        cursorGlow.style.left = e.clientX + 'px';
        cursorGlow.style.top = e.clientY + 'px';
    });

    // Add glow on interactive elements
    const interactiveElements = document.querySelectorAll('a, button, .featured-card, .location-service-card');
    interactiveElements.forEach(element => {
        element.addEventListener('mouseenter', () => {
            cursorGlow.style.transform = 'scale(2)';
            cursorGlow.style.opacity = '0.6';
        });
        
        element.addEventListener('mouseleave', () => {
            cursorGlow.style.transform = 'scale(1)';
            cursorGlow.style.opacity = '0.3';
        });
    });
}

// ==================== Typing Effect for Hero ====================
function initTypingEffect() {
    const heroSubtitle = document.querySelector('.hero-subtitle');
    if (heroSubtitle && !heroSubtitle.dataset.typed) {
        const originalText = heroSubtitle.textContent;
        heroSubtitle.textContent = '';
        heroSubtitle.dataset.typed = 'true';
        let i = 0;
        
        const typeWriter = () => {
            if (i < originalText.length) {
                heroSubtitle.textContent += originalText.charAt(i);
                i++;
                setTimeout(typeWriter, 50);
            }
        };
        
        setTimeout(typeWriter, 1000);
    }
}

// ==================== Card Tilt Effect ====================
document.querySelectorAll('.featured-card, .location-service-card').forEach(card => {
    card.addEventListener('mousemove', function(e) {
        const rect = this.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        
        const rotateX = (y - centerY) / 10;
        const rotateY = (centerX - x) / 10;
        
        this.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-10px)`;
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) translateY(0)';
    });
});

// ==================== Smooth Scroll ====================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href !== '#' && href.length > 1) {
            e.preventDefault();
            const target = document.querySelector(href);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        }
    });
});

// ==================== Loading Animation ====================
window.addEventListener('load', () => {
    document.body.classList.add('loaded');
    
    // Fade in page content
    const content = document.querySelector('body');
    content.style.opacity = '0';
    setTimeout(() => {
        content.style.transition = 'opacity 0.5s ease-in';
        content.style.opacity = '1';
    }, 100);
});

// ==================== Image Lazy Loading with Animation ====================
const imageObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const img = entry.target;
            img.style.opacity = '0';
            img.style.transition = 'opacity 0.5s ease-in';
            
            if (img.dataset.src) {
                img.src = img.dataset.src;
            }
            
            img.onload = () => {
                img.style.opacity = '1';
            };
            
            imageObserver.unobserve(img);
        }
    });
});

document.querySelectorAll('img[loading="lazy"]').forEach(img => {
    imageObserver.observe(img);
});

// ==================== Scroll Progress Bar ====================
function initScrollProgress() {
    const progressBar = document.getElementById('scrollProgress');
    
    if (progressBar) {
        window.addEventListener('scroll', () => {
            const windowHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight;
            const scrolled = (window.pageYOffset / windowHeight) * 100;
            progressBar.style.width = scrolled + '%';
        });
    }
}

// ==================== Additional Enhancements ====================

// Add smooth reveal to sections
const revealSections = () => {
    const sections = document.querySelectorAll('section');
    const revealPoint = 150;
    
    sections.forEach(section => {
        const sectionTop = section.getBoundingClientRect().top;
        const windowHeight = window.innerHeight;
        
        if (sectionTop < windowHeight - revealPoint) {
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }
    });
};

window.addEventListener('scroll', revealSections);

// Add glow to headings on scroll
const glowHeadings = () => {
    const headings = document.querySelectorAll('h1, h2');
    
    headings.forEach(heading => {
        if (!heading.dataset.text) {
            heading.dataset.text = heading.textContent;
        }
    });
};

glowHeadings();
