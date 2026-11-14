/** One achievement from `GET /api/v1/me/achievements`. `progress` is capped at `target`. */
export interface Achievement {
  id: string
  title: string
  description: string
  icon: string
  unlocked: boolean
  progress: number
  target: number
}
