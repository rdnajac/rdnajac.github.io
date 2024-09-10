document.addEventListener('DOMContentLoaded', (event) => {
    document.body.addEventListener('click', function(e) {
        // Check if the clicked element is an anchor tag
        if (e.target.tagName === 'A') {
            const href = e.target.getAttribute('href');
            
            // Check if the link is internal
            if (href && href.startsWith('/') && !href.startsWith('//') && !e.target.getAttribute('download')) {
                e.preventDefault();
                const currentScroll = window.pageYOffset;
                
                // Use pushState to change the URL without reloading the page
                history.pushState(null, '', href);
                
                // Fetch the content of the new page
                fetch(href)
                    .then(response => response.text())
                    .then(html => {
                        // Parse the HTML and replace the content
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        document.body.innerHTML = doc.body.innerHTML;
                        
                        // Update the page title
                        document.title = doc.title;
                        
                        // Restore the scroll position
                        window.scrollTo(0, currentScroll);
                        
                        // Re-run any necessary scripts
                        document.dispatchEvent(new Event('DOMContentLoaded'));
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Fallback to normal navigation if fetch fails
                        window.location.href = href;
                    });
            }
        }
    });

    // Handle browser back/forward navigation
    window.addEventListener('popstate', function(e) {
        location.reload();
    });
});
