// const navScrollHandler = () => {
//     let prevScrollPos = window.scrollY;
//     let visible = true;
//     let atTop = true;
//
//     const navigation = document.getElementById('navigation');
//     const SCROLL_THRESHOLD = 10;
//
//     const handleScroll = () => {
//         const currentScrollPos = window.scrollY;
//         const scrollingUp = prevScrollPos > currentScrollPos;
//
//         visible = scrollingUp || currentScrollPos < SCROLL_THRESHOLD;
//         atTop = currentScrollPos <= SCROLL_THRESHOLD;
//
//         navigation.classList.toggle('nav_scrolled', !atTop);
//         navigation.classList.toggle('nav_pinned', !atTop && visible);
//
//         prevScrollPos = currentScrollPos;
//     };
//
//     window.addEventListener('scroll', handleScroll, { passive: true });
// }
//
// window.addEventListener('load', navScrollHandler);