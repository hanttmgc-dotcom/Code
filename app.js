// Page Navigation
function showPage(pageId) {
    // Hide all pages
    const pages = document.querySelectorAll('.page');
    pages.forEach(page => page.classList.remove('active'));

    // Show selected page
    const selectedPage = document.getElementById(pageId);
    if (selectedPage) {
        selectedPage.classList.add('active');
    }

    // Update navigation links
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => link.classList.remove('active'));
    event.target.classList.add('active');

    // Scroll to top
    window.scrollTo(0, 0);
}

// Initialize
window.addEventListener('load', () => {
    // Set home page as active
    showPage('home');
});
