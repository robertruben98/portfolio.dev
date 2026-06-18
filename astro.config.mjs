import { defineConfig } from 'astro/config'

import robotsTxt from "astro-robots-txt"

// https://astro.build/config
export default defineConfig({
  integrations: [
    robotsTxt({
      sitemap: [
        'https://www.a-robertdev.com/sitemap.xml'
      ],
      policy: [
        {
          userAgent: '*',
          allow: '/',
        },
        {
          userAgent: 'AhrefsBot',
          crawlDelay: 5,
        },
        {
          userAgent: 'SemrushBot',
          crawlDelay: 5,
        }
      ]
    })
  ],
  site: 'https://www.a-robertdev.com/'
})
