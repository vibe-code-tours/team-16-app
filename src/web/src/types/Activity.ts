/** One day of learner activity from GET /api/v1/me/activity (oldest first). */
export interface DailyActivity {
  /** ISO date, `YYYY-MM-DD`. */
  date: string
  questionsAnswered: number
  xpEarned: number
}
