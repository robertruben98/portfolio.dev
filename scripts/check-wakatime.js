#!/usr/bin/env node

/**
 * Script de verificación de configuración de WakaTime
 * Ejecuta: node scripts/check-wakatime.js
 */

import { config } from 'dotenv'
import { readFileSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

// Cargar variables de entorno
config({ path: join(__dirname, '..', '.env') })

console.log('🔍 Verificando configuración de WakaTime...\n')

let errors = 0
let warnings = 0

// 1. Verificar que existe .env
try {
  readFileSync(join(__dirname, '..', '.env'), 'utf8')
  console.log('✅ Archivo .env encontrado')
} catch (error) {
  console.log('❌ Archivo .env NO encontrado')
  console.log('   Solución: cp .env.example .env')
  errors++
}

// 2. Verificar PUBLIC_WAKATIME_USERNAME
const username = process.env.PUBLIC_WAKATIME_USERNAME
if (username && username !== 'tu-usuario-wakatime') {
  console.log(`✅ PUBLIC_WAKATIME_USERNAME configurado: ${username}`)
} else {
  console.log('⚠️  PUBLIC_WAKATIME_USERNAME no configurado o usa valor por defecto')
  console.log('   Edita .env y agrega: PUBLIC_WAKATIME_USERNAME=tu-usuario')
  warnings++
}

// 3. Verificar WAKATIME_API_KEY
const apiKey = process.env.WAKATIME_API_KEY
if (apiKey && apiKey.startsWith('waka_') && apiKey.length > 20) {
  console.log('✅ WAKATIME_API_KEY configurada correctamente')
} else if (apiKey && apiKey !== 'waka_your_secret_api_key_here') {
  console.log('⚠️  WAKATIME_API_KEY parece incorrecta (debe empezar con waka_)')
  warnings++
} else {
  console.log('⚠️  WAKATIME_API_KEY no configurada')
  console.log('   Obtén tu key en: https://wakatime.com/settings/api-key')
  console.log('   Nota: Los badges funcionan sin API key, pero tendrás datos limitados')
  warnings++
}

// 4. Verificar que los componentes existen
const components = [
  'src/components/WakaTimeStats.astro',
  'src/components/WakaTimeBadge.astro',
  'src/components/WakaTimeEmbed.astro',
]

components.forEach(component => {
  try {
    readFileSync(join(__dirname, '..', component), 'utf8')
    console.log(`✅ ${component.split('/').pop()} encontrado`)
  } catch (error) {
    console.log(`❌ ${component.split('/').pop()} NO encontrado`)
    errors++
  }
})

// 5. Verificar src/lib/wakatime.ts
try {
  readFileSync(join(__dirname, '..', 'src/lib/wakatime.ts'), 'utf8')
  console.log('✅ src/lib/wakatime.ts encontrado')
} catch (error) {
  console.log('❌ src/lib/wakatime.ts NO encontrado')
  errors++
}

// 6. Test de conectividad (opcional)
if (apiKey && apiKey.startsWith('waka_')) {
  console.log('\n🌐 Probando conexión con WakaTime API...')
  
  fetch('https://wakatime.com/api/v1/users/current/stats/last_7_days', {
    headers: {
      'Authorization': `Bearer ${apiKey}`
    }
  })
    .then(res => {
      if (res.ok) {
        console.log('✅ Conexión con WakaTime API exitosa')
        return res.json()
      } else {
        throw new Error(`HTTP ${res.status}`)
      }
    })
    .then(data => {
      if (data.data) {
        console.log(`✅ Datos obtenidos: ${data.data.human_readable_total} de código`)
        console.log(`   Mejor día: ${data.data.best_day.text}`)
        console.log(`   Lenguaje principal: ${data.data.languages[0]?.name || 'N/A'}`)
      }
    })
    .catch(error => {
      console.log(`❌ Error conectando con WakaTime API: ${error.message}`)
      console.log('   Verifica que tu API key es correcta')
      errors++
    })
}

// Resumen
console.log('\n' + '='.repeat(50))
if (errors === 0 && warnings === 0) {
  console.log('🎉 ¡Todo configurado correctamente!')
  console.log('\nPróximos pasos:')
  console.log('1. npm run dev')
  console.log('2. Abre http://localhost:4321')
  console.log('3. Agrega WakaTimeStats a tu index.astro')
} else {
  console.log(`⚠️  Configuración incompleta:`)
  console.log(`   - Errores: ${errors}`)
  console.log(`   - Advertencias: ${warnings}`)
  console.log('\nRevisa las instrucciones arriba para corregir los problemas.')
  console.log('Documentación: docs/WAKATIME_SETUP.md')
}
console.log('='.repeat(50))

process.exit(errors > 0 ? 1 : 0)
