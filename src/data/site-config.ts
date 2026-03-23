import type { SiteConfig } from '../types';

const siteConfig: SiteConfig = {
    website: 'https://amiheines.com',
    title: 'Ami Heines',
    subtitle: 'Tamper-Proof Infrastructure & Private Blockchain Consulting',
    description:
        'I help companies build tamper-proof record-keeping and fraud prevention infrastructure using private blockchain technology. From proof-of-concept to production.',
    headerNavLinks: [
        {
            text: 'Home',
            href: '/'
        },
        {
            text: 'Services',
            href: '/services'
        },
        {
            text: 'Portfolio',
            href: '/portfolio'
        },
        {
            text: 'Blog',
            href: '/blog'
        },
        {
            text: 'Contact',
            href: '/contact'
        }
    ],
    footerNavLinks: [
        {
            text: 'About',
            href: '/about'
        },
        {
            text: 'Newsletter',
            href: '/newsletter'
        },
        {
            text: 'Resources',
            href: '/resources'
        },
        {
            text: 'Terms',
            href: '/terms'
        }
    ],
    socialLinks: [
        {
            text: 'LinkedIn',
            href: 'https://www.linkedin.com/in/ami-heines/'
        },
        {
            text: 'YouTube',
            href: 'https://www.youtube.com/@pofov'
        },
        {
            text: 'GitHub',
            href: 'https://github.com/amiheines'
        }
    ],
    hero: {
        title: 'Tamper-Proof Records. Fraud Prevention. Private Blockchain.',
        text: "Your sysadmin shouldn't be able to edit your audit logs. Your database should prove it hasn't been tampered with. I build the infrastructure that makes this possible — private blockchain systems that give you **immutable records**, **cryptographic verification**, and **complete data sovereignty**.\n\nNo tokens. No crypto speculation. Just bulletproof record-keeping for companies that can't afford data integrity failures.",
        actions: [
            {
                text: 'Book a Discovery Call',
                href: '/contact'
            },
            {
                text: 'View My Work',
                href: '/portfolio'
            }
        ]
    },
    subscribe: {
        enabled: true,
        title: 'Get the Weekly Blockchain Infrastructure Brief',
        text: 'Practical insights on tamper-proof systems, fraud prevention, and private blockchain — no hype, no tokens. One email per week.',
        form: {
            action: '/api/subscribe'
        }
    },
    postsPerPage: 8,
    projectsPerPage: 8,
    listmonk: {
        url: 'https://lists.amiheines.com',
        listUuid: '2f2d523d-5b13-48d1-8018-0c4f42078a27'
    },
    matomo: {
        url: 'https://matomo.amiheines.com',
        siteId: '1'
    }
};

export default siteConfig;
