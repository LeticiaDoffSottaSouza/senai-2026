const navLinks = document.querySelectorAll('.site-header nav a');
const sections = document.querySelectorAll('main section[id]');
const revealItems = document.querySelectorAll('.section,.project-card,.timeline-card,.interest-grid article,.contact-box,.tcc-grid');

navLinks.forEach((link) => {
  link.addEventListener('click', (e) => {
    const id = link.getAttribute('href');
    if (!id.startsWith('#')) return;
    const target = document.querySelector(id);
    if (!target) return;
    e.preventDefault();
    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
});

const sectionObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (!entry.isIntersecting) return;
    navLinks.forEach((l) => l.classList.toggle('active', l.getAttribute('href') === `#${entry.target.id}`));
  });
}, { rootMargin: '-30% 0px -55% 0px' });
sections.forEach((s) => sectionObserver.observe(s));

revealItems.forEach((i) => i.classList.add('reveal'));
const revealObserver = new IntersectionObserver((entries, obs) => {
  entries.forEach((en) => {
    if (!en.isIntersecting) return;
    en.target.classList.add('visible');
    obs.unobserve(en.target);
  });
}, { threshold: 0.12 });
revealItems.forEach((i) => revealObserver.observe(i));