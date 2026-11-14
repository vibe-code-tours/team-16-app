/** One day of activity from GET /api/v1/me/activity. `date` is an ISO date (yyyy-mm-dd). */
export interface DailyActivity {
  date: string
  questionsAnswered: number
  xpEarned: number
}
