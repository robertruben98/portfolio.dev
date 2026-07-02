import { defineConfig } from 'astro/config'

import robotsTxt from "astro-robots-txt"
import sitemap from "@astrojs/sitemap"

// https://astro.build/config
export default defineConfig({
  integrations: [
    sitemap(),
    robotsTxt({
      sitemap: [
        'https://www.a-robertdev.com/sitemap-index.xml'
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
