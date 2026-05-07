document.addEventListener('click', function(e) {
    const tgLink = e.target.closest('.social-network__telegram');
    if (tgLink) {
        tracker.track('tgclick');
    }
});