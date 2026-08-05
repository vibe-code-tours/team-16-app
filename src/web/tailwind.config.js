/**
 * @type {import('tailwindcss').Config}
 *
 * Border-radius token scale (5 tiers):
 *   sm  (6px)  — buttons, inputs, small interactive elements
 *   md  (12px) — cards, moderate containers
 *   lg  (16px) — large cards, panels
 *   xl  (24px) — hero sections, feature cards, empty states
 *   full (9999px) — badges, avatars, pills
 *
 * Usage: always pick the tier that matches the element's visual weight,
 * not an arbitrary pixel value. If in doubt, start with md.
 */
export default {
  darkMode: 'class',
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      borderRadius: {
        'sm': '0.375rem',    // 6px  — buttons, inputs, small interactive elements
        'md': '0.75rem',     // 12px — cards, moderate containers
        'lg': '1rem',        // 16px — large cards, panels
        'xl': '1.5rem',      // 24px — hero sections, feature cards, empty states
        'full': '9999px',    // badges, avatars, pills
      },
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
        },
        xp: {
          gold: '#fbbf24',
          green: '#22c55e',
        },
      },
    },
  },
  plugins: [],
}
