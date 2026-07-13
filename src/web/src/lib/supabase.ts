import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabasePublishableKey = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY
  || import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabasePublishableKey) {
  throw new Error(
    'Missing Supabase browser configuration. Set VITE_SUPABASE_URL and VITE_SUPABASE_PUBLISHABLE_KEY.',
  )
}

if (supabasePublishableKey.startsWith('sb_secret_')) {
  throw new Error(
    'VITE_SUPABASE_PUBLISHABLE_KEY must be a publishable key, never an sb_secret_ key. Copy the publishable key from Supabase Project Settings > API Keys.',
  )
}

export const supabase = createClient(supabaseUrl, supabasePublishableKey)
