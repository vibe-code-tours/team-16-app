import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import type { TopicEngagement } from '../../../types'

interface TopicQuizChartProps {
  data: TopicEngagement[]
}

export function TopicQuizChart({ data }: TopicQuizChartProps) {
  if (data.length === 0) {
    return (
      <div className="flex h-64 items-center justify-center text-gray-500">
        No quiz data yet
      </div>
    )
  }

  return (
    <ResponsiveContainer width="100%" height={280}>
      <BarChart data={data} layout="vertical" margin={{ top: 5, right: 20, left: 80, bottom: 5 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" horizontal={false} />
        <XAxis
          type="number"
          allowDecimals={false}
          tick={{ fontSize: 12 }}
          tickLine={false}
          axisLine={{ stroke: '#d1d5db' }}
        />
        <YAxis
          type="category"
          dataKey="topicName"
          tick={{ fontSize: 12 }}
          tickLine={false}
          axisLine={{ stroke: '#d1d5db' }}
          width={75}
        />
        <Tooltip
          contentStyle={{
            backgroundColor: '#fff',
            border: '1px solid #e5e7eb',
            borderRadius: '8px',
            fontSize: '14px',
          }}
        />
        <Bar dataKey="quizCount" fill="#f59e0b" radius={[0, 4, 4, 0]} name="Quiz Count" />
      </BarChart>
    </ResponsiveContainer>
  )
}
