import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import { useTheme } from '../../../hooks/useTheme'
import type { DailyActiveUsers } from '../../../types'

interface ActiveUsersChartProps {
  data: DailyActiveUsers[]
}

export function ActiveUsersChart({ data }: ActiveUsersChartProps) {
  const { theme } = useTheme()
  const isDark = theme === 'dark'

  if (data.length === 0) {
    return (
      <div className="flex h-64 items-center justify-center text-gray-500 dark:text-gray-400">
        No activity data yet
      </div>
    )
  }

  const formatted = data.map((d) => ({
    ...d,
    label: new Date(d.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }),
  }))

  return (
    <ResponsiveContainer width="100%" height={280}>
      <LineChart data={formatted} margin={{ top: 5, right: 20, left: 0, bottom: 5 }}>
        <CartesianGrid strokeDasharray="3 3" stroke={isDark ? '#374151' : '#e5e7eb'} />
        <XAxis
          dataKey="label"
          tick={{ fontSize: 12, fill: isDark ? '#9ca3af' : '#374151' }}
          tickLine={false}
          axisLine={{ stroke: isDark ? '#4b5563' : '#d1d5db' }}
        />
        <YAxis
          allowDecimals={false}
          tick={{ fontSize: 12, fill: isDark ? '#9ca3af' : '#374151' }}
          tickLine={false}
          axisLine={{ stroke: isDark ? '#4b5563' : '#d1d5db' }}
        />
        <Tooltip
          contentStyle={{
            backgroundColor: isDark ? '#1f2937' : '#fff',
            border: `1px solid ${isDark ? '#374151' : '#e5e7eb'}`,
            borderRadius: '8px',
            fontSize: '14px',
            color: isDark ? '#f3f4f6' : '#111827',
          }}
        />
        <Line
          type="monotone"
          dataKey="activeUsers"
          stroke="#0ea5e9"
          strokeWidth={2}
          dot={{ fill: '#0ea5e9', r: 3 }}
          activeDot={{ r: 5 }}
          name="Active Users"
        />
      </LineChart>
    </ResponsiveContainer>
  )
}
